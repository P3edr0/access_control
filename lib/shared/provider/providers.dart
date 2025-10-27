import 'package:access_control/shared/services/http_client/dio_http_client_impl.dart';
import 'package:access_control/shared/services/http_client/http_client.dart';
import 'package:access_control/shared/services/launcher/launcher.dart';
import 'package:access_control/shared/services/launcher/url_launcher_impl.dart';
import 'package:access_control/src/repository/database_repository/get_database_guest_repository.dart';
import 'package:access_control/src/repository/database_repository/sqflite/database_guest_repository_impl.dart';
import 'package:access_control/src/repository/guest_repository/get_guest_repository.dart';
import 'package:access_control/src/repository/guest_repository/random_api/get_user_repository_impl.dart';
import 'package:access_control/src/view_models/details_view_model.dart';
import 'package:access_control/src/view_models/home_view_model.dart';
import 'package:access_control/src/view_models/party_view_model.dart';
import 'package:provider/provider.dart';

class Providers {
  static final providers = [
    //////////////// DATABASE  //////////////////////////////
    Provider<IDatabaseGuestRepository>(
      create: (ctx) => SqfliteDatabaseGuestRepositoryImpl(),
    ),

    //////////////// SERVICES  //////////////////////////////
    Provider<IHttpClient>(create: (ctx) => DioHttpClientImpl()),
    Provider<ILauncher>(create: (ctx) => UrlLauncherImpl()),

    //////////////// REPOSITORY  //////////////////////////////
    Provider<IGetGuestRepository>(
      create: (ctx) =>
          GetUserRandomApiRepositoryImpl(service: ctx.read<IHttpClient>()),
    ),

    //////////////// HOME  //////////////////////////////
    ChangeNotifierProvider<HomeViewModel>(
      create: (ctx) =>
          HomeViewModel(getGuestRepository: ctx.read<IGetGuestRepository>()),
    ),

    //////////////// PARTY  //////////////////////////////
    ChangeNotifierProvider<PartyViewModel>(
      create: (ctx) => PartyViewModel(
        getGuestRepository: ctx.read<IGetGuestRepository>(),
        databaseGuestRepository: ctx.read<IDatabaseGuestRepository>(),
      ),
    ),

    //////////////// DETAILS  //////////////////////////////
    ChangeNotifierProvider<DetailsViewModel>(
      create: (ctx) => DetailsViewModel(),
    ),
  ];
}
