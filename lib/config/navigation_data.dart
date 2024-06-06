import 'package:material_symbols_icons/material_symbols_icons.dart';

class NavigationData {
  late List<Map> menuItems = [];
  final String baseUrl = Uri.base.origin + Uri.base.path;

  NavigationData._() {
    menuItems = [
      {
        'title': "Home",
        'route': 'home',
        'screen': 'home',
        'icon': Symbols.home_sharp,
      },
      {
        'title': "Webview",
        'route': 'webview',
        'screen': 'web',
        'icon': Symbols.public_sharp,
        'path': "https://flutter.dev",
      },
      {
        'title': "External",
        'route': 'external',
        'screen': 'external',
        'icon': Symbols.exit_to_app_sharp,
        'path': "https://www.google.com",
      },
      {
        'title': "Restricted",
        'route': 'restricted',
        'screen': 'restricted',
        'icon': Symbols.lock_sharp,
        'path': "Restricted",
      },
      {
        'title': "Banner List",
        'route': 'banner',
        'screen': 'banner',
        'icon': Symbols.grid_view_sharp,
        'path': "Banner List",
        'sort': 'dateDesc',
      },
      {
        'title': "Full Banner List",
        'route': 'fbanner',
        'screen': 'fbanner',
        'icon': Symbols.view_agenda_sharp,
        'path': "Full Banner",
        'sort': 'nameDesc',
      },
      {
        'title': "Card List",
        'route': 'card',
        'screen': 'card',
        'icon': Symbols.dashboard_sharp,
        'path': "Card List",
        'sort': 'dateDesc',
      },
      {
        'title': "Directory",
        'route': 'dir',
        'screen': 'dir',
        'icon': Symbols.folder_sharp,
        'path': "Directory",
        'sort': 'nameDesc',
      },
    ];
  }

  static final NavigationData singletonInstance = NavigationData._();
}
