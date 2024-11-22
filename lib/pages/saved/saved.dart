import 'dart:async';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/services/account_service.dart';
import 'package:ecoparking_flutter/domain/state/user_favorite_parkings/get_user_favorite_parkings.dart';
import 'package:ecoparking_flutter/domain/usecase/user_favorite_parkings/user_favorite_parkings_interactor.dart';
import 'package:ecoparking_flutter/pages/saved/saved_view.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:flutter/material.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  SavedController createState() => SavedController();
}

class SavedController extends State<SavedPage> with ControllerLoggy {
  final UserFavoriteParkingsInteractor _userFavoriteParkingsInteractor =
      getIt.get<UserFavoriteParkingsInteractor>();
  final AccountService _accountService = getIt.get<AccountService>();

  final userFavoriteParkingsNotifier =
      ValueNotifier<GetUserFavoriteParkingsState>(
    const GetUserFavoriteParkingsInitial(),
  );

  StreamSubscription? _userFavoriteParkingsSubscription;

  @override
  void initState() {
    super.initState();
    _getUserFavoriteParkings();
  }

  @override
  void dispose() {
    _userFavoriteParkingsSubscription?.cancel();
    _userFavoriteParkingsSubscription = null;
    userFavoriteParkingsNotifier.dispose();
    super.dispose();
  }

  void _getUserFavoriteParkings() async {
    loggy.info('_getUserFavoriteParkings()');
    final favoriteParkings = _accountService.profile?.favoriteParkings;

    if (favoriteParkings == null) {
      userFavoriteParkingsNotifier.value =
          const GetUserFavoriteParkingsIsEmpty();
      return;
    }

    _userFavoriteParkingsSubscription =
        _userFavoriteParkingsInteractor.execute(favoriteParkings).listen(
              (event) => event.fold(
                (failure) => _handleGetUserFavoriteParkingsFailure(failure),
                (success) => _handleGetUserFavoriteParkingsSuccess(success),
              ),
            );

    return;
  }

  void _handleGetUserFavoriteParkingsFailure(Failure failure) {
    loggy.error('_handleGetUserFavoriteParkingsFailure(): $failure');
    if (failure is GetUserFavoriteParkingsFailure) {
      userFavoriteParkingsNotifier.value = failure;
    } else if (failure is GetUserFavoriteParkingsIsEmpty) {
      userFavoriteParkingsNotifier.value =
          const GetUserFavoriteParkingsIsEmpty();
    }

    return;
  }

  void _handleGetUserFavoriteParkingsSuccess(Success success) {
    loggy.info('_handleGetUserFavoriteParkingsSuccess(): $success');
    if (success is GetUserFavoriteParkingsSuccess) {
      userFavoriteParkingsNotifier.value = success;
    } else if (success is GetUserFavoriteParkingsIsEmpty) {
      userFavoriteParkingsNotifier.value =
          const GetUserFavoriteParkingsIsEmpty();
    }

    return;
  }

  @override
  Widget build(BuildContext context) => SavedPageView(controller: this);
}
