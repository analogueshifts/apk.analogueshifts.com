import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/authenticate_view.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/change_password.screen.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/verify_user_otp_view.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/views/home_navigation.dart';
import 'package:analogue_shifts_mobile/modules/notification/presentation/views/notification_screen.dart';
import 'package:analogue_shifts_mobile/modules/onboarding/presentation/views/introduction._screen.dart';
import 'package:analogue_shifts_mobile/modules/onboarding/presentation/views/splash_screen.dart';
import 'package:analogue_shifts_mobile/modules/profile/presentation/views/change_password_screen.dart';
import 'package:analogue_shifts_mobile/modules/profile/presentation/views/deactivate_account_screen.dart';
import 'package:analogue_shifts_mobile/modules/profile/presentation/views/help_center_screen.dart';
import 'package:analogue_shifts_mobile/modules/profile/presentation/views/jobs_applied.dart';
import 'package:analogue_shifts_mobile/modules/profile/presentation/views/settings_screen.drt.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        path: Routes.verifyUserOtp,
        builder: (context, state) => const VerifyUserOtpScreen(),
        routes: const []
      ),
      GoRoute(
        path: Routes.resetChangePassword,
        builder: (context, state) => const ResetChangePasswordScreen(),
      ),
      GoRoute(
        path: Routes.notification,
        builder: (context, state) => const NotificationScreen()
      ),
      GoRoute(
        path: Routes.homeNavigation,
        builder: (context, state) => HomeNavigation(),
        routes: [
          GoRoute(
            path: Routes.settings,
            name: "settings",
            builder: (context, state) => const SettingsScreen(),
            routes: const [
             
            ]
          ),
           GoRoute(
                path: Routes.changePassword,
                name: 'change-password',
                builder: (context, state) => const ChangePasswordScreen(),
                
          ),
          GoRoute(
                path: Routes.jobsApplied,
                name: 'jobs-applied',
                builder: (context, state) => const JobsAppliedScreen()
                
          ),
          GoRoute(
                path: Routes.deactivateAccount,
                name: 'deactivate-account',
                builder: (context, state) => const DeactivateAccountScreen()
                
          ),
          GoRoute(
                path: Routes.helpCenter,
                name: 'help-center',
                builder: (context, state) => const HelpCenterScreen()
                
          ),
          GoRoute(
                path: Routes.helpCenter,
                name: 'faq-screen',
                builder: (context, state) => const JobsAppliedScreen()
                
          ),
           GoRoute(
            path: 'notification',
            // path: Routes.notification,
            name: 'notification',
            builder: (context, state) => const NotificationScreen()
          ),
        ],
      ),
    ],
  );
}

