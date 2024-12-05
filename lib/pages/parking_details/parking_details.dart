import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/services/account_service.dart';
import 'package:ecoparking_flutter/domain/services/booking_service.dart';
import 'package:ecoparking_flutter/domain/services/parking_service.dart';
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
  final ParkingService _parkingService = getIt.get<ParkingService>();
  final BookingService _bookingService = getIt.get<BookingService>();
  final AccountService _accountService = getIt.get<AccountService>();

  Parking? get parking => _parkingService.selectedParking;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
    switch (type) {
      case ParkingFeeTypes.hourly:
        if (_accountService.profile == null) {
          DialogUtils.showRequiredLogin(context);
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
        if (_accountService.profile == null) {
          DialogUtils.showRequiredLogin(context);
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

    if (_accountService.profile == null) {
      DialogUtils.showRequiredLogin(context);
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

  @override
  Widget build(BuildContext context) => ParkingDetailsView(controller: this);
}
