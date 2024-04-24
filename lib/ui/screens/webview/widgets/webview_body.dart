import 'package:flutter/material.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

class WebviewBody extends StatefulWidget {
  const WebviewBody({super.key, required this.menuData, required this.path});
  final String path;
  final Map menuData;

  @override
  State<WebviewBody> createState() => _WebviewBodyState();
}

class _WebviewBodyState extends State<WebviewBody> {
  late PlatformWebViewController _controller;
  @override
  void initState() {
    super.initState();
    WebViewPlatform.instance = WebWebViewPlatform();
    _setController();
  }

  void _setController() {
    _controller = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams(),
    )..loadRequest(
        LoadRequestParams(
          uri: Uri.parse(
            widget.path == '' ? widget.menuData['path'] : widget.path,
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWebViewWidget(
      PlatformWebViewWidgetCreationParams(controller: _controller),
    ).build(context);
  }
}
