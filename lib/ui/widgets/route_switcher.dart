import 'package:flutter/material.dart';

import '../screens/article_screen.dart';
import '../screens/banner_list_screen.dart';
import '../screens/card_list_screen.dart';
import '../screens/dir_viewer_screen.dart';
import '../screens/full_banner_list_screen.dart';
import '../screens/webview_screen.dart';

class RouteSwitcher extends StatelessWidget {
  const RouteSwitcher({
    required this.menuData,
    required this.baseUrl,
    this.path = '',
    this.type = '',
    this.sort = 'nameAsc',
    this.showBanner = false,
    this.showDate = true,
    super.key,
  });

  final bool showDate;
  final bool showBanner;
  final String sort;
  final String path;
  final String type;
  final String baseUrl;
  final Map menuData;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      'article' => ArticleScreen(
          menuData: menuData,
          baseUrl: baseUrl,
          path: path,
          showDate: showDate,
        ),
      'banner' => BannerListScreen(
          menuData: menuData,
          baseUrl: baseUrl,
          path: path,
          sort: sort,
        ),
      'card' => CardListScreen(
          menuData: menuData,
          baseUrl: baseUrl,
          path: path,
          sort: sort,
        ),
      'fbanner' => FullBannerListScreen(
          menuData: menuData,
          baseUrl: baseUrl,
          path: path,
          sort: sort,
        ),
      'web' => WebViewScreen(
          menuData: menuData,
          path: path,
        ),
      _ => DirViewerScreen(
          menuData: menuData,
          baseUrl: baseUrl,
          path: path,
          sort: sort,
          showBanner: showBanner,
          showDate: showDate,
        ),
    };
  }
}
