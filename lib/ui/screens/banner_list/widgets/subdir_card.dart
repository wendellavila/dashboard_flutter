import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class SubdirCard extends StatelessWidget {
  const SubdirCard({
    super.key,
    required this.route,
    required this.path,
    required this.isRoot,
    required this.subdir,
    this.extraQueryParams = '',
  });

  final String route;
  final String path;
  final bool isRoot;
  final dynamic subdir;
  final String extraQueryParams;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      hoverColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
      onTap: () => Beamer.of(context).beamToNamed("/$route/view?p=$path&t=dir&d=1&b=1$extraQueryParams"),
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: 500,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: (subdir['images'] as List).isEmpty
                      ? const AssetImage("assets/img/placeholder/placeholder.jpg") as ImageProvider
                      : AssetImage(
                          subdir['images'][0]['url'],
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              width: 500,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14, right: 14, top: 10),
                      child: Text(
                        subdir['title'] ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    subdir['subtitle'] ?? '',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    subdir['date'] ?? '',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
