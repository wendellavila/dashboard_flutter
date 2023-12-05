import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'gallery_screen.dart';

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
    'photos': [
      "assets/placeholder/placeholder.png",
      "assets/placeholder/placeholder.png",
    ],
    'files': [],
    'links': [
      {
        "url": "https://www.google.com",
        "text": "External Link 1",
        "target": "_blank",
      },
      {
        "url": "https://www.google.com",
        "text": "External Link 2",
        "target": "_blank",
      }
    ],
    'subdirs': [
      {
        'path': "",
        'title': "Subdir 1",
        'subtitle': "Placeholder Subdirectory",
        'date': "01/01/2023",
        'text':
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce mattis dapibus luctus.Pellentesque aliquam sapien id lorem varius, nec tempor leo vestibulum. Interdum et malesuada fames ac ante ipsum primis in faucibus.",
        'photos': ["assets/placeholder/placeholder.png"],
      },
      {
        'path': "",
        'title': "Subdir 2",
        'subtitle': "Placeholder Subdirectory 2",
        'date': "02/02/2022",
        'text':
            "Lorem ipsum dolor sit amet, sed dictum nisi laoreet porta. Cras molestie diam est, ac viverra purus scelerisque eget. Interdum et malesuada fames ac ante ipsum primis in faucibus.",
        'photos': ["assets/placeholder/placeholder.png"],
      }
    ],
  };

  @override
  void initState() {
    super.initState();
  }

  Widget _header() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 820) {
          return Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _data['title'] ?? '',
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      _data['subtitle'] ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.showDate == true && _data['date'] != null) ...[
                //const Spacer(),
                Text(
                  _data['date'] ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ],
          );
        } else {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _data['title'] ?? '',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                _data['subtitle'] ?? '',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
              ),
              if (widget.showDate == true && _data['date'] != null) ...[
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      _data['date'] ?? '',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ],
                ),
              ],
            ],
          );
        }
      },
    );
  }

  String _getPdfName({required String path}) {
    return path.substring(path.lastIndexOf('/') + 1, path.length - 4).replaceAll('%20', ' ');
  }

  Widget _fileList() {
    return Wrap(
      children: [
        for (int i = 0; i < (_data['files'] as List).length; i++)
          Padding(
            padding: const EdgeInsets.all(1),
            child: ListTile(
              visualDensity: const VisualDensity(vertical: -3, horizontal: 0),
              tileColor: Theme.of(context).colorScheme.surface,
              hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
              textColor: Theme.of(context).colorScheme.onSurface,
              onTap: () => Beamer.of(context).beamToNamed("/${widget.menuData['route']}/view?p=${_data['files'][i].toString()}&t=web"),
              title: Text(
                _getPdfName(path: _data['files'][i].toString()),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
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
              tileColor: Theme.of(context).colorScheme.surface,
              hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
              textColor: Theme.of(context).colorScheme.onSurface,
              onTap: () => Beamer.of(context).beamToNamed(
                  "/${widget.menuData['route']}/view?p=${_data['subdirs'][i]['path']}&t=dir&d=${(widget.showDate ? 1 : 0).toString()}&s=${widget.sort}"),
              title: Text(
                _data['subdirs'][i]['title'],
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  Widget _linkList() {
    return Wrap(
      children: [
        for (int i = 0; i < (_data['links'] as List).length; i++)
          Padding(
            padding: const EdgeInsets.all(1),
            child: ListTile(
              visualDensity: const VisualDensity(vertical: -3, horizontal: 0),
              tileColor: Theme.of(context).colorScheme.surface,
              hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
              textColor: Theme.of(context).colorScheme.onSurface,
              onTap: () {
                if (_data['links'][i]['target'] == '_blank' || _data['links'][i]['target'] == 'blank') {
                  launchUrl(Uri.parse(_data['links'][i]['url']));
                } else {
                  Beamer.of(context).beamToNamed("/${widget.menuData['route']}/view?p=${_data['links'][i]['url']}&t=web");
                }
              },
              title: Text(
                _data['links'][i]['text'],
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
        for (int i = (widget.showBanner ? 1 : 0); i < (_data['photos'] as List).length; i++)
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => GalleryScreen(
                  photos: List<String>.from(_data['photos']).sublist(widget.showBanner ? 1 : 0),
                  startIndex: widget.showBanner ? i - 1 : i,
                ),
              );
            },
            child: Image.asset(
              _data['photos'][i],
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
      ],
    );
  }

  List<Widget> _banner() {
    return [
      if (_data['photos'] != null && (_data['photos'] as List).isNotEmpty)
        Center(
          child: Container(
            constraints: const BoxConstraints(maxHeight: 400),
            child: Image.asset(_data['photos'][0]),
          ),
        ),
      const SizedBox(
        height: 40,
      ),
    ];
  }

  Widget _dirViewerBody() {
    return SelectionArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Align(
          alignment: Alignment.topLeft,
          child: ListView(
            primary: true,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 20,
              ),
              _header(),
              const SizedBox(
                height: 20,
              ),
              if (widget.showBanner) ..._banner(),
              if (_data['text'] != null)
                Center(
                  child: SizedBox(
                    width:
                        MediaQuery.of(context).size.width < 950 ? MediaQuery.of(context).size.width * 0.8 : MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      _data['text'].toString(),
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              Center(
                child: _linkList(),
              ),
              Center(
                child: _fileList(),
              ),
              Center(
                child: _subdirList(),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: _imageList(),
              ),
              const SizedBox(
                height: 20,
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
      body: _dirViewerBody(),
    );
  }
}
