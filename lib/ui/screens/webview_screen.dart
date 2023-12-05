import 'package:flutter/material.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    required this.menuData,
    this.path = '',
    super.key,
  });

  final String path;
  final Map menuData;

  @override
  State<WebViewScreen> createState() => _WebViewScreen();
}

class _WebViewScreen extends State<WebViewScreen> {
  late PlatformWebViewController _controller;
  @override
  void initState() {
    super.initState();
    WebViewPlatform.instance = WebWebViewPlatform();
    _setController();
  }

  Card _cardItem({Widget? child}) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          child: child,
        ),
      ),
    );
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

  Widget _webviewBody() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: _cardItem(
        child: PlatformWebViewWidget(
          PlatformWebViewWidgetCreationParams(controller: _controller),
        ).build(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _webviewBody(),
    );
  }
}
