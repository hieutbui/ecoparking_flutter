import 'dart:async';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/services/account_service.dart';
import 'package:ecoparking_flutter/domain/services/booking_service.dart';
import 'package:ecoparking_flutter/domain/services/parking_service.dart';
import 'package:ecoparking_flutter/domain/state/user_favorite_parkings/add_favorite_parking_state.dart';
import 'package:ecoparking_flutter/domain/state/user_favorite_parkings/remove_favorite_parking_state.dart';
import 'package:ecoparking_flutter/domain/usecase/user_favorite_parkings/add_favorite_parking_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/user_favorite_parkings/remove_favorite_parking_interactor.dart';
import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:ecoparking_flutter/model/parking/shift_price.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/model/parking_fee_types.dart';
import 'package:ecoparking_flutter/pages/parking_details/parking_details_view.dart';
import 'package:ecoparking_flutter/resource/image_paths.dart';
import 'package:ecoparking_flutter/utils/dialog_utils.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

class ParkingDetails extends StatefulWidget {
  const ParkingDetails({
    super.key,
  });

  @override
  ParkingDetailsController createState() => ParkingDetailsController();
}

class ParkingDetailsController extends State<ParkingDetails>
    with ControllerLoggy {
  final AddFavoriteParkingInteractor _addFavoriteParkingInteractor =
      getIt.get<AddFavoriteParkingInteractor>();
  final RemoveFavoriteParkingInteractor _removeFavoriteParkingInteractor =
      getIt.get<RemoveFavoriteParkingInteractor>();

  final ParkingService _parkingService = getIt.get<ParkingService>();
  final BookingService _bookingService = getIt.get<BookingService>();
  final AccountService _accountService = getIt.get<AccountService>();

  final ValueNotifier<AddFavoriteParkingState> addFavoriteParkingNotifier =
      ValueNotifier<AddFavoriteParkingState>(const AddFavoriteParkingInitial());
  final ValueNotifier<RemoveFavoriteParkingState>
      removeFavoriteParkingNotifier = ValueNotifier<RemoveFavoriteParkingState>(
          const RemoveFavoriteParkingInitial());

  final ValueNotifier<bool> isFavorite = ValueNotifier<bool>(false);

  Parking? get parking => _parkingService.selectedParking;

  StreamSubscription? _addFavoriteParkingSubscription;
  StreamSubscription? _removeFavoriteParkingSubscription;

  @override
  void initState() {
    super.initState();
    _initializeFavorite();
  }

  @override
  void dispose() {
    _cancelSubscriptions();
    _disposeNotifiers();
    super.dispose();
  }

  void _cancelSubscriptions() {
    _addFavoriteParkingSubscription?.cancel();
    _removeFavoriteParkingSubscription?.cancel();
    _addFavoriteParkingSubscription = null;
    _removeFavoriteParkingSubscription = null;
  }

  void _disposeNotifiers() {
    addFavoriteParkingNotifier.dispose();
    removeFavoriteParkingNotifier.dispose();
  }

  void _initializeFavorite() {
    final profile = _accountService.profile;

    if (profile != null) {
      final favoriteParkings = profile.favoriteParkings;

      if (favoriteParkings != null) {
        isFavorite.value = favoriteParkings.contains(parking?.id);
      }
    }
  }

  List<Widget>? buildShiftPrices() {
    final pricePerHour = parking?.pricePerHour;

    if (pricePerHour == null) {
      return null;
    }

    return pricePerHour
        .map(
          (shiftPrice) => GFListTile(
            titleText:
                '${shiftPrice.startTime.format(context)} - ${shiftPrice.endTime.format(context)}',
            subTitleText: shiftPrice.price.toString(),
            icon: const Icon(Icons.monetization_on),
            onTap: () => onPressedShiftPrice(shiftPrice),
          ),
        )
        .toList();
  }

  void onPressedBookMark() {
    loggy.info('Book mark tapped');

    final profile = _accountService.profile;

    if (profile == null) {
      DialogUtils.showRequiredLogin(context);
    } else {
      final phone = profile.phone;

      if (phone == null || phone.isEmpty) {
        DialogUtils.showRequiredFillProfile(context);

        NavigationUtils.navigateTo(
          context: context,
          path: AppPaths.profile,
        );
      } else {
        final currentParking = parking;

        if (currentParking != null) {
          final favoriteParkings = profile.favoriteParkings;

          if (favoriteParkings == null) {
            _addFavoriteParkings(
              parkingId: currentParking.id,
              userId: profile.id,
            );
          } else {
            if (favoriteParkings.contains(currentParking.id)) {
              _removeFavoriteParkings(
                parkingId: currentParking.id,
                userId: profile.id,
              );
            } else {
              _addFavoriteParkings(
                parkingId: currentParking.id,
                userId: profile.id,
              );
            }
          }
        }
      }
    }
  }

  void _removeFavoriteParkings({
    required String parkingId,
    required String userId,
  }) {
    _removeFavoriteParkingSubscription = _removeFavoriteParkingInteractor
        .execute(
          parkingId: parkingId,
          userId: userId,
        )
        .listen(
          (result) => result.fold(
            _handleRemoveFavoriteParkingFailure,
            _handleRemoveFavoriteParkingSuccess,
          ),
        );
  }

  void _addFavoriteParkings({
    required String parkingId,
    required String userId,
  }) {
    _addFavoriteParkingSubscription = _addFavoriteParkingInteractor
        .execute(
          parkingId: parkingId,
          userId: userId,
        )
        .listen(
          (result) => result.fold(
            _handleAddFavoriteParkingFailure,
            _handleAddFavoriteParkingSuccess,
          ),
        );
  }

  void onPressedShiftPrice(ShiftPrice shift) {
    loggy.info('Shift price tapped: $shift');

    _showBookParkingDetails(ParkingFeeTypes.hourly);

    return;
  }

  void onPressedLongTermPrice(ParkingFeeTypes type) {
    loggy.info('Long term price tapped: $type');

    _showBookParkingDetails(type);

    return;
  }

  void _showBookParkingDetails(ParkingFeeTypes type) {
    loggy.info('navigate to book parking details: $type');
    final profile = _accountService.profile;

    switch (type) {
      case ParkingFeeTypes.hourly:
        if (profile == null) {
          DialogUtils.showRequiredLogin(context);
        } else if (profile.phone == null || profile.phone!.isEmpty) {
          DialogUtils.showRequiredFillProfile(context);
        } else {
          if (parking != null) {
            _bookingService.setParking(parking!);
          }
          _bookingService.setParkingFeeType(ParkingFeeTypes.hourly);
        }

        NavigationUtils.navigateTo(
          context: context,
          path: AppPaths.bookingDetails,
        );
      case ParkingFeeTypes.daily:
        if (profile == null) {
          DialogUtils.showRequiredLogin(context);
        } else if (profile.phone == null || profile.phone!.isEmpty) {
          DialogUtils.showRequiredFillProfile(context);
        } else {
          if (parking != null) {
            _bookingService.setParking(parking!);
          }
          _bookingService.setParkingFeeType(ParkingFeeTypes.daily);
        }

        NavigationUtils.navigateTo(
          context: context,
          path: AppPaths.bookingDetails,
        );
        break;
      case ParkingFeeTypes.monthly:
      case ParkingFeeTypes.annually:
        DialogUtils.show(
          context: context,
          actions: (context) {
            return <Widget>[
              ActionButton(
                type: ActionButtonType.positive,
                label: 'OK',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ];
          },
          image: ImagePaths.imgOnlinePayment,
          title: 'Long Term Fee',
          customDescription: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: 'Please contact parking owner for more information\n',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                //TODO: Format phone number
                TextSpan(
                  text: parking?.phone,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
        );
        break;
    }

    return;
  }

  void onPressedBookNow() {
    loggy.info('Book now tapped');

    final profile = _accountService.profile;

    if (profile == null) {
      DialogUtils.showRequiredLogin(context);
    } else if (profile.phone == null || profile.phone!.isEmpty) {
      DialogUtils.showRequiredFillProfile(context);
    } else {
      if (parking != null) {
        _bookingService.setParking(parking!);
      }
      _bookingService.setParkingFeeType(ParkingFeeTypes.hourly);
    }

    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.bookingDetails,
    );
    return;
  }

  void onPressedCancel() {
    loggy.info('Cancelled tapped');
    NavigationUtils.goBack(context);
    return;
  }

  void onBackButtonPressed(BuildContext scaffoldContext) {
    loggy.info('onBackButtonPressed()');
    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.home,
    );
  }

  void _handleAddFavoriteParkingSuccess(Success success) {
    loggy.info('_handleAddFavoriteParkingSuccess(): $success');
    if (success is AddFavoriteParkingSuccess) {
      addFavoriteParkingNotifier.value = success;

      if (success.response.status == 'success') {
        isFavorite.value = true;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Added to favorite'),
        ),
      );
    } else if (success is AddFavoriteParkingLoading) {
      addFavoriteParkingNotifier.value = success;
    }
  }

  void _handleAddFavoriteParkingFailure(Failure failure) {
    loggy.error('_handleAddFavoriteParkingFailure(): $failure');
    if (failure is AddFavoriteParkingFailure) {
      addFavoriteParkingNotifier.value = failure;
    } else if (failure is AddFavoriteParkingEmpty) {
      addFavoriteParkingNotifier.value = failure;
    } else {
      addFavoriteParkingNotifier.value =
          AddFavoriteParkingFailure(exception: failure);
    }
  }

  void _handleRemoveFavoriteParkingSuccess(Success success) {
    loggy.info('_handleRemoveFavoriteParkingSuccess(): $success');
    if (success is RemoveFavoriteParkingSuccess) {
      removeFavoriteParkingNotifier.value = success;

      if (success.response.status == 'success') {
        isFavorite.value = false;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Removed from favorite'),
        ),
      );
    } else if (success is RemoveFavoriteParkingLoading) {
      removeFavoriteParkingNotifier.value = success;
    }
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
  }

  @override
  Widget build(BuildContext context) => ParkingDetailsView(controller: this);
}
