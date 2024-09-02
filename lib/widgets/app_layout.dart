import 'package:ecoparking_flutter/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';

class AppLayout extends StatefulWidget {
  final Widget child;

  const AppLayout({
    super.key,
    required this.child,
  });

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int _calculateSelectedIndex(BuildContext context) {
    final GoRouter route = GoRouter.of(context);
    final String location = route.routerDelegate.currentConfiguration.uri.path;

    if (location.startsWith('/home')) {
      return 0;
    } else if (location == '/saved') {
      return 1;
    } else if (location == '/booking') {
      return 2;
    } else if (location == '/profile') {
      return 3;
    } else {
      return 0;
    }
  }

  void _onDestinationSelected(int index) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/home');
        break;
      case 1:
        GoRouter.of(context).go('/saved');
        break;
      case 2:
        GoRouter.of(context).go('/booking');
        break;
      case 3:
        GoRouter.of(context).go('/profile');
        break;
      default:
        GoRouter.of(context).go('/home');
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      primaryNavigation: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.medium: SlotLayout.from(
            inAnimation: AdaptiveScaffold.leftOutIn,
            key: const Key('Primary Navigation Medium'),
            builder: (_) => AdaptiveScaffold.standardNavigationRail(
              selectedIndex: _calculateSelectedIndex(context),
              onDestinationSelected: _onDestinationSelected,
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
            key: const Key('Primary Navigation MediumLarge'),
            inAnimation: AdaptiveScaffold.leftOutIn,
            builder: (_) => AdaptiveScaffold.standardNavigationRail(
              selectedIndex: _calculateSelectedIndex(context),
              onDestinationSelected: _onDestinationSelected,
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
            key: const Key('Primary Navigation Large'),
            inAnimation: AdaptiveScaffold.leftOutIn,
            builder: (_) => AdaptiveScaffold.standardNavigationRail(
              selectedIndex: _calculateSelectedIndex(context),
              onDestinationSelected: _onDestinationSelected,
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
            key: const Key('Primary Navigation ExtraLarge'),
            inAnimation: AdaptiveScaffold.leftOutIn,
            builder: (_) => AdaptiveScaffold.standardNavigationRail(
              selectedIndex: _calculateSelectedIndex(context),
              onDestinationSelected: _onDestinationSelected,
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
            key: const Key('Body Standard'),
            builder: (_) => widget.child,
          ),
        },
      ),
      bottomNavigation: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
            key: const Key('Bottom Navigation Small'),
            inAnimation: AdaptiveScaffold.bottomToTop,
            outAnimation: AdaptiveScaffold.topToBottom,
            builder: (_) => AdaptiveScaffold.standardBottomNavigationBar(
              destinations: AppRoutes.destinations(context),
              currentIndex: _calculateSelectedIndex(context),
              onDestinationSelected: _onDestinationSelected,
            ),
          )
        },
      ),
    );
  }
}
