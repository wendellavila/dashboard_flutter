import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkList extends StatelessWidget {
  const LinkList({
    super.key,
    required this.route,
    required this.links,
  });
  final String route;
  final List links;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (int i = 0; i < links.length; i++)
          InkWell(
            borderRadius: BorderRadius.circular(6),
            hoverColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
            onTap: () {
              if (links[i]['target'] == '_blank' || links[i]['target'] == 'blank') {
                launchUrl(Uri.parse(links[i]['url']));
              } else {
                Beamer.of(context).beamToNamed("/$route/view?p=${links[i]['url']}&t=web");
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                width: 400,
                child: links[i]['image'] != null
                    ? Image(
                        image: links[i]['image'].substring(0, 4) == 'http'
                            ? NetworkImage(links[i]['image'])
                            : AssetImage(links[i]['image']) as ImageProvider,
                      )
                    : Text(
                        links[i]['text'] ?? (links[i]['url'] ?? ""),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20),
                      ),
              ),
            ),
          ),
      ],
    );
  }
}
