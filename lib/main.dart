/*
run:
flutter run -d chrome --web-renderer=html

build:
flutter build web --release --pwa-strategy=offline-first --web-renderer=html
*/
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

import 'services/theme_provider.dart';
import 'config/beamer.dart';
import 'config/theme.dart';

void main() async {
  ThemeProvider themeProvider = await ThemeProvider.create();
  runApp(
    ChangeNotifierProvider(
      create: (context) => themeProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp.router(
          title: 'dashboard_flutter',
          theme: themeData(themeMode: ThemeMode.light),
          darkTheme: themeData(themeMode: ThemeMode.dark),
          themeMode: themeProvider.theme,
          routerDelegate: routerDelegate,
          routeInformationParser: BeamerParser(),
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown,
            },
          ),
        );
      },
    );
  }
}
