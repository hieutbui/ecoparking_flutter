import 'package:ecoparking_flutter/pages/book_parking_details/book_parking_details.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/book_parking_details_view_styles.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/model/selection_hour_types.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/widgets/calculated_price.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/widgets/hour_selection_button.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DailyView extends StatelessWidget {
  final BookParkingDetailsController controller;

  const DailyView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: BookParkingDetailsViewStyles.padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: BookParkingDetailsViewStyles.paddingText,
                    child: Text(
                      'Select Date',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                    ),
                  ),
                  Container(
                    decoration: BookParkingDetailsViewStyles
                        .calendarContainerDecoration,
                    padding:
                        BookParkingDetailsViewStyles.calendarContainerPadding,
                    child: SfDateRangePicker(
                      backgroundColor:
                          BookParkingDetailsViewStyles.calendarBackgroundColor,
                      headerStyle: const DateRangePickerHeaderStyle(
                        backgroundColor: BookParkingDetailsViewStyles
                            .calendarBackgroundColor,
                      ),
                      initialSelectedDate: DateTime.now(),
                      minDate: DateTime.now(),
                      selectionMode: DateRangePickerSelectionMode.range,
                      onSelectionChanged: controller.onDateRangeChanged,
                      todayHighlightColor:
                          Theme.of(context).colorScheme.primary,
                      selectionColor: Theme.of(context).colorScheme.primary,
                      showNavigationArrow: true,
                      monthViewSettings: const DateRangePickerMonthViewSettings(
                        firstDayOfWeek: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: BookParkingDetailsViewStyles.spacing),
                  Text(
                    'Start Hour',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(height: BookParkingDetailsViewStyles.spacing),
                  ValueListenableBuilder(
                    valueListenable: controller.startHour,
                    builder: (context, startHour, _) {
                      return Wrap(
                        runSpacing: BookParkingDetailsViewStyles.wrapperSpacing,
                        spacing: BookParkingDetailsViewStyles.wrapperSpacing,
                        children: controller.selectableHours.map((hour) {
                          final isSelected = startHour == hour;
                          final now = DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            DateTime.now().hour,
                            0,
                          );
                          bool isDisabled = false;
                          if (controller.selectedDateRange.startDate?.day ==
                              now.day) {
                            isDisabled = hour.hour < DateTime.now().hour;
                          }

                          return HourSelectionButton(
                            hour: hour,
                            isSelected: isSelected,
                            isDisabled: isDisabled,
                            onPressed: (hour) => controller.onSelectionHour(
                              hour,
                              SelectionHourTypes.start,
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  const SizedBox(height: BookParkingDetailsViewStyles.spacing),
                  Text(
                    'End Hour',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(height: BookParkingDetailsViewStyles.spacing),
                  ValueListenableBuilder(
                    valueListenable: controller.endHour,
                    builder: (context, endHour, _) {
                      return Wrap(
                        runSpacing: BookParkingDetailsViewStyles.wrapperSpacing,
                        spacing: BookParkingDetailsViewStyles.wrapperSpacing,
                        children: controller.selectableHours.map(
                          (hour) {
                            final isSelected = endHour == hour;
                            final isDisabled =
                                controller.selectedDateRange.endDate == null ||
                                    controller.selectedDateRange.endDate?.day ==
                                        controller
                                            .selectedDateRange.startDate?.day;

                            return HourSelectionButton(
                              hour: hour,
                              isSelected: isSelected,
                              isDisabled: isDisabled,
                              onPressed: (hour) => controller.onSelectionHour(
                                hour,
                                SelectionHourTypes.end,
                              ),
                            );
                          },
                        ).toList(),
                      );
                    },
                  ),
                  const SizedBox(height: BookParkingDetailsViewStyles.spacing),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: BookParkingDetailsViewStyles.bottomContainerPadding,
          width: MediaQuery.of(context).size.width,
          decoration: BookParkingDetailsViewStyles.bottomContainerDecoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CalculatedPrice(
                calculatedPrice: controller.calculatedPrice,
              ),
              const SizedBox(height: BookParkingDetailsViewStyles.spacing),
              ActionButton(
                type: ActionButtonType.positive,
                label: 'Continue',
                onPressed: controller.onPressedContinue,
              )
            ],
          ),
        ),
      ],
    );
  }
}
