import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/pages/booking/booking.dart';
import 'package:ecoparking_flutter/pages/home/home.dart';
import 'package:ecoparking_flutter/pages/profile/profile.dart';
import 'package:ecoparking_flutter/pages/saved/saved.dart';
import 'package:ecoparking_flutter/widgets/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static GlobalKey<NavigatorState> get _rootNavigatorKey =>
      GlobalKey<NavigatorState>(debugLabel: 'Root Navigator');
  static GlobalKey<NavigatorState> get _shellNavigatorKey =>
      GlobalKey<NavigatorState>(debugLabel: 'Shell Navigator');

  static List<NavigationDestination> destinations(BuildContext context) =>
      <NavigationDestination>[
        NavigationDestination(
          label: 'Home',
          icon: const Icon(
            Icons.home_filled,
            color: Color(0xFFCACACA),
          ),
          selectedIcon: Icon(
            Icons.home_filled,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        NavigationDestination(
          label: 'Saved',
          icon: const Icon(
            Icons.bookmark_outline,
            color: Color(0xFFCACACA),
          ),
          selectedIcon: Icon(
            Icons.bookmark_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        NavigationDestination(
          label: 'Booking',
          icon: const Icon(
            Icons.article_outlined,
            color: Color(0xFFCACACA),
          ),
          selectedIcon: Icon(
            Icons.article_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        NavigationDestination(
          label: 'Profile',
          icon: const Icon(
            Icons.person_outline,
            color: Color(0xFFCACACA),
          ),
          selectedIcon: Icon(
            Icons.person_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ];

  static List<NavigationRailDestination> railDestinations(
    BuildContext context,
  ) =>
      destinations(context)
          .map((destination) => AdaptiveScaffold.toRailDestination(destination))
          .toList();

  static final GoRouter router = GoRouter(
    initialLocation: AppPaths.home.path,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return AppLayout(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: AppPaths.home.path,
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: AppPaths.saved.path,
            builder: (context, state) => const SavedPage(),
          ),
          GoRoute(
            path: AppPaths.booking.path,
            builder: (context, state) => const BookingPage(),
          ),
          GoRoute(
            path: AppPaths.profile.path,
            builder: (context, state) => const ProfilePage(),
          )
        ],
      ),
    ],
    // onException: (context, state, router) {
    //   return router.go('/error');
    // },
  );

  static Page defaultPageBuilder(
    BuildContext context,
    Widget child, {
    String? name,
  }) =>
      CustomTransitionPage(
        name: name,
        child: child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      );
}
