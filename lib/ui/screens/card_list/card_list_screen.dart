import 'package:flutter/material.dart';
import '../../widgets/filter_bar.dart';
import '../../widgets/page_header.dart';
import 'widgets/subdir_card.dart';

class CardListScreen extends StatefulWidget {
  const CardListScreen({
    required this.menuData,
    required this.baseUrl,
    this.path = '',
    this.sort = 'nameAsc',
    super.key,
  });

  final String path;
  final String sort;
  final String baseUrl;
  final Map menuData;

  @override
  State<CardListScreen> createState() => _CardListScreen();
}

class _CardListScreen extends State<CardListScreen> {
  final Map<String, dynamic> _data = {
    'path': "",
    'title': "Directory",
    'subtitle': "Placeholder Directory",
    'date': "01/01/2023",
    'text':
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce mattis dapibus luctus.Pellentesque aliquam sapien id lorem varius, nec tempor leo vestibulum. Interdum et malesuada fames ac ante ipsum primis in faucibus.",
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
      body: Container(
        margin: const EdgeInsets.only(left: 2),
        child: SelectionArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              primary: true,
              children: [
                const SizedBox(
                  height: 20,
                ),
                PageHeader(title: widget.menuData['title']),
                const SizedBox(
                  height: 8,
                ),
                FilterBar(onChanged: _filterData),
                const SizedBox(
                  height: 20,
                ),
                if (_subdirsFiltered.isNotEmpty) ...[
                  Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    children: [
                      for (int i = 0; i < _subdirsFiltered.length; i++) SubdirCard(route: widget.menuData['route'], subdir: _subdirsFiltered[i]),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
