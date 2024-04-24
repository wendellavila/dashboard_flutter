import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class SubdirCard extends StatelessWidget {
  const SubdirCard({
    super.key,
    required this.route,
    required this.subdir,
  });

  final String route;
  final dynamic subdir;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      hoverColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
      onTap: () => Beamer.of(context).beamToNamed("/$route/view?p=${subdir['path']}&t=article&b=1&d=1"),
      child: SizedBox(
        width: 350,
        height: 380,
        child: Card(
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: (subdir['images'] as List).isEmpty
                        ? const AssetImage("assets/img/placeholder/placeholder.jpg") as ImageProvider
                        : NetworkImage(
                            subdir['images'][0]['url'],
                          ),
                  ),
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14, right: 14, top: 10),
                      child: Text(
                        subdir['title'] ?? '',
                        style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.onSurface),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                  child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14, right: 14, bottom: 12, top: 0),
                      child: Text(
                        subdir['text'] ?? '',
                        maxLines: 4,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                  ),
                ],
              )),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14, right: 14, bottom: 12, top: 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Symbols.account_circle_sharp,
                                  weight: 650,
                                  size: 18,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    subdir['subtitle'] ?? '',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            subdir['date'] ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
