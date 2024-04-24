import 'package:flutter/material.dart';
import 'widgets/full_banner_list_body.dart';

class FullBannerListScreen extends StatefulWidget {
  const FullBannerListScreen({
    required this.menuData,
    required this.baseUrl,
    this.path = '',
    this.sort = '',
    this.isRoot = true,
    super.key,
  });

  final bool isRoot;
  final String path;
  final String sort;
  final String baseUrl;
  final Map menuData;

  @override
  State<FullBannerListScreen> createState() => _FullBannerListScreen();
}

class _FullBannerListScreen extends State<FullBannerListScreen> {
  final Map<String, dynamic> _data = {
    'path': "",
    'title': "Directory",
    'subtitle': "Placeholder Directory",
    'type': "dir",
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
    'subdirs': [
      {
        'type': "dir",
        'path': "",
        'title': "Subdir 1",
        'subtitle': "Placeholder Subdirectory",
        'date': "01/01/2023",
        'text':
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce mattis dapibus luctus.Pellentesque aliquam sapien id lorem varius, nec tempor leo vestibulum. Interdum et malesuada fames ac ante ipsum primis in faucibus.",
        'images': [
          {"type": "image", "url": "assets/placeholder/placeholder.png"}
        ],
      },
      {
        'type': "dir",
        'path': "",
        'title': "Subdir 2",
        'subtitle': "Placeholder Subdirectory 2",
        'date': "02/02/2022",
        'text':
            "Lorem ipsum dolor sit amet, sed dictum nisi laoreet porta. Cras molestie diam est, ac viverra purus scelerisque eget. Interdum et malesuada fames ac ante ipsum primis in faucibus.",
        'images': [
          {
            'type': "image",
            'url': "assets/placeholder/placeholder.png",
          }
        ],
      }
    ],
  };
  List<Map<String, dynamic>> _subdirsFull = [];
  List<Map<String, dynamic>> _subdirsFiltered = [];
  final String _count = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    _subdirsFull = (_data['subdirs'] as List).map((item) => item as Map<String, dynamic>).toList();
    setState(() {
      _subdirsFiltered = _subdirsFull;
    });
    _loadCount();
  }

  void _loadCount() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FullBannerListBody(
        count: _count,
        title: widget.menuData['title'],
        route: widget.menuData['route'],
        files: _data['files'],
        subdirs: _subdirsFiltered,
        image: (_data['images'] as List).isNotEmpty ? _data['images'][0]['url'] : null,
        isRoot: widget.isRoot,
      ),
    );
  }
}
