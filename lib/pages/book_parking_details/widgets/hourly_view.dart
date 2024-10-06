import 'package:ecoparking_flutter/pages/book_parking_details/book_parking_details.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/book_parking_details_view_styles.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/model/selection_hour_types.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/widgets/calculated_price.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/widgets/hour_selection_button.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HourlyView extends StatelessWidget {
  final BookParkingDetailsController controller;

  const HourlyView({
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
                      minDate: DateTime.now(),
                      selectionMode: DateRangePickerSelectionMode.single,
                      onSelectionChanged: controller.onDateChanged,
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
                      return Column(
                        children: <Widget>[
                          Wrap(
                            runSpacing:
                                BookParkingDetailsViewStyles.wrapperSpacing,
                            spacing:
                                BookParkingDetailsViewStyles.wrapperSpacing,
                            children: controller.selectableHours.map((hour) {
                              final isSelected = startHour == hour;
                              final now = TimeOfDay.now();
                              final isDisabled = controller.selectedDate != null
                                  ? controller.selectedDate!.day ==
                                          DateTime.now().day &&
                                      hour.hour < now.hour
                                  : false;

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
                          ),
                          const SizedBox(
                              height: BookParkingDetailsViewStyles.spacing),
                          Text(
                            'End Hour',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                          ),
                          const SizedBox(
                              height: BookParkingDetailsViewStyles.spacing),
                          ValueListenableBuilder(
                            valueListenable: controller.endHour,
                            builder: (context, endHour, _) {
                              return Wrap(
                                runSpacing:
                                    BookParkingDetailsViewStyles.wrapperSpacing,
                                spacing:
                                    BookParkingDetailsViewStyles.wrapperSpacing,
                                children: controller.selectableHours.map(
                                  (hour) {
                                    final isSelected = endHour == hour;
                                    final isDisabled = controller
                                                .startHour.value !=
                                            null
                                        ? hour.hour <
                                            controller.startHour.value!.hour + 1
                                        : false;

                                    return HourSelectionButton(
                                      hour: hour,
                                      isSelected: isSelected,
                                      isDisabled: isDisabled,
                                      onPressed: (hour) =>
                                          controller.onSelectionHour(
                                        hour,
                                        SelectionHourTypes.end,
                                      ),
                                    );
                                  },
                                ).toList(),
                              );
                            },
                          ),
                        ],
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
            children: [
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
