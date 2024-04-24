import 'package:flutter/material.dart';
import '../../widgets/card_item.dart';
import 'widgets/webview_body.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({
    required this.menuData,
    this.path = '',
    super.key,
  });

  final String path;
  final Map menuData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: CardItem(
          padding: const EdgeInsets.all(12),
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: WebviewBody(
              menuData: menuData,
              path: path,
            ),
          ),
        ),
      ),
    );
  }
}
