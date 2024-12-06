import 'package:ecoparking_flutter/domain/services/account_service.dart';
import 'package:ecoparking_flutter/domain/services/booking_service.dart';
import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:ecoparking_flutter/model/parking/shift_price.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/book_parking_details.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/model/calculated_fee.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/model/parking_fee_types.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/model/selection_hour_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geobase/geobase.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'book_parking_details_test.mocks.dart';

@GenerateMocks([BookingService])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockBookingService bookingService;

  setUpAll(() {
    bookingService = MockBookingService();
    final getIt = GetIt.instance;
    getIt.registerSingleton<BookingService>(bookingService);
    getIt.registerSingleton(AccountService());
  });

  group(
    '[BookParkingDetails] TEST',
    () {
      group(
        '[_calculatedPrice] TEST\n',
        () {
          final dummyParking = Parking(
            id: '1',
            parkingName: 'Parking 1',
            address: 'Address 1',
            geolocation: Point(
              Position.create(
                x: 1.0,
                y: 1.0,
              ),
            ),
            totalSlot: 10,
            availableSlot: 5,
            pricePerHour: [
              ShiftPrice(
                shiftType: ShiftType.morning,
                startTime: const TimeOfDay(hour: 8, minute: 0),
                endTime: const TimeOfDay(hour: 17, minute: 0),
                price: 100000,
              ),
              ShiftPrice(
                shiftType: ShiftType.afternoon,
                startTime: const TimeOfDay(hour: 17, minute: 0),
                endTime: const TimeOfDay(hour: 24, minute: 0),
                price: 200000,
              ),
              ShiftPrice(
                shiftType: ShiftType.night,
                startTime: const TimeOfDay(hour: 24, minute: 0),
                endTime: const TimeOfDay(hour: 8, minute: 0),
                price: 300000,
              ),
            ],
          );

          Future<void> runTest({
            required WidgetTester tester,
            required double expectedPrice,
            required ParkingFeeTypes parkingFeeType,
            required TimeOfDay startTime,
            required TimeOfDay endTime,
            required int hours,
          }) async {
            when(bookingService.parking).thenReturn(dummyParking);

            when(bookingService.parkingFeeType).thenReturn(parkingFeeType);

            await tester.pumpWidget(const MaterialApp(
              home: Scaffold(
                body: BookParkingDetails(),
              ),
            ));

            final BookParkingDetailsController controller =
                tester.state(find.byType(BookParkingDetails));

            controller.onSelectionHour(
              startTime,
              SelectionHourTypes.start,
            );

            controller.onSelectionHour(
              endTime,
              SelectionHourTypes.end,
            );

            expect(controller.calculatedPrice, isNotNull);
            expect(controller.calculatedPrice.value, isNotNull);
            expect(controller.calculatedPrice.value, isA<CalculatedFee>());
            expect(controller.calculatedPrice.value?.hours, equals(hours));
            expect(
              controller.calculatedPrice.value?.parkingFeeType,
              isA<ParkingFeeTypes>(),
            );
            expect(
              controller.calculatedPrice.value?.parkingFeeType,
              equals(parkingFeeType),
            );
            expect(
              controller.calculatedPrice.value?.total,
              equals(expectedPrice),
            );
          }

          testWidgets(
            'GIVEN user selected time is inside 1 shift\n'
            'AND start time is 8:00, end time is 10:00\n'
            'AND the shift price is 100000\n'
            'THEN the price should be the shift price multiplied by hours: 100000 * 2 = 200000\n',
            (WidgetTester tester) async {
              const expectedPrice = 200000.0;

              runTest(
                tester: tester,
                expectedPrice: expectedPrice,
                parkingFeeType: ParkingFeeTypes.hourly,
                startTime: const TimeOfDay(hour: 8, minute: 0),
                endTime: const TimeOfDay(hour: 10, minute: 0),
                hours: 2,
              );
            },
          );

          testWidgets(
            'GIVEN user selected time is inside 2 shifts\n'
            'AND start time is 8:00, end time is 20:00\n'
            'AND the shift price is 100000 for morning and 200000 for afternoon\n'
            'THEN the price should be the sum of shift prices multiplied by hours: (100000 * 9) + (200000 * 3) = 1500000\n',
            (WidgetTester tester) async {
              const expectedPrice = 1500000.0;

              runTest(
                tester: tester,
                expectedPrice: expectedPrice,
                parkingFeeType: ParkingFeeTypes.hourly,
                startTime: const TimeOfDay(hour: 8, minute: 0),
                endTime: const TimeOfDay(hour: 20, minute: 0),
                hours: 12,
              );
            },
          );
        },
      );
    },
  );
}
