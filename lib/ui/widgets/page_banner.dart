import 'package:flutter/material.dart';

class PageBanner extends StatelessWidget {
  const PageBanner({
    super.key,
    required this.images,
  });

  final List images;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxHeight: 400),
        margin: const EdgeInsets.only(bottom: 40),
        child: images.isEmpty
            ? const SizedBox.shrink()
            : images[0]['url'].substring(0, 4) == 'http'
                ? Image.network(
                    images[0]['url'],
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    images[0]['url'],
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
      ),
    );
  }
}
