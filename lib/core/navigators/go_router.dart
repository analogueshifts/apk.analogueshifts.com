import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/authenticate_view.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/views/home_navigation.dart';
import 'package:analogue_shifts_mobile/modules/onboarding/presentation/views/introduction._screen.dart';
import 'package:analogue_shifts_mobile/modules/onboarding/presentation/views/splash_screen.dart';
import 'package:analogue_shifts_mobile/modules/profile/presentation/views/change_password_screen.dart';
import 'package:analogue_shifts_mobile/modules/profile/presentation/views/settings_screen.drt.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _db = getIt<DBService>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  final router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: Routes.startUp,
        name: "start",
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.introduction,
        builder: (context, state) => const IntroductionScreen(),
      ),
      GoRoute(
        path: Routes.authenticate,
        builder: (context, state) => const Authenticate(),
      ),
      GoRoute(
        path: Routes.homeNavigation,
        builder: (context, state) => const HomeNavigation(),
        routes: [
          GoRoute(
            path: Routes.settings,
            name: "settings",
            builder: (context, state) => const SettingsScreen(),
            routes: [
             
            ]
          ),
           GoRoute(
                path: Routes.changePassword,
                name: 'change-password',
                builder: (context, state) => const ChangePasswordScreen(),
                
          ),
        ],
      ),
    ],
  );
}

