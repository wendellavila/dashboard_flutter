import 'package:flutter/material.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

import 'home_card.dart';

class Embed extends StatelessWidget {
  const Embed({
    super.key,
    required this.title,
    required this.url,
    required this.icon,
  });

  final String title;
  final String url;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return HomeCard(
      title: title,
      icon: icon,
      child: SizedBox(
        height: 230,
        child: PlatformWebViewWidget(
          PlatformWebViewWidgetCreationParams(
            controller: PlatformWebViewController(
              const PlatformWebViewControllerCreationParams(),
            )..loadRequest(
                LoadRequestParams(
                  uri: Uri.parse(url),
                ),
              ),
          ),
        ).build(context),
      ),
    );
  }
}
