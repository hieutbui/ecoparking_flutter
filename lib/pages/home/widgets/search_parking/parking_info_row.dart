import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ParkingInfoRow extends StatelessWidget {
  final Parking parking;
  final void Function(Parking parking) onTap;

  const ParkingInfoRow({
    super.key,
    required this.parking,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      padding: const EdgeInsets.all(0),
      onTap: () => onTap(parking),
      avatar: Container(
        width: 42.0,
        height: 42.0,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).colorScheme.errorContainer,
            width: 2,
          ),
        ),
        child: Center(
          child: Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.errorContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.local_parking,
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
          ),
        ),
      ),
      titleText: parking.parkingName,
      subTitleText: parking.address,
    );
  }
}
