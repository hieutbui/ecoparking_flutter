import 'package:ecoparking_flutter/model/account/favorite_parking.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class SavedParkingsCard extends StatelessWidget {
  final FavoriteParking favoriteParking;

  const SavedParkingsCard({
    super.key,
    required this.favoriteParking,
  });

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      avatar: GFAvatar(
        radius: 20.0,
        size: 60.0,
        shape: GFAvatarShape.standard,
        backgroundImage: NetworkImage(favoriteParking.image),
      ),
      title: Text(
        favoriteParking.parkingName,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.black,
            ),
      ),
      subTitle: Text(
        favoriteParking.address,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: const Color(0xFFA1A1A1),
            ),
      ),
      icon: Icon(
        Icons.bookmark_outlined,
        color: Theme.of(context).colorScheme.primary,
      ),
      radius: 10.0,
      color: const Color(0xFFF9F9F9),
      onTap: () {},
      shadow: const BoxShadow(color: Colors.transparent),
    );
  }
}
