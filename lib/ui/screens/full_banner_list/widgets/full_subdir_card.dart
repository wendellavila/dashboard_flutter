import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class FullSubdirCard extends StatelessWidget {
  const FullSubdirCard({
    super.key,
    required this.route,
    required this.path,
    required this.isRoot,
    required this.subdir,
    this.extraQueryParameters = '',
  });

  final String route;
  final String path;
  final bool isRoot;
  final dynamic subdir;
  final String extraQueryParameters;

  @override
  Widget build(BuildContext context) {
    String image = (subdir['images'] as List).isNotEmpty ? subdir['images'][0]['url'] : "assets/img/placeholder/placeholder.jpg";

    return InkWell(
      borderRadius: BorderRadius.circular(6),
      hoverColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
      onTap: () => Beamer.of(context).beamToNamed("/$route/view?p=${subdir['path']}&t=${isRoot ? 'fbanner' : 'dir'}&d=1&b=1&r=0&s=nameAsc"),
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: 700,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: image.substring(0, 4) == 'http' ? NetworkImage(image) : AssetImage(image) as ImageProvider,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: 700,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      subdir['title'] ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
