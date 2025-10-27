import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'shared/provider/providers.dart';
import 'shared/routes/app_routes.dart';
import 'theme/custom_themes/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AccAppTheme.lightTheme,
      themeMode: ThemeMode.light,
      home: MultiProvider(
        providers: Providers.providers,
        child: MaterialApp(
          title: 'Access Control',

          routes: AppRoutes.routes,
          debugShowCheckedModeBanner: false,
        ),
      ),
    ),
  );
}
