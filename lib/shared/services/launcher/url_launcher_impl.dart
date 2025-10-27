import 'package:access_control/shared/services/launcher/launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherImpl implements ILauncher {
  @override
  Future<void> phoneCall(String phone) async {
    // final handledhone
    final Uri launchUri = Uri(scheme: 'tel', path: phone);

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Não foi possível realizar a chamada para $phone';
    }
  }

  @override
  Future<void> sendEmail(String email) async {
    final mailtoUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': 'Parabéns você foi aprovado para a vaga'},
    );
    if (await canLaunchUrl(mailtoUri)) {
      await launchUrl(mailtoUri);
    } else {
      throw 'Não foi possível enviar email para $email';
    }
  }

  @override
  Future<void> openMap({
    required String latitude,
    required String longitude,
  }) async {
    final handledUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    final uri = Uri.parse(handledUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Não foi possível abrir o Map';
    }
  }
}
