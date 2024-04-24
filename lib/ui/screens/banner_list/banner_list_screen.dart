import 'package:flutter/material.dart';
import 'widgets/banner_list_body.dart';

class BannerListScreen extends StatefulWidget {
  const BannerListScreen({
    required this.menuData,
    required this.baseUrl,
    this.path = '',
    this.sort = '',
    super.key,
  });

  final String path;
  final String sort;
  final String baseUrl;
  final Map menuData;

  @override
  State<BannerListScreen> createState() => _BannerListScreen();
}

class _BannerListScreen extends State<BannerListScreen> {
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
  }

  void _filterData(String filterString) {
    filterString = filterString.toLowerCase();
    List<Map<String, dynamic>> filteredData = [];

    if (_subdirsFull.isNotEmpty) {
      for (final folder in _subdirsFull) {
        final String title = folder['title'].toString().toLowerCase();
        final String subtitle = folder['subtitle'].toString().toLowerCase();
        final String date = folder['date'].toString().toLowerCase();
        if (title.contains(filterString) || subtitle.contains(filterString) || date.contains(filterString)) {
          filteredData.add(folder);
        }
      }
      setState(() {
        _subdirsFiltered = filteredData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BannerListBody(
        title: widget.menuData['title'],
        route: widget.menuData['route'],
        onChanged: _filterData,
        subdirs: _subdirsFiltered,
      ),
    );
  }
}
