import 'package:ecoparking_flutter/domain/state/vehicles/get_user_vehicles_state.dart';
import 'package:ecoparking_flutter/pages/select_vehicle/select_vehicle.dart';
import 'package:ecoparking_flutter/pages/select_vehicle/select_vehicle_view_styles.dart';
import 'package:ecoparking_flutter/resource/image_paths.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:ecoparking_flutter/widgets/selection_card/selection_card.dart';
import 'package:flutter/material.dart';

class SelectVehicleView extends StatelessWidget {
  final SelectVehicleController controller;

  const SelectVehicleView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Select Your Vehicle',
      body: ValueListenableBuilder(
        valueListenable: controller.userVehiclesNotifier,
        builder: (context, notifier, child) {
          if (notifier is GetUserVehiclesInitial) return child!;

          if (notifier is GetUserVehiclesSuccess) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: SelectVehicleViewStyles.padding,
                    child: ListView.separated(
                      itemCount: notifier.vehicles.length + 1,
                      itemBuilder: (context, index) {
                        if (index == notifier.vehicles.length) {
                          return ActionButton(
                            type: ActionButtonType.positive,
                            label: 'Add New Vehicle',
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1),
                            labelColor: Theme.of(context).colorScheme.primary,
                            onPressed: () {},
                          );
                        }

                        final vehicle = notifier.vehicles[index];
                        return ValueListenableBuilder(
                          valueListenable: controller.selectedVehicleId,
                          builder: (context, selectedVehicleId, child) {
                            return SelectionCard(
                              title: vehicle.name,
                              subtitle: vehicle.licensePlate,
                              trailingImage: ImagePaths.imgCarModel,
                              isShowSelectCircle: true,
                              titleColor:
                                  Theme.of(context).colorScheme.onSurface,
                              subtitleColor: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.5),
                              isSelected: selectedVehicleId == vehicle.id,
                              onTap: () => controller.selectVehicle(vehicle.id),
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: SelectVehicleViewStyles.listViewSpacing,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: SelectVehicleViewStyles.paddingBottom,
                  decoration: SelectVehicleViewStyles.bottomContainerDecoration,
                  child: ActionButton(
                    type: ActionButtonType.positive,
                    label: 'Continue',
                    onPressed: controller.onPressedContinue,
                  ),
                ),
              ],
            );
          }

          return child!;
        },
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
