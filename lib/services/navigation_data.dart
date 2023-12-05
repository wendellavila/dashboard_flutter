import 'package:flutter/material.dart';

class NavigationData {
  late List<Map> menuItems = [];
  final String baseUrl = Uri.base.origin;

  NavigationData._() {
    menuItems = [
      {
        'title': "Home",
        'route': 'home',
        'screen': 'home',
        'icon': Icons.home_outlined,
      },
      {
        'title': "Webview",
        'route': 'webview',
        'screen': 'web',
        'icon': Icons.public_outlined,
        'path': "https://flutter.dev",
      },
      {
        'title': "External",
        'route': 'external',
        'screen': 'external',
        'icon': Icons.exit_to_app_outlined,
        'path': "https://www.google.com",
      },
      {
        'title': "Restricted",
        'route': 'login',
        'screen': 'login',
        'icon': Icons.lock_outline,
        'path': "Restricted",
      },
      {
        'title': "Banner List",
        'route': 'banner',
        'screen': 'banner',
        'icon': Icons.grid_view_outlined,
        'path': "Banner List",
        'sort': 'dateDesc',
      },
      {
        'title': "Full Banner List",
        'route': 'fbanner',
        'screen': 'fbanner',
        'icon': Icons.view_agenda_outlined,
        'path': "Full Banner",
        'sort': 'nameDesc',
      },
      {
        'title': "Card List",
        'route': 'card',
        'screen': 'card',
        'icon': Icons.dashboard_outlined,
        'path': "Card List",
        'sort': 'dateDesc',
      },
      {
        'title': "Directory",
        'route': 'dir',
        'screen': 'dir',
        'icon': Icons.folder_outlined,
        'path': "Directory",
        'sort': 'nameDesc',
      },
    ];
  }

  static final NavigationData singletonInstance = NavigationData._();
}
