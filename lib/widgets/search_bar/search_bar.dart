import 'package:ecoparking_flutter/pages/resource/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSearchBar extends StatelessWidget {
  final SearchController controller;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Function()? onFilterPressed;
  final bool isShowFilter;

  const AppSearchBar({
    super.key,
    required this.controller,
    this.onChanged,
    this.onTap,
    this.onFilterPressed,
    this.isShowFilter = false,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      elevation: const WidgetStatePropertyAll(0),
      backgroundColor: WidgetStatePropertyAll(
        Theme.of(context).colorScheme.tertiary.withOpacity(0.25),
      ),
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      leading: const Icon(Icons.search),
      trailing: <Widget>[
        if (isShowFilter)
          Tooltip(
            message: 'Filter',
            child: IconButton(
              onPressed: onFilterPressed,
              icon: SvgPicture.asset(
                ImagePaths.icFilter,
                width: 20,
                height: 16,
              ),
            ),
          ),
      ],
    );
  }
}
