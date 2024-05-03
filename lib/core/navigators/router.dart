import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/authenticate_view.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/login_view.dart';
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

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.startUp:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const SplashScreen(),
      );
    case Routes.introduction:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const IntroductionScreen(),
      );
    case Routes.authenticate:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const Authenticate(),
      );
    case Routes.homeNavigation:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const HomeNavigation(),
      );
       case Routes.jobsApplied:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const JobsAppliedScreen()
      );
       case Routes.settings:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const SettingsScreen(),
      );

       case Routes.changePassword:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const ChangePasswordScreen()
      );

      case Routes.deactivateAccount:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const DeactivateAccountScreen()
      );

      case Routes.notification:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const NotificationScreen()
      );

      case Routes.helpCenter:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const HelpCenterScreen()
      );
      
    default:
      return MaterialPageRoute<void>(
        builder: (_) => Scaffold(
          body: Center(
            child: Text(
              'No route defined for ${settings.name}',
            ),
          ),
        ),
      );
  }
}

// ignore: strict_raw_type
PageRoute _getPageRoute({String? routeName, Widget? viewToShow}) {
  return MaterialPageRoute<void>(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => viewToShow!,
  );
}