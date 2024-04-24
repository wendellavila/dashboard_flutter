import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';

class SubdirList extends StatelessWidget {
  const SubdirList({
    super.key,
    required this.subdirs,
    required this.showDate,
    required this.route,
  });

  final List subdirs;
  final bool showDate;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (int i = 0; i < subdirs.length; i++)
          Padding(
            padding: const EdgeInsets.all(1),
            child: ListTile(
              visualDensity: const VisualDensity(vertical: -3, horizontal: 0),
              tileColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
              splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
              textColor: Theme.of(context).colorScheme.onSurface,
              onTap: () => Beamer.of(context).beamToNamed("/$route/view?p=${subdirs[i]['path']}&t=article&d=${(showDate ? 1 : 0).toString()}"),
              title: Text(
                subdirs[i]['title'],
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
