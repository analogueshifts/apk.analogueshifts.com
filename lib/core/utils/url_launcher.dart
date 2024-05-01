import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  Future<void> makePhoneCall(String phoneNumber) async {
    final launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    Logger().d(launchUri);
    await launchUrl(launchUri);
  }

  Future<void> makeEmailLaunch(String email) async {
    final launchUri = Uri(
      scheme: 'mailto',
      path: email
    );
    Logger().d(launchUri);
    await launchUrl(launchUri);
  }
}