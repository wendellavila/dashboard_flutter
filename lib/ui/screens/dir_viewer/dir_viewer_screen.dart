import 'package:flutter/material.dart';
import 'widgets/dir_viewer_body.dart';

class DirViewerScreen extends StatefulWidget {
  const DirViewerScreen({
    required this.menuData,
    required this.baseUrl,
    this.path = '',
    this.showDate = false,
    this.showBanner = false,
    this.sort = 'nameAsc',
    super.key,
  });

  final bool showDate;
  final bool showBanner;
  final String path;
  final String sort;
  final String baseUrl;
  final Map menuData;

  @override
  State<DirViewerScreen> createState() => _DirViewerScreen();
}

class _DirViewerScreen extends State<DirViewerScreen> {
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
  final String _count = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadCount() async {}

  void _loadData() async {
    _loadCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DirViewerBody(
        title: widget.menuData['title'] ?? '',
        subtitle: _data['subtitle'] ?? '',
        route: widget.menuData['route'] ?? '',
        date: widget.showDate == true && _data['date'] != null ? _data['date'] : null,
        text: _data['text'] ?? '',
        count: _count,
        files: _data['files'] ?? [],
        subdirs: _data['subdirs'],
        links: _data['links'] ?? [],
        images: _data['images'] ?? [],
        showBanner: widget.showBanner,
        showDate: widget.showDate,
      ),
    );
  }
}
