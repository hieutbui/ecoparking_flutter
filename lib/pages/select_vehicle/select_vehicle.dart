import 'dart:async';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/services/account_service.dart';
import 'package:ecoparking_flutter/domain/services/booking_service.dart';
import 'package:ecoparking_flutter/domain/state/vehicles/add_new_vehicle_state.dart';
import 'package:ecoparking_flutter/domain/state/vehicles/get_user_vehicles_state.dart';
import 'package:ecoparking_flutter/domain/usecase/vehicles/add_new_vehicle_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/vehicles/user_vehicles_interactor.dart';
import 'package:ecoparking_flutter/pages/select_vehicle/select_vehicle_view.dart';
import 'package:ecoparking_flutter/utils/dialog_utils.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:ecoparking_flutter/widgets/text_input_row/text_input_row.dart';
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
  final AddNewVehicleInteractor _addNewVehicleInteractor =
      getIt.get<AddNewVehicleInteractor>();

  final BookingService _bookingService = getIt.get<BookingService>();
  final AccountService _accountService = getIt.get<AccountService>();

  final ValueNotifier userVehiclesNotifier =
      ValueNotifier<GetUserVehiclesState>(
    const GetUserVehiclesInitial(),
  );
  final ValueNotifier addVehicleNotifier = ValueNotifier<AddNewVehicleState>(
    const AddNewVehicleInitial(),
  );

  final ValueNotifier selectedVehicleId = ValueNotifier<String?>(null);

  final newVehicleNameController = TextEditingController();
  final newVehicleLicensePlateController = TextEditingController();

  StreamSubscription? _userVehiclesSubscription;
  StreamSubscription? _addVehicleSubscription;

  @override
  void initState() {
    super.initState();
    _getUserVehicles();
  }

  @override
  void dispose() {
    _cancelSubscriptions();
    _disposeNotifiers();
    super.dispose();
  }

  void _cancelSubscriptions() {
    _userVehiclesSubscription?.cancel();
    _addVehicleSubscription?.cancel();
    _userVehiclesSubscription = null;
    _addVehicleSubscription = null;
  }

  void _disposeNotifiers() {
    userVehiclesNotifier.dispose();
    addVehicleNotifier.dispose();
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

  void onAddNewVehicle() {
    loggy.info('onAddNewVehicle()');

    DialogUtils.showCustomDialog(
      context: context,
      child: (dialogContext) {
        return Dialog(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: Container(
              padding: const EdgeInsets.all(16),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Add New Vehicle',
                          style: Theme.of(dialogContext)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                color:
                                    Theme.of(dialogContext).colorScheme.primary,
                              ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Please enter the details of your vehicle',
                          style: Theme.of(dialogContext)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color: Theme.of(dialogContext)
                                    .colorScheme
                                    .onSurface,
                              ),
                        ),
                        const SizedBox(height: 22),
                        TextInputRow(
                          controller: newVehicleNameController,
                          hintText: 'Vehicle Name',
                        ),
                        const SizedBox(height: 12),
                        TextInputRow(
                          controller: newVehicleLicensePlateController,
                          hintText: 'License Plate',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Column(
                    children: <Widget>[
                      ActionButton(
                        type: ActionButtonType.positive,
                        label: 'Add Vehicle',
                        onPressed: () {
                          _addNewVehicle(
                            name: newVehicleNameController.text,
                            licensePlate: newVehicleLicensePlateController.text,
                          );
                          Navigator.of(dialogContext).pop();
                        },
                      ),
                      const SizedBox(height: 8.0),
                      ActionButton(
                        type: ActionButtonType.negative,
                        label: 'Cancel',
                        onPressed: () => Navigator.of(dialogContext).pop(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _addNewVehicle({
    required String name,
    required String licensePlate,
  }) {
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

    _addVehicleSubscription = _addNewVehicleInteractor
        .execute(
          name: name,
          licensePlate: licensePlate,
          userId: profile.id,
        )
        .listen(
          (result) => result.fold(
            _handleAddNewVehicleFailure,
            _handleAddNewVehicleSuccess,
          ),
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

  void _handleAddNewVehicleFailure(Failure failure) {
    loggy.error('_handleAddNewVehicleFailure(): $failure');
    if (failure is AddNewVehicleFailure) {
      addVehicleNotifier.value = failure;
    } else if (failure is AddNewVehicleIsEmpty) {
      addVehicleNotifier.value = failure;
    } else {
      addVehicleNotifier.value = AddNewVehicleFailure(exception: failure);
    }
  }

  void _handleAddNewVehicleSuccess(Success success) {
    loggy.info('_handleAddNewVehicleSuccess(): $success');
    if (success is AddNewVehicleSuccess) {
      addVehicleNotifier.value = success;

      _getUserVehicles();

      selectedVehicleId.value = success.vehicle.id;
      _bookingService.setVehicle(success.vehicle);
    } else if (success is AddNewVehicleLoading) {
      addVehicleNotifier.value = success;
    }
  }

  @override
  Widget build(BuildContext context) => SelectVehicleView(controller: this);
}
