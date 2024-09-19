import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:ecoparking_flutter/pages/booking/booking.dart';
import 'package:ecoparking_flutter/pages/home/home.dart';
import 'package:ecoparking_flutter/pages/parking_details/parking_details.dart';
import 'package:ecoparking_flutter/pages/profile/profile.dart';
import 'package:ecoparking_flutter/pages/saved/saved.dart';
import 'package:ecoparking_flutter/utils/responsive.dart';
import 'package:ecoparking_flutter/widgets/app_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static GlobalKey<NavigatorState> get _rootNavigatorKey =>
      GlobalKey<NavigatorState>(debugLabel: 'Root Navigator');
  static GlobalKey<NavigatorState> get _shellNavigatorKey =>
      GlobalKey<NavigatorState>(debugLabel: 'Shell Navigator');

  static final _responsive = getIt.get<ResponsiveUtils>();

  static List<NavigationDestination> destinations(BuildContext context) =>
      <NavigationDestination>[
        NavigationDestination(
          label: AppPaths.home.label,
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
          label: AppPaths.saved.label,
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
          label: AppPaths.booking.label,
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
          label: AppPaths.profile.label,
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
          if (state.uri.path == AppPaths.parkingDetails.path) {
            return child;
          }
          return AppLayout(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: AppPaths.home.path,
            pageBuilder: (context, state) => defaultPageBuilder(
              context,
              const HomePage(),
              name: AppPaths.home.label,
            ),
            routes: <RouteBase>[
              GoRoute(
                path: _getSubScreenPath(
                  mainPath: AppPaths.home.path,
                  subPath: AppPaths.parkingDetails.path,
                ),
                pageBuilder: (context, state) {
                  final Parking parking = state.extra as Parking;

                  return defaultPageBuilder(
                    context,
                    ParkingDetails(parking: parking),
                    name: AppPaths.parkingDetails.label,
                  );
                },
                redirect: (context, state) =>
                    state.extra == null ? AppPaths.home.path : null,
              ),
            ],
          ),
          GoRoute(
            path: AppPaths.saved.path,
            pageBuilder: (context, state) => defaultPageBuilder(
              context,
              const SavedPage(),
              name: AppPaths.saved.label,
            ),
          ),
          GoRoute(
            path: AppPaths.booking.path,
            pageBuilder: (context, state) => defaultPageBuilder(
              context,
              const BookingPage(),
              name: AppPaths.booking.label,
            ),
          ),
          GoRoute(
            path: AppPaths.profile.path,
            pageBuilder: (context, state) => defaultPageBuilder(
              context,
              const ProfilePage(),
              name: AppPaths.profile.label,
            ),
          ),
        ],
      ),
    ],
    onException: (context, state, router) {
      return router.go(AppPaths.home.path);
    },
  );

  static Page defaultPageBuilder(
    BuildContext context,
    Widget child, {
    String? name,
  }) =>
      CustomTransitionPage(
        name: name,
        child: child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            !_responsive.isMobile(context)
                ? FadeTransition(
                    opacity: animation,
                    child: child,
                  )
                : CupertinoPageTransition(
                    primaryRouteAnimation: animation,
                    secondaryRouteAnimation: secondaryAnimation,
                    linearTransition: false,
                    child: child,
                  ),
      );

  static Map<String, int> navBarPathToIndex = {
    AppPaths.home.path: 0,
    AppPaths.saved.path: 1,
    AppPaths.booking.path: 2,
    AppPaths.profile.path: 3,
  };

  static Map<int, String> navBarIndexToPath = {
    0: AppPaths.home.path,
    1: AppPaths.saved.path,
    2: AppPaths.booking.path,
    3: AppPaths.profile.path,
  };

  static String _getSubScreenPath({
    required String mainPath,
    required String subPath,
  }) {
    return subPath.substring(mainPath.length + 1);
  }
}
