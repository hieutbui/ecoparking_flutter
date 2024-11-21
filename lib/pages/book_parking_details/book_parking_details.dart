import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/services/booking_service.dart';
import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:ecoparking_flutter/model/parking/shift_price.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/book_parking_details_view.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/model/calculated_fee.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/model/parking_fee_types.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/model/selection_hour_types.dart';
import 'package:ecoparking_flutter/pages/select_vehicle/models/price_arguments.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookParkingDetails extends StatefulWidget {
  const BookParkingDetails({super.key});

  @override
  BookParkingDetailsController createState() => BookParkingDetailsController();
}

class BookParkingDetailsController extends State<BookParkingDetails>
    with ControllerLoggy, TickerProviderStateMixin {
  static const selectableHour = <TimeOfDay>[
    TimeOfDay(hour: 0, minute: 0),
    TimeOfDay(hour: 1, minute: 0),
    TimeOfDay(hour: 2, minute: 0),
    TimeOfDay(hour: 3, minute: 0),
    TimeOfDay(hour: 4, minute: 0),
    TimeOfDay(hour: 5, minute: 0),
    TimeOfDay(hour: 6, minute: 0),
    TimeOfDay(hour: 7, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 9, minute: 0),
    TimeOfDay(hour: 10, minute: 0),
    TimeOfDay(hour: 11, minute: 0),
    TimeOfDay(hour: 12, minute: 0),
    TimeOfDay(hour: 13, minute: 0),
    TimeOfDay(hour: 14, minute: 0),
    TimeOfDay(hour: 15, minute: 0),
    TimeOfDay(hour: 16, minute: 0),
    TimeOfDay(hour: 17, minute: 0),
    TimeOfDay(hour: 18, minute: 0),
    TimeOfDay(hour: 19, minute: 0),
    TimeOfDay(hour: 20, minute: 0),
    TimeOfDay(hour: 21, minute: 0),
    TimeOfDay(hour: 22, minute: 0),
    TimeOfDay(hour: 23, minute: 0),
  ];

  final BookingService bookingService = getIt.get<BookingService>();

  List<TimeOfDay> get selectableHours => selectableHour;
  Parking? get parking => bookingService.parking;
  List<ShiftPrice>? get shiftPrices => parking?.pricePerHour;
  double get pricePerDay => parking?.pricePerDay ?? 0.0;
  int get tabLength => 2;
  ParkingFeeTypes? get parkingFeeType => bookingService.parkingFeeType;
  ShiftPrice? get morningShift => shiftPrices?.firstWhere(
        (shiftPrice) => shiftPrice.shiftType == ShiftType.morning,
      );
  ShiftPrice? get afternoonShift => shiftPrices?.firstWhere(
        (shiftPrice) => shiftPrice.shiftType == ShiftType.afternoon,
      );
  ShiftPrice? get nightShift => shiftPrices?.firstWhere(
        (shiftPrice) => shiftPrice.shiftType == ShiftType.night,
      );

  late final TabController tabController;

  final calculatedPrice = ValueNotifier<CalculatedFee?>(null);
  final startHour = ValueNotifier<TimeOfDay?>(null);
  final endHour = ValueNotifier<TimeOfDay?>(null);

  DateTime? selectedDate;
  PickerDateRange selectedDateRange = const PickerDateRange(null, null);

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: parkingFeeType?.tabIndex ?? 0,
      length: tabLength,
      vsync: this,
    );

    tabController.addListener(_onTabIndexChangedListener);
  }

  @override
  void dispose() {
    tabController.removeListener(_onTabIndexChangedListener);
    _resetNotifier();
    _disposeNotifier();
    tabController.dispose();
    super.dispose();
  }

  void _resetNotifier() {
    startHour.value = null;
    endHour.value = null;
    calculatedPrice.value = null;
  }

  void _disposeNotifier() {
    calculatedPrice.dispose();
    startHour.dispose();
    endHour.dispose();
  }

  void _onTabIndexChangedListener() {
    loggy.info('Tab changed to ${tabController.index}');
    _resetNotifier();
    selectedDate = null;
  }

  void _calculatePrice() {
    if (tabController.index == 0) {
      calculatedPrice.value = _calculateHourlyPrice();
    } else {
      calculatedPrice.value = _calculateDailyPriceWithTime();
    }
  }

  void onBackButtonPressed(BuildContext scaffoldContext) {
    loggy.info('Back button pressed');
    NavigationUtils.navigateTo(
      context: scaffoldContext,
      path: AppPaths.parkingDetails,
    );
  }

  HourlyFee _calculateHourlyPrice({
    TimeOfDay? startTime,
    TimeOfDay? endTime,
  }) {
    double totalPrice = 0.0;
    TimeOfDay? start = startTime ?? startHour.value;
    TimeOfDay? end = endTime ?? endHour.value;

    if (start == null ||
        end == null ||
        morningShift == null ||
        afternoonShift == null ||
        nightShift == null) {
      return HourlyFee(total: totalPrice, hours: 0);
    }

    TimeOfDay currentTime = start;
    int morningShiftStart = morningShift!.startTime.hour;
    int morningShiftEnd = morningShift!.endTime.hour;
    int afternoonShiftStart = afternoonShift!.startTime.hour;
    int afternoonShiftEnd = afternoonShift!.endTime.hour;

    while (currentTime.hour < end.hour) {
      if (currentTime.hour >= morningShiftStart &&
          currentTime.hour < morningShiftEnd) {
        totalPrice += morningShift!.price;
      } else if (currentTime.hour >= afternoonShiftStart &&
          currentTime.hour < afternoonShiftEnd) {
        totalPrice += afternoonShift!.price;
      } else {
        totalPrice += nightShift!.price;
      }

      // Move to the next hour
      currentTime = currentTime.replacing(hour: currentTime.hour + 1);
    }
    return HourlyFee(
      total: totalPrice,
      hours: end.hour - start.hour,
    );
  }

  DailyFee? _calculateDailyPriceWithTime() {
    double totalPrice = 0;
    if (selectedDateRange.startDate == null ||
        selectedDateRange.endDate == null ||
        startHour.value == null ||
        endHour.value == null) {
      return null;
    }

    final adjustedStartTime = DateTime(
      selectedDateRange.startDate!.year,
      selectedDateRange.startDate!.month,
      selectedDateRange.startDate!.day,
      startHour.value!.hour,
    );

    final adjustedEndTime = DateTime(
      selectedDateRange.endDate!.year,
      selectedDateRange.endDate!.month,
      selectedDateRange.endDate!.day,
      endHour.value!.hour,
    );

    // Calculate full days
    int fullDays = adjustedEndTime.difference(adjustedStartTime).inDays;

    // Add price for each full day
    totalPrice += fullDays * pricePerDay;

    // Handle partial first day (if any)
    totalPrice += _calculateHourlyPrice(
      startTime: TimeOfDay.fromDateTime(adjustedStartTime),
      endTime: const TimeOfDay(hour: 23, minute: 0),
    ).total;

    // Handle partial last day (if any)
    totalPrice += _calculateHourlyPrice(
      startTime: const TimeOfDay(hour: 0, minute: 0),
      endTime: TimeOfDay.fromDateTime(adjustedEndTime),
    ).total;

    final firstDayPartialHours = 23 - adjustedStartTime.hour;
    final lastDayPartialHours = adjustedEndTime.hour;
    int adjustedHours = firstDayPartialHours + lastDayPartialHours + 1;

    return DailyFee(
      total: totalPrice,
      hours: adjustedHours,
      days: fullDays,
    );
  }

  void onPressedContinue() {
    loggy.info('Continue tapped');

    PriceArguments priceArgs;

    if (parkingFeeType == ParkingFeeTypes.hourly &&
        (selectedDate == null ||
            startHour.value == null ||
            endHour.value == null)) {
      //TODO: Show alert message
      return;
    }

    if (parkingFeeType == ParkingFeeTypes.daily &&
        (selectedDateRange.startDate == null ||
            selectedDateRange.endDate == null ||
            startHour.value == null ||
            endHour.value == null)) {
      //TODO: Show alert message
      return;
    }

    if (startHour.value == null ||
        endHour.value == null ||
        calculatedPrice.value == null ||
        calculatedPrice.value?.total == 0) {
      //TODO: Show alert message
      return;
    }

    if (tabController.index == 0) {
      priceArgs = HourlyPriceArguments(
        calculatedFee: calculatedPrice.value!,
        startHour: startHour.value!,
        endHour: endHour.value!,
      );
    } else {
      priceArgs = PriceArguments(
        calculatedFee: calculatedPrice.value!,
        parkingFeeType: ParkingFeeTypes.daily,
      );
    }

    bookingService.setCalculatedPrice(priceArgs);

    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.selectVehicle,
    );
  }

  void onDateChanged(DateRangePickerSelectionChangedArgs args) {
    loggy.info('Date changed to ${args.value}');
    setState(() {
      selectedDate = args.value;
    });
    _calculatePrice();
    _resetNotifier();
  }

  void onDateRangeChanged(DateRangePickerSelectionChangedArgs args) {
    loggy.info('Date range changed to ${args.value}');
    setState(() {
      selectedDateRange = args.value;
    });
    _calculatePrice();
    _resetNotifier();
  }

  void onSelectionHour(TimeOfDay hour, SelectionHourTypes type) {
    loggy.info('Selected $type hour: $hour');
    if (type == SelectionHourTypes.start) {
      startHour.value = hour;
      endHour.value = null;
    } else {
      endHour.value = hour;
    }
    _calculatePrice();
  }

  @override
  Widget build(BuildContext context) =>
      BookParkingDetailsView(controller: this);
}
