import 'package:flutter/material.dart';
import '../../../widgets/page_header.dart';
import '../../../widgets/page_banner.dart';
import 'link_list.dart';

class ImageLinkBody extends StatefulWidget {
  const ImageLinkBody({
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
  State<ImageLinkBody> createState() => _ImageLinkBody();
}

class _ImageLinkBody extends State<ImageLinkBody> {
  final Map<String, dynamic> _data = {
    'images': [
      {'type': "image", 'url': "assets/placeholder/placeholder.png"},
      {'type': "image", 'url': "assets/placeholder/placeholder.png"},
    ],
    'files': [],
    'links': [
      {
        'type': "link",
        'url': "https://www.google.com",
        'text': "External Link 1",
        'target': "_blank",
      },
      {
        'type': "link",
        'url': "https://www.google.com",
        'text': "External Link 2",
        'target': "_blank",
      }
    ],
  };

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {}

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: true,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        const SizedBox(
          height: 20,
        ),
        PageHeader(title: widget.menuData['title']),
        const SizedBox(
          height: 20,
        ),
        if (widget.showBanner)
          PageBanner(
            images: (_data['images'] as List<dynamic>),
          ),
        LayoutBuilder(
          builder: (context, constraints) {
            return Align(
              alignment: Alignment.topCenter,
              child: Container(
                alignment: Alignment.topCenter,
                width: constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth,
                child: LinkList(
                  route: widget.menuData['route'],
                  links: (_data['links'] as List<dynamic>),
                ),
              ),
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
