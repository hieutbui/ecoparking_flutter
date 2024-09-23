import 'package:ecoparking_flutter/pages/book_parking_details/book_parking_details_view.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/widgets/time_picker.dart';
import 'package:ecoparking_flutter/pages/select_vehicle/select_vehicle.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookParkingDetails extends StatefulWidget {
  const BookParkingDetails({
    super.key,
  });

  @override
  BookParkingDetailsController createState() => BookParkingDetailsController();
}

class BookParkingDetailsController extends State<BookParkingDetails>
    with ControllerLoggy {
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  TimeOfDay startHour = TimeOfDay.now();
  TimeOfDay endHour = TimeOfDay(
    hour: TimeOfDay.now().hour + 1,
    minute: TimeOfDay.now().minute,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onPressedSelectVehicle() {
    loggy.info('Select Vehicle tapped');

    showDialog(
      context: context,
      builder: (BuildContext context) => const Dialog.fullscreen(
        child: SelectVehicle(),
      ),
    );
  }

  void onDateChanged(DateRangePickerSelectionChangedArgs args) {
    loggy.info('Date changed to ${args.value}');
    setState(() {
      selectedDate = args.value;
    });
  }

  void onPressStartTimeButton() {
    loggy.info('Start Time Button tapped');

    showCupertinoModalPopup(
      context: context,
      builder: (context) => TimePicker(
        onDateTimeChanged: (DateTime dateTime) {
          loggy.info('Start Time changed to $dateTime');
          setState(() {
            startHour = TimeOfDay.fromDateTime(dateTime);
          });
        },
        initialDateTime: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          startHour.hour,
          startHour.minute,
        ),
        //TODO: implement minimumDate for a range of days
        minimumDate: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          TimeOfDay.now().hour,
          TimeOfDay.now().minute,
        ),
      ),
    );
  }

  void onPressEndTimeButton() {
    loggy.info('End Time Button tapped');

    showCupertinoModalPopup(
      context: context,
      builder: (context) => TimePicker(
        onDateTimeChanged: (DateTime dateTime) {
          loggy.info('End Time changed to $dateTime');
          setState(() {
            endHour = TimeOfDay.fromDateTime(dateTime);
          });
        },
        initialDateTime: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          endHour.hour,
          endHour.minute,
        ),
        //TODO: implement minimumDate for a range of days
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BookParkingDetailsView(controller: this);
}
