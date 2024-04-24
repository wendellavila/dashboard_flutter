import 'package:flutter/material.dart';

import 'widgets/article_body.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({
    required this.menuData,
    required this.baseUrl,
    this.path = '',
    this.showDate = false,
    super.key,
  });

  final bool showDate;
  final String path;
  final String baseUrl;
  final Map menuData;

  @override
  State<ArticleScreen> createState() => _ArticleScreen();
}

class _ArticleScreen extends State<ArticleScreen> {
  int currentIndex = 0;
  final Map<String, dynamic> _data = {
    'path': "",
    'title': "Article",
    'subtitle': "Placeholder Article",
    'date': "01/01/2023",
    'text':
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce mattis dapibus luctus.Pellentesque aliquam sapien id lorem varius, nec tempor leo vestibulum. Interdum et malesuada fames ac ante ipsum primis in faucibus.",
    'type': "dir",
    'images': [
      {'type': "image", 'url': "assets/placeholder/placeholder.png"},
      {'type': "image", 'url': "assets/placeholder/placeholder.png"},
    ],
    'files': [],
    'links': [],
    'subdirs': [],
  };

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArticleBody(
          title: _data['title'] ?? '',
          subtitle: _data['subtitle'] ?? '',
          date: widget.showDate && _data['date'] != null ? _data['date'] : null,
          route: widget.menuData['route'],
          text: _data['text'] != null ? _data['text'].toString().replaceAll("\n", "\n\n") : '',
          images: _data['images'],
          subdirs: _data['subdirs'],
          showDate: widget.showDate),
    );
  }
}
