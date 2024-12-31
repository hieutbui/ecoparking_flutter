import 'dart:async';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/di/supabase_utils.dart';
import 'package:ecoparking_flutter/domain/services/account_service.dart';
import 'package:ecoparking_flutter/domain/state/profile/get_profile_state.dart';
import 'package:ecoparking_flutter/domain/state/user_favorite_parkings/get_user_favorite_parkings.dart';
import 'package:ecoparking_flutter/domain/state/user_favorite_parkings/remove_favorite_parking_state.dart';
import 'package:ecoparking_flutter/domain/usecase/profile/get_profile_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/user_favorite_parkings/remove_favorite_parking_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/user_favorite_parkings/user_favorite_parkings_interactor.dart';
import 'package:ecoparking_flutter/model/account/favorite_parking.dart';
import 'package:ecoparking_flutter/pages/saved/saved_view.dart';
import 'package:ecoparking_flutter/utils/dialog_utils.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:flutter/material.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  SavedController createState() => SavedController();
}

class SavedController extends State<SavedPage> with ControllerLoggy {
  final UserFavoriteParkingsInteractor _userFavoriteParkingsInteractor =
      getIt.get<UserFavoriteParkingsInteractor>();
  final RemoveFavoriteParkingInteractor _removeFavoriteParkingInteractor =
      getIt.get<RemoveFavoriteParkingInteractor>();
  final GetProfileInteractor _getProfileInteractor =
      getIt.get<GetProfileInteractor>();

  final AccountService _accountService = getIt.get<AccountService>();

  final userFavoriteParkingsNotifier =
      ValueNotifier<GetUserFavoriteParkingsState>(
    const GetUserFavoriteParkingsInitial(),
  );
  final removeFavoriteParkingNotifier =
      ValueNotifier<RemoveFavoriteParkingState>(
    const RemoveFavoriteParkingInitial(),
  );
  final profileNotifier = ValueNotifier<GetProfileState>(
    const GetProfileInitial(),
  );

  StreamSubscription? _userFavoriteParkingsSubscription;
  StreamSubscription? _removeFavoriteParkingSubscription;
  StreamSubscription? _getProfileSubscription;

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  void dispose() {
    _cancelSubscriptions();
    _disposeNotifiers();
    super.dispose();
  }

  void _cancelSubscriptions() {
    _userFavoriteParkingsSubscription?.cancel();
    _removeFavoriteParkingSubscription?.cancel();
    _getProfileSubscription?.cancel();
    _userFavoriteParkingsSubscription = null;
    _removeFavoriteParkingSubscription = null;
    _getProfileSubscription = null;
  }

  void _disposeNotifiers() {
    userFavoriteParkingsNotifier.dispose();
    removeFavoriteParkingNotifier.dispose();
    profileNotifier.dispose();
  }

  void _getProfile() {
    loggy.info('_getUserProfile()');

    final user = _accountService.user ?? SupabaseUtils().auth.currentUser;
    final userId = user?.id;

    if (userId == null) {
      loggy.error('_getUserProfile(): user is null');
      return;
    }

    _getProfileSubscription = _getProfileInteractor.execute(userId).listen(
          (result) => result.fold(
            _handleGetProfileFailure,
            _handleGetProfileSuccess,
          ),
        );
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

  void onRemoveFavoriteParking(FavoriteParking favoriteParking) {
    loggy.info('onRemoveFavoriteParking()');
    final profile = _accountService.profile;

    if (profile == null) {
      DialogUtils.showRequiredLogin(context);

      NavigationUtils.navigateTo(
        context: context,
        path: AppPaths.profile,
      );

      return;
    } else {
      final phone = profile.phone;

      if (phone == null || phone.isEmpty) {
        DialogUtils.showRequiredFillProfile(context);

        NavigationUtils.navigateTo(
          context: context,
          path: AppPaths.profile,
        );

        return;
      }
    }

    final favoriteParkings = profile.favoriteParkings;

    if (favoriteParkings == null) {
      loggy.error('Favorite parkings is null');
      return;
    }

    DialogUtils.show(
      context: context,
      title: 'Xoá bãi đỗ yêu thích',
      description:
          'Bạn có chắc chắn muốn xoá bãi đỗ ${favoriteParking.parkingName} khỏi danh sách yêu thích?',
      actions: (context) => <Widget>[
        ActionButton(
          type: ActionButtonType.negative,
          label: 'Cancel',
          onPressed: () => DialogUtils.hide(context),
        ),
        const SizedBox(height: 8.0),
        ActionButton(
          type: ActionButtonType.positive,
          label: 'Remove',
          onPressed: () {
            _removeFavoriteParking(
              userId: profile.id,
              parkingId: favoriteParking.id,
            );
            DialogUtils.hide(context);
          },
        ),
      ],
    );
  }

  void _removeFavoriteParking({
    required String userId,
    required String parkingId,
  }) {
    _removeFavoriteParkingSubscription = _removeFavoriteParkingInteractor
        .execute(
          userId: userId,
          parkingId: parkingId,
        )
        .listen(
          (result) => result.fold(
            _handleRemoveFavoriteParkingFailure,
            _handleRemoveFavoriteParkingSuccess,
          ),
        );
  }

  void _handleGetUserFavoriteParkingsFailure(Failure failure) {
    loggy.error('_handleGetUserFavoriteParkingsFailure(): $failure');
    if (failure is GetUserFavoriteParkingsFailure) {
      userFavoriteParkingsNotifier.value = failure;
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
    } else if (success is GetUserFavoriteParkingsInitial) {
      userFavoriteParkingsNotifier.value = success;
    }

    return;
  }

  void _handleRemoveFavoriteParkingFailure(Failure failure) {
    loggy.error('_handleRemoveFavoriteParkingFailure(): $failure');
    if (failure is RemoveFavoriteParkingFailure) {
      removeFavoriteParkingNotifier.value = failure;
    } else if (failure is RemoveFavoriteParkingEmpty) {
      removeFavoriteParkingNotifier.value = failure;
    } else {
      removeFavoriteParkingNotifier.value =
          RemoveFavoriteParkingFailure(exception: failure);
    }

    return;
  }

  void _handleRemoveFavoriteParkingSuccess(Success success) {
    loggy.info('_handleRemoveFavoriteParkingSuccess(): $success');
    if (success is RemoveFavoriteParkingSuccess) {
      removeFavoriteParkingNotifier.value = success;

      _getProfile();
    } else if (success is RemoveFavoriteParkingLoading) {
      removeFavoriteParkingNotifier.value = success;
    }

    return;
  }

  void _handleGetProfileFailure(Failure failure) {
    loggy.error('handleGetProfileFailure(): $failure');

    if (failure is GetProfileFailure) {
      loggy.error(
        'handleGetProfileFailure():: GetProfileFailure',
      );
      profileNotifier.value = failure;
    } else if (failure is GetProfileEmptyProfile) {
      profileNotifier.value = failure;
    } else {
      loggy.error('handleGetProfileFailure():: Unknown failure');
      profileNotifier.value = GetProfileFailure(exception: failure);
    }
  }

  void _handleGetProfileSuccess(Success success) {
    loggy.info('handleGetProfileSuccess(): $success');
    if (success is GetProfileSuccess) {
      profileNotifier.value = success;

      _accountService.setProfile(success.profile);

      _getUserFavoriteParkings();
    }

    return;
  }

  @override
  Widget build(BuildContext context) => SavedPageView(controller: this);
}
