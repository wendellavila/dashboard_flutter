import 'package:flutter/material.dart';

import '../screens/gallery/gallery_screen.dart';

class ImageList extends StatelessWidget {
  const ImageList({
    super.key,
    required this.images,
    this.showBanner = false,
  });

  final List images;
  final bool showBanner;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (int i = (showBanner ? 1 : 0); i < images.length; i++)
          PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              if (didPop) return;
            },
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => GalleryScreen(
                    photos: List<String>.from(images.map((entry) => entry['url'])),
                    startIndex: i,
                  ),
                );
              },
              child: images[i]['url'].substring(0, 4) == 'http'
                  ? Image.network(
                      images[i]['url'],
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      images[i]['url'],
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
      ],
    );
  }
}
