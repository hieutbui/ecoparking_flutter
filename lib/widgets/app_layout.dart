import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';

class AppLayout extends StatelessWidget {
  final Widget child;

  const AppLayout({
    super.key,
    required this.child,
  });

  static const Key _primaryNavigationMediumKey = Key('Primary Navigation');
  static const Key _primaryNavigationMediumLargeKey =
      Key('Primary Navigation MediumLarge');
  static const Key _primaryNavigationLargeKey = Key('Primary Navigation Large');
  static const Key _primaryNavigationExtraLargeKey =
      Key('Primary Navigation ExtraLarge');
  static const Key _bodyStandardKey = Key('Body Standard');
  static const Key _bottomNavigationSmallKey = Key('Bottom Navigation Small');

  int _calculateSelectedIndex(BuildContext context) {
    final GoRouter route = GoRouter.of(context);
    final String location = route.routerDelegate.currentConfiguration.uri.path;
    final int? index = AppRoutes.navBarPathToIndex[location];

    return index ?? 0;
  }

  void _onDestinationSelected(BuildContext context, int index) {
    final String? path = AppRoutes.navBarIndexToPath[index];

    GoRouter.of(context).go(path ?? AppPaths.home.path);
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      primaryNavigation: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.medium: SlotLayout.from(
            inAnimation: AdaptiveScaffold.leftOutIn,
            key: _primaryNavigationMediumKey,
            builder: (_) => AdaptiveScaffold.standardNavigationRail(
              selectedIndex: _calculateSelectedIndex(context),
              onDestinationSelected: (index) =>
                  _onDestinationSelected(context, index),
              destinations: AppRoutes.railDestinations(context),
              backgroundColor:
                  Theme.of(context).navigationRailTheme.backgroundColor,
              selectedIconTheme:
                  Theme.of(context).navigationRailTheme.selectedIconTheme,
              unselectedIconTheme:
                  Theme.of(context).navigationRailTheme.unselectedIconTheme,
              selectedLabelTextStyle:
                  Theme.of(context).navigationRailTheme.selectedLabelTextStyle,
              unSelectedLabelTextStyle: Theme.of(context)
                  .navigationRailTheme
                  .unselectedLabelTextStyle,
            ),
          ),
          Breakpoints.mediumLarge: SlotLayout.from(
            key: _primaryNavigationMediumLargeKey,
            inAnimation: AdaptiveScaffold.leftOutIn,
            builder: (_) => AdaptiveScaffold.standardNavigationRail(
              selectedIndex: _calculateSelectedIndex(context),
              onDestinationSelected: (index) =>
                  _onDestinationSelected(context, index),
              extended: true,
              destinations: AppRoutes.railDestinations(context),
              backgroundColor:
                  Theme.of(context).navigationRailTheme.backgroundColor,
              selectedIconTheme:
                  Theme.of(context).navigationRailTheme.selectedIconTheme,
              unselectedIconTheme:
                  Theme.of(context).navigationRailTheme.unselectedIconTheme,
              selectedLabelTextStyle:
                  Theme.of(context).navigationRailTheme.selectedLabelTextStyle,
              unSelectedLabelTextStyle: Theme.of(context)
                  .navigationRailTheme
                  .unselectedLabelTextStyle,
            ),
          ),
          Breakpoints.large: SlotLayout.from(
            key: _primaryNavigationLargeKey,
            inAnimation: AdaptiveScaffold.leftOutIn,
            builder: (_) => AdaptiveScaffold.standardNavigationRail(
              selectedIndex: _calculateSelectedIndex(context),
              onDestinationSelected: (index) =>
                  _onDestinationSelected(context, index),
              extended: true,
              destinations: AppRoutes.railDestinations(context),
              backgroundColor:
                  Theme.of(context).navigationRailTheme.backgroundColor,
              selectedIconTheme:
                  Theme.of(context).navigationRailTheme.selectedIconTheme,
              unselectedIconTheme:
                  Theme.of(context).navigationRailTheme.unselectedIconTheme,
              selectedLabelTextStyle:
                  Theme.of(context).navigationRailTheme.selectedLabelTextStyle,
              unSelectedLabelTextStyle: Theme.of(context)
                  .navigationRailTheme
                  .unselectedLabelTextStyle,
            ),
          ),
          Breakpoints.extraLarge: SlotLayout.from(
            key: _primaryNavigationExtraLargeKey,
            inAnimation: AdaptiveScaffold.leftOutIn,
            builder: (_) => AdaptiveScaffold.standardNavigationRail(
              selectedIndex: _calculateSelectedIndex(context),
              onDestinationSelected: (index) =>
                  _onDestinationSelected(context, index),
              extended: true,
              destinations: AppRoutes.railDestinations(context),
              backgroundColor:
                  Theme.of(context).navigationRailTheme.backgroundColor,
              selectedIconTheme:
                  Theme.of(context).navigationRailTheme.selectedIconTheme,
              unselectedIconTheme:
                  Theme.of(context).navigationRailTheme.unselectedIconTheme,
              selectedLabelTextStyle:
                  Theme.of(context).navigationRailTheme.selectedLabelTextStyle,
              unSelectedLabelTextStyle: Theme.of(context)
                  .navigationRailTheme
                  .unselectedLabelTextStyle,
            ),
          ),
        },
      ),
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.standard: SlotLayout.from(
            key: _bodyStandardKey,
            builder: (_) => child,
          ),
        },
      ),
      bottomNavigation: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
            key: _bottomNavigationSmallKey,
            inAnimation: AdaptiveScaffold.bottomToTop,
            outAnimation: AdaptiveScaffold.topToBottom,
            builder: (_) => AdaptiveScaffold.standardBottomNavigationBar(
              destinations: AppRoutes.destinations(context),
              currentIndex: _calculateSelectedIndex(context),
              onDestinationSelected: (index) =>
                  _onDestinationSelected(context, index),
            ),
          )
        },
      ),
    );
  }
}
