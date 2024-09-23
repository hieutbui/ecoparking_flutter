import 'package:ecoparking_flutter/pages/book_parking_details/book_parking_details.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/book_parking_details_view_styles.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/widgets/time_picker_button.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookParkingDetailsView extends StatelessWidget {
  final BookParkingDetailsController controller;

  const BookParkingDetailsView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Book Parking Details',
      body: Padding(
        padding: BookParkingDetailsViewStyles.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: BookParkingDetailsViewStyles.paddingText,
              child: Text(
                'Select Date',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
              ),
            ),
            Container(
              decoration:
                  BookParkingDetailsViewStyles.calendarContainerDecoration,
              padding: BookParkingDetailsViewStyles.calendarContainerPadding,
              //TODO: Implement picker for range of dates
              child: SfDateRangePicker(
                backgroundColor:
                    BookParkingDetailsViewStyles.calendarBackgroundColor,
                headerStyle: const DateRangePickerHeaderStyle(
                  backgroundColor:
                      BookParkingDetailsViewStyles.calendarBackgroundColor,
                ),
                initialSelectedDate: DateTime.now(),
                minDate: DateTime.now(),
                selectionMode: DateRangePickerSelectionMode.single,
                onSelectionChanged: controller.onDateChanged,
                todayHighlightColor: Theme.of(context).colorScheme.primary,
                selectionColor: Theme.of(context).colorScheme.primary,
                showNavigationArrow: true,
                monthViewSettings: const DateRangePickerMonthViewSettings(
                  firstDayOfWeek: 1,
                ),
              ),
            ),
            const SizedBox(
              height:
                  BookParkingDetailsViewStyles.calendarContainerBottomSpacing,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TimePickerButton(
                  title: 'Start Hour',
                  selectedTime: controller.startHour,
                  onPressed: controller.onPressStartTimeButton,
                ),
                TimePickerButton(
                  title: 'End Hour',
                  selectedTime: controller.endHour,
                  onPressed: controller.onPressEndTimeButton,
                ),
              ],
            )
            //TODO: Implement auto calculate price
            //TODO: Implement button to book parking
          ],
        ),
      ),
    );
  }
}
