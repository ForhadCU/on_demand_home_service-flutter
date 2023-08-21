import 'package:url_launcher/url_launcher.dart';

class ProviderProfileViewModel {
  // Make phone call flutter app
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> sendEmail(String email) async {
    launchUrl(Uri.parse(
        "mailto:$email?subject=Seeking for service provider&body=If you are available now, please inform me."));
  }
}
