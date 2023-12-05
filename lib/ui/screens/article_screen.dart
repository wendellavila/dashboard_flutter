import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'gallery_screen.dart';

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
    'title': "Subdir 1",
    'subtitle': "Placeholder Subdirectory",
    'date': "01/01/2023",
    'text':
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce mattis dapibus luctus.Pellentesque aliquam sapien id lorem varius, nec tempor leo vestibulum. Interdum et malesuada fames ac ante ipsum primis in faucibus.",
    'photos': ["assets/placeholder/placeholder.png"],
    'files': [],
    'links': [],
    'subdirs': [],
  };

  @override
  void initState() {
    super.initState();
  }

  Card _cardItem({Widget? child}) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: child,
      ),
    );
  }

  Widget _subdirList() {
    return Wrap(
      children: [
        for (int i = 0; i < (_data['subdirs'] as List).length; i++)
          Padding(
            padding: const EdgeInsets.all(1),
            child: ListTile(
              visualDensity: const VisualDensity(vertical: -3, horizontal: 0),
              tileColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
              textColor: Theme.of(context).colorScheme.onSurface,
              onTap: () => Beamer.of(context).beamToNamed(
                  "/${widget.menuData['route']}/view?p=${_data['subdirs'][i]['path']}&t=article&d=${(widget.showDate ? 1 : 0).toString()}"),
              title: Text(
                _data['subdirs'][i]['title'],
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  Widget _imageList() {
    return Wrap(
      children: [
        for (int i = 0; i < (_data['photos'] as List).length; i++)
          PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              if (didPop) return;
              print("did not pop");
            },
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => GalleryScreen(
                    photos: List<String>.from(_data['photos']),
                    startIndex: i,
                  ),
                );
              },
              child: Image.network(
                _data['photos'][i],
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
      ],
    );
  }

  List<Widget> _header() {
    return [
      if (_data['photos'] != null && (_data['photos'] as List).isNotEmpty)
        Container(
          constraints: const BoxConstraints(maxHeight: 400),
          child: Image(
            image: NetworkImage(_data['photos'][0]),
          ),
        ),
      const SizedBox(
        height: 40,
      ),
      Row(
        children: [
          Flexible(
            child: Text(
              _data['title'] ?? '',
              style: TextStyle(
                fontSize: 28,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              _data['subtitle'] ?? '',
              style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            widget.showDate && _data['date'] != null ? _data['date'] : '',
            style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
          ),
        ],
      ),
    ];
  }

  Widget _articleBody() {
    return SelectionArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width < 950 ? MediaQuery.of(context).size.width * 0.8 : MediaQuery.of(context).size.width * 0.6,
                child: _cardItem(
                  child: Column(
                    children: [
                      ..._header(),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        _data['text'].toString(),
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      _subdirList(),
                      _imageList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _articleBody(),
    );
  }
}
