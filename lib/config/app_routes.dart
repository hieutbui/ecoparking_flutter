import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/config/route_change_notifier.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/services/account_service.dart';
import 'package:ecoparking_flutter/domain/services/booking_service.dart';
import 'package:ecoparking_flutter/domain/services/parking_service.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/book_parking_details.dart';
import 'package:ecoparking_flutter/pages/edit_profile/edit_profile.dart';
import 'package:ecoparking_flutter/pages/login/login.dart';
import 'package:ecoparking_flutter/pages/my_tickets/my_tickets.dart';
import 'package:ecoparking_flutter/pages/choose_payment_method/choose_payment_method.dart';
import 'package:ecoparking_flutter/pages/home/home.dart';
import 'package:ecoparking_flutter/pages/parking_details/parking_details.dart';
import 'package:ecoparking_flutter/pages/profile/profile.dart';
import 'package:ecoparking_flutter/pages/register/register.dart';
import 'package:ecoparking_flutter/pages/review_summary/review_summary.dart';
import 'package:ecoparking_flutter/pages/saved/saved.dart';
import 'package:ecoparking_flutter/pages/select_vehicle/select_vehicle.dart';
import 'package:ecoparking_flutter/pages/ticket_details/ticket_details.dart';
import 'package:ecoparking_flutter/pages/verify_otp/model/register_types.dart';
import 'package:ecoparking_flutter/pages/verify_otp/verify_otp.dart';
import 'package:ecoparking_flutter/utils/responsive.dart';
import 'package:ecoparking_flutter/widgets/app_layout.dart';
import 'package:ecoparking_flutter/widgets/test_page.dart';
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
  static final _parkingService = getIt.get<ParkingService>();
  static final _bookingService = getIt.get<BookingService>();
  static final _accountService = getIt.get<AccountService>();

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
    refreshListenable: routeChangeNotifier,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          final currentPath = state.uri.path.trim();

          final containsPath =
              listFullScreenPages.any((path) => path.trim() == currentPath);

          if (containsPath) {
            return child;
          }

          return AppLayout(child: child);
        },
        redirect: (context, state) {
          final currentPath = state.uri.path.trim();

          final containsPath =
              listScreenRequiredAuth.any((path) => path.trim() == currentPath);

          if (!containsPath) {
            return null;
          }

          final profile = _accountService.profile;

          if (profile == null) {
            return AppPaths.profile.path;
          }

          if (profile.phone == null || profile.phone!.isEmpty) {
            if (currentPath != AppPaths.editProfile.navigationPath) {
              return AppPaths.profile.path;
            }
          }

          return null;
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
                path: AppPaths.parkingDetails.path,
                pageBuilder: (context, state) => defaultPageBuilder(
                  context,
                  const ParkingDetails(),
                  name: AppPaths.parkingDetails.label,
                ),
                redirect: (context, state) =>
                    _parkingService.selectedParking == null
                        ? AppPaths.home.path
                        : null,
              ),
              GoRoute(
                path: AppPaths.bookingDetails.path,
                pageBuilder: (context, state) => defaultPageBuilder(
                  context,
                  const BookParkingDetails(),
                  name: AppPaths.bookingDetails.label,
                ),
                redirect: (context, state) {
                  if (_bookingService.parking == null ||
                      _bookingService.parkingFeeType == null) {
                    return AppPaths.home.path;
                  }

                  return null;
                },
              ),
              GoRoute(
                path: AppPaths.selectVehicle.path,
                pageBuilder: (context, state) => defaultPageBuilder(
                  context,
                  const SelectVehicle(),
                  name: AppPaths.selectVehicle.label,
                ),
                redirect: (context, state) =>
                    _bookingService.calculatedPrice == null
                        ? AppPaths.home.path
                        : null,
              ),
              GoRoute(
                path: AppPaths.reviewSummary.path,
                pageBuilder: (context, state) => defaultPageBuilder(
                  context,
                  const ReviewSummary(),
                  name: AppPaths.reviewSummary.label,
                ),
                redirect: (context, state) =>
                    _bookingService.vehicle == null ? AppPaths.home.path : null,
                routes: <RouteBase>[
                  GoRoute(
                    path: AppPaths.paymentMethod.path,
                    pageBuilder: (context, state) => defaultPageBuilder(
                      context,
                      const ChoosePaymentMethod(),
                      name: AppPaths.paymentMethod.label,
                    ),
                  )
                ],
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
                    const MyTicketsPage(),
                    name: AppPaths.booking.label,
                  ),
              routes: <RouteBase>[
                GoRoute(
                  path: AppPaths.ticketDetails.path,
                  pageBuilder: (context, state) => defaultPageBuilder(
                    context,
                    const TicketDetails(),
                    name: AppPaths.ticketDetails.label,
                  ),
                  redirect: (context, state) =>
                      (_bookingService.createdTicket == null &&
                              _bookingService.selectedTicketId == null)
                          ? AppPaths.home.path
                          : null,
                ),
              ]),
          GoRoute(
            path: AppPaths.profile.path,
            pageBuilder: (context, state) => defaultPageBuilder(
              context,
              const ProfilePage(),
              name: AppPaths.profile.label,
            ),
            routes: <RouteBase>[
              GoRoute(
                path: AppPaths.editProfile.path,
                pageBuilder: (context, state) => defaultPageBuilder(
                  context,
                  const EditProfile(),
                  name: AppPaths.editProfile.label,
                ),
                redirect: (context, state) => _accountService.profile == null
                    ? AppPaths.profile.path
                    : null,
              )
            ],
          ),
          GoRoute(
            path: AppPaths.login.path,
            pageBuilder: (context, state) => defaultPageBuilder(
              context,
              const LoginPage(),
              name: AppPaths.login.label,
            ),
          ),
          GoRoute(
            path: AppPaths.register.path,
            pageBuilder: (context, state) => defaultPageBuilder(
              context,
              const RegisterPage(),
              name: AppPaths.register.label,
            ),
            routes: <RouteBase>[
              GoRoute(
                path: AppPaths.registerVerify.path,
                pageBuilder: (context, state) => defaultPageBuilder(
                  context,
                  const VerifyOtp(registerType: RegisterTypes.email),
                  name: AppPaths.registerVerify.label,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/payment-return',
            pageBuilder: (context, state) {
              return defaultPageBuilder(
                context,
                const Center(
                  child: Text('Payment Return Page'),
                ),
                name: 'Payment Return Page',
              );
            },
          ),
          GoRoute(
            path: AppPaths.testPage.path,
            pageBuilder: (context, state) => defaultPageBuilder(
              context,
              const TestPage(),
              name: AppPaths.testPage.label,
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

  static Map<int, AppPaths> navBarIndexToPath = {
    0: AppPaths.home,
    1: AppPaths.saved,
    2: AppPaths.booking,
    3: AppPaths.profile,
  };

  static List<String> get listFullScreenPages => [
        AppPaths.login.path,
        AppPaths.register.path,
        AppPaths.parkingDetails.navigationPath,
        AppPaths.bookingDetails.navigationPath,
        AppPaths.selectVehicle.navigationPath,
        AppPaths.reviewSummary.navigationPath,
        AppPaths.paymentMethod.navigationPath,
        AppPaths.editProfile.navigationPath,
        AppPaths.ticketDetails.navigationPath,
        AppPaths.testPage.navigationPath,
      ];

  static List<String> get listScreenRequiredAuth => [
        AppPaths.bookingDetails.navigationPath,
        AppPaths.selectVehicle.navigationPath,
        AppPaths.reviewSummary.navigationPath,
        AppPaths.paymentMethod.navigationPath,
        AppPaths.ticketDetails.navigationPath,
        AppPaths.editProfile.navigationPath,
      ];
}
