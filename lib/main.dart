/*
run
flutter run -d chrome --web-renderer=html

build:
flutter build web --release --pwa-strategy=offline-first --web-renderer=html
*/
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

import 'services/navigation_data.dart';
import 'services/theme_provider.dart';
import 'ui/screens/banner_list_screen.dart';
import 'ui/screens/dir_viewer_screen.dart';
import 'ui/screens/card_list_screen.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/external_screen.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/full_banner_list_screen.dart';
import 'ui/screens/webview_screen.dart';
import 'ui/widgets/route_switcher.dart';

import 'ui/widgets/sidebar.dart';

void main() async {
  ThemeProvider themeProvider = await ThemeProvider.create();
  runApp(
    ChangeNotifierProvider(
      create: (context) => themeProvider,
      child: const MyApp(),
    ),
  );
}

final NavigationData _navigationData = NavigationData.singletonInstance;

//PageStorage for storing and restoring sidebar scroll position across all pages
final PageStorage sideBar = PageStorage(
  bucket: PageStorageBucket(),
  key: const PageStorageKey('sidebar'),
  child: const SideBar(),
);

Map<Pattern, dynamic Function(BuildContext, BeamState, Object?)> _beamerRoutes() {
  Map<Pattern, dynamic Function(BuildContext, BeamState, Object?)> routes = {};

  for (final item in _navigationData.menuItems) {
    routes["/${item['route']}"] = (context, state, data) => BeamPage(
          key: ValueKey(item['route']),
          title: "dashboard_flutter - ${item['title']}",
          child: Scaffold(
            body: Row(
              children: [
                sideBar,
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 2),
                    child: switch (item['screen']) {
                      'external' => ExternalScreen(
                          menuData: item,
                        ),
                      'login' => LoginScreen(
                          menuData: item,
                          baseUrl: _navigationData.baseUrl,
                        ),
                      'dir' => DirViewerScreen(
                          menuData: item,
                          baseUrl: _navigationData.baseUrl,
                          showBanner: item['showBanner'] == true,
                          sort: item['sort'] ?? '',
                        ),
                      'card' => CardListScreen(
                          menuData: item,
                          baseUrl: _navigationData.baseUrl,
                          sort: item['sort'] ?? '',
                        ),
                      'banner' => BannerListScreen(
                          menuData: item,
                          baseUrl: _navigationData.baseUrl,
                          sort: item['sort'] ?? '',
                        ),
                      'fbanner' => FullBannerListScreen(
                          menuData: item,
                          baseUrl: _navigationData.baseUrl,
                          sort: item['sort'] ?? '',
                        ),
                      'web' => WebViewScreen(
                          menuData: item,
                        ),
                      _ => HomeScreen(
                          menuData: item,
                          baseUrl: _navigationData.baseUrl,
                        ),
                    },
                  ),
                ),
              ],
            ),
          ),
        );
    routes["/${item['route']}/view"] = (context, state, data) {
      String type = state.uri.queryParameters['t'] ?? '';
      String path = state.uri.queryParameters['p'] ?? (item['route'] ?? '');
      String sort = state.uri.queryParameters['s'] ?? (item['sort'] ?? 'nameAsc');
      //Parsing String values 0 or 1 to bool
      bool showBanner = state.uri.queryParameters['b'] != null ? (int.parse(state.uri.queryParameters['b'].toString()) == 1 ? true : false) : false;
      bool showDate = state.uri.queryParameters['d'] != null ? (int.parse(state.uri.queryParameters['d'].toString()) == 1 ? true : false) : true;

      return BeamPage(
        key: ValueKey("${item['route']}/view?p=$path&t=$type&s=$sort&b=$showBanner&d=$showDate"),
        title: "dashboard_flutter - ${item['title']}",
        child: Scaffold(
          body: Row(
            children: [
              sideBar,
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 2),
                  child: RouteSwitcher(
                    menuData: item,
                    baseUrl: _navigationData.baseUrl,
                    path: path,
                    type: type,
                    sort: sort,
                    showBanner: showBanner,
                    showDate: showDate,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    };
  }
  return routes;
}

final routerDelegate = BeamerDelegate(
  initialPath: "/home",
  notFoundRedirectNamed: "/home",
  locationBuilder: RoutesLocationBuilder(
    routes: _beamerRoutes(),
  ),
);

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final PageTransitionsTheme pageTransitionsTheme = const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: NoTransitionsBuilder(),
      TargetPlatform.macOS: NoTransitionsBuilder(),
      TargetPlatform.windows: NoTransitionsBuilder(),
    },
  );

  ThemeData _themeData({required ThemeMode themeMode}) {
    return ThemeData(
      useMaterial3: false,
      fontFamily: "Archivo",
      pageTransitionsTheme: pageTransitionsTheme,
      colorScheme: themeMode == ThemeMode.dark
          ? const ColorScheme(
              brightness: Brightness.dark,
              primary: Color(0xFF72832D),
              onPrimary: Color(0XFFFFFFFF),
              background: Color(0XFF546122),
              onBackground: Color(0XFFFFFFFF),
              secondary: Color(0XFF563c2f),
              onSecondary: Color(0XFF1d1b19),
              tertiary: Color(0XFFE77573),
              onTertiary: Color(0XFFFFFFFF),
              surface: Color(0XFF373737),
              onSurface: Color.fromARGB(255, 230, 230, 230),
              error: Color(0XFFff9090),
              onError: Color(0XFFC6504E),
            )
          : const ColorScheme(
              brightness: Brightness.light,
              primary: Color(0XFF546122),
              onPrimary: Color(0XFFFFFFFF),
              background: Color(0XFF546122),
              onBackground: Color(0XFFFFFFFF),
              secondary: Color(0XFF563c2f),
              onSecondary: Color(0XFF1d1b19),
              tertiary: Color(0XFFE77573),
              onTertiary: Color(0XFFFFFFFF),
              surface: Color(0XFFFFFFFF),
              onSurface: Color(0XFF1d1b19),
              error: Color(0XFFff9090),
              onError: Color(0XFFC6504E),
            ),
      scaffoldBackgroundColor: themeMode == ThemeMode.dark ? const Color(0XFF454545) : const Color.fromARGB(255, 245, 245, 242),
      hoverColor: themeMode == ThemeMode.dark ? const Color.fromARGB(60, 100, 100, 100) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp.router(
          title: 'dashboard_flutter',
          theme: _themeData(themeMode: ThemeMode.light),
          darkTheme: _themeData(themeMode: ThemeMode.dark),
          themeMode: themeProvider.getTheme(),
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

//Remove animation from page transitions
class NoTransitionsBuilder extends PageTransitionsBuilder {
  const NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T>? route,
    BuildContext? context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget? child,
  ) {
    return child!;
  }
}
