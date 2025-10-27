import 'package:access_control/src/views/details_page.dart';
import 'package:access_control/src/views/home_page.dart';
import 'package:access_control/src/views/party_page.dart';
import 'package:access_control/src/views/splash_page.dart';

class AppRoutes {
  static const splash = '/';
  static const home = '/home';
  static const details = '/details';
  static const party = '/party';

  static final routes = {
    AppRoutes.splash: (ctx) => const SplashPage(),
    AppRoutes.home: (ctx) => const HomePage(),
    AppRoutes.details: (ctx) => const DetailsPage(),
    AppRoutes.party: (ctx) => const PartyPage(),
  };
}
