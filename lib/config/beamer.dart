import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'navigation_data.dart';

import '../ui/screens/banner_list/banner_list_screen.dart';
import '../ui/screens/dir_viewer/dir_viewer_screen.dart';
import '../ui/screens/card_list/card_list_screen.dart';
import '../ui/screens/home/home_screen.dart';
import '../ui/screens/external/external_screen.dart';
import '../ui/screens/restricted/restricted_screen.dart';
import '../ui/screens/full_banner_list/full_banner_list_screen.dart';
import '../ui/screens/webview/webview_screen.dart';

import '../ui/widgets/route_switcher.dart';
import 'sidebar_scroll_storage.dart';

final NavigationData navigationData = NavigationData.singletonInstance;

Map<Pattern, dynamic Function(BuildContext, BeamState, Object?)> _beamerRoutes() {
  Map<Pattern, dynamic Function(BuildContext, BeamState, Object?)> routes = {};

  for (final item in navigationData.menuItems) {
    routes["/${item['route']}"] = (context, state, data) => BeamPage(
          key: ValueKey(item['route']),
          title: "dashboard_flutter - ${item['title']}",
          child: Scaffold(
            body: Row(
              children: [
                sidebarScrollStorage,
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 2),
                    child: switch (item['screen']) {
                      'external' => ExternalScreen(
                          menuData: item,
                        ),
                      'restricted' => RestrictedScreen(
                          menuData: item,
                          baseUrl: navigationData.baseUrl,
                        ),
                      'dir' => DirViewerScreen(
                          menuData: item,
                          baseUrl: navigationData.baseUrl,
                          showBanner: item['showBanner'] == true,
                          sort: item['sort'] ?? '',
                        ),
                      'card' => CardListScreen(
                          menuData: item,
                          baseUrl: navigationData.baseUrl,
                          sort: item['sort'] ?? '',
                        ),
                      'banner' => BannerListScreen(
                          menuData: item,
                          baseUrl: navigationData.baseUrl,
                          sort: item['sort'] ?? '',
                        ),
                      'fbanner' => FullBannerListScreen(
                          menuData: item,
                          baseUrl: navigationData.baseUrl,
                          sort: item['sort'] ?? '',
                        ),
                      'web' => WebViewScreen(
                          menuData: item,
                        ),
                      _ => HomeScreen(
                          menuData: item,
                          baseUrl: navigationData.baseUrl,
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
              sidebarScrollStorage,
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 2),
                  child: RouteSwitcher(
                    menuData: item,
                    baseUrl: navigationData.baseUrl,
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
