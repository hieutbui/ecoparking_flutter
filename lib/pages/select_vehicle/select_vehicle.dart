import 'dart:async';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/services/account_service.dart';
import 'package:ecoparking_flutter/domain/services/booking_service.dart';
import 'package:ecoparking_flutter/domain/state/vehicles/get_user_vehicles_state.dart';
import 'package:ecoparking_flutter/domain/usecase/vehicles/user_vehicles_interactor.dart';
import 'package:ecoparking_flutter/pages/select_vehicle/select_vehicle_view.dart';
import 'package:ecoparking_flutter/utils/dialog_utils.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class SelectVehicle extends StatefulWidget {
  const SelectVehicle({super.key});

  @override
  SelectVehicleController createState() => SelectVehicleController();
}

class SelectVehicleController extends State<SelectVehicle>
    with ControllerLoggy {
  final UserVehiclesInteractor _userVehiclesInteractor =
      getIt.get<UserVehiclesInteractor>();

  final BookingService _bookingService = getIt.get<BookingService>();
  final AccountService _accountService = getIt.get<AccountService>();

  final userVehiclesNotifier = ValueNotifier<GetUserVehiclesState>(
    const GetUserVehiclesInitial(),
  );
  final selectedVehicleId = ValueNotifier<String?>(null);

  StreamSubscription? _userVehiclesSubscription;

  @override
  void initState() {
    super.initState();
    _getUserVehicles();
  }

  @override
  void dispose() {
    super.dispose();
    _userVehiclesSubscription?.cancel();
    selectedVehicleId.value = null;
    _userVehiclesSubscription = null;
    userVehiclesNotifier.dispose();
    selectedVehicleId.dispose();
  }

  void onBackButtonPressed(BuildContext scaffoldContext) {
    loggy.info('Back button pressed');
    NavigationUtils.navigateTo(
      context: scaffoldContext,
      path: AppPaths.bookingDetails,
    );
  }

  _getUserVehicles() async {
    _userVehiclesSubscription = _userVehiclesInteractor.execute().listen(
      (event) {
        event.fold(
          (failure) => _handleGetUserVehiclesFailure(failure),
          (success) => _handleGetUserVehiclesSuccess(success),
        );
      },
    );
  }

  void _handleGetUserVehiclesFailure(Failure failure) {
    loggy.error('_handleGetUserVehiclesFailure(): $failure');
    if (failure is GetUserVehiclesFailure) {
      userVehiclesNotifier.value = failure;
    } else {
      userVehiclesNotifier.value = const GetUserVehiclesIsEmpty();
    }
  }

  void _handleGetUserVehiclesSuccess(Success success) {
    loggy.info('_handleGetUserVehiclesSuccess(): $success');
    if (success is GetUserVehiclesSuccess) {
      userVehiclesNotifier.value = success;
    } else {
      userVehiclesNotifier.value = const GetUserVehiclesIsEmpty();
    }
  }

  void selectVehicle(String vehicleId) {
    loggy.info('selectVehicle(): $vehicleId');
    selectedVehicleId.value = vehicleId;
    if (userVehiclesNotifier.value is GetUserVehiclesSuccess) {
      _bookingService.setVehicle(
        (userVehiclesNotifier.value as GetUserVehiclesSuccess)
            .vehicles
            .firstWhere((vehicle) => vehicle.id == vehicleId),
      );
    }
  }

  void onPressedContinue() {
    loggy.info('Select Vehicle tapped');

    final profile = _accountService.profile;

    if (profile == null) {
      DialogUtils.showRequiredLogin(context);
    } else if (profile.phone == null || profile.phone!.isEmpty) {
      DialogUtils.showRequiredFillProfile(context);
    }

    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.reviewSummary,
    );
  }

  @override
  Widget build(BuildContext context) => SelectVehicleView(controller: this);
}
