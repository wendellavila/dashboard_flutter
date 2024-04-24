import 'package:flutter/material.dart';

import 'widgets/image_link_body.dart';

class ImageLinkScreen extends StatelessWidget {
  const ImageLinkScreen({
    required this.menuData,
    required this.baseUrl,
    this.path = '',
    this.showBanner = false,
    super.key,
  });

  final bool showBanner;
  final String path;
  final String baseUrl;
  final Map menuData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.topLeft,
            child: ImageLinkBody(
              menuData: menuData,
              baseUrl: baseUrl,
              showBanner: showBanner,
              path: path,
            ),
          ),
        ),
      ),
    );
  }
}
