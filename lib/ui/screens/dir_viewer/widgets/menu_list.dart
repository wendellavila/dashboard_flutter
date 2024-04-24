import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:collection';

class MenuList extends StatelessWidget {
  const MenuList({
    super.key,
    required this.files,
    required this.subdirs,
    required this.links,
    required this.route,
    required this.showBanner,
    required this.showDate,
  });

  final List files;
  final List subdirs;
  final List links;
  final String route;
  final bool showBanner;
  final bool showDate;

  String _getPdfName({required String path}) {
    return path.substring(path.lastIndexOf('/') + 1, path.length - 4).replaceAll('%20', ' ');
  }

  String _getMenuListTitle(dynamic item) {
    if (item['type'] == 'file') {
      return _getPdfName(path: item['url'].toString());
    } else if (item['type'] == 'dir') {
      return item['title'].toString();
    } else if (item['type'] == 'link') {
      return item['text'].toString();
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> fileItems = {for (var file in files) file.toString(): file};
    Map<String, dynamic> subdirItems = {for (var subdir in subdirs) subdir['title']: subdir};
    Map<String, dynamic> linkItems = {for (var link in links) link['text']: link};

    SplayTreeMap<String, dynamic> orderedItems = SplayTreeMap<String, dynamic>();

    orderedItems
      ..addAll(fileItems)
      ..addAll(subdirItems)
      ..addAll(linkItems);

    List itemList = [...orderedItems.entries.map((entry) => entry.value)];

    return Wrap(
      children: [
        for (var item in itemList)
          Padding(
            padding: const EdgeInsets.all(1),
            child: ListTile(
              visualDensity: const VisualDensity(vertical: -3, horizontal: 0),
              tileColor: Theme.of(context).colorScheme.surface,
              hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
              splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
              textColor: Theme.of(context).colorScheme.onSurface,
              onTap: () {
                if (item['type'] == 'file') {
                  Beamer.of(context).beamToNamed("/$route/view?p=${item['url'].toString()}&t=web");
                } else if (item['type'] == 'dir') {
                  Beamer.of(context)
                      .beamToNamed("/$route/view?p=${item['path']}&t=dir&b=${(showBanner ? 1 : 0).toString()}&d=${(showDate ? 1 : 0).toString()}");
                } else if (item['type'] == 'link') {
                  if (item['target'] == '_blank' || item['target'] == 'blank') {
                    launchUrl(Uri.parse(item['url']));
                  } else {
                    Beamer.of(context).beamToNamed("/$route/view?p=${item['url']}&t=web");
                  }
                }
              },
              title: Text(
                _getMenuListTitle(item),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
