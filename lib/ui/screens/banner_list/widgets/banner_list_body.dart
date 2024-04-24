import 'package:flutter/material.dart';

import '../../../widgets/page_header.dart';
import '../../../widgets/filter_bar.dart';
import 'subdir_card.dart';

class BannerListBody extends StatelessWidget {
  const BannerListBody({
    super.key,
    required this.title,
    required this.route,
    required this.onChanged,
    required this.subdirs,
  });

  final String title;
  final String route;
  final Function(String p1) onChanged;
  final List subdirs;

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          primary: true,
          children: [
            const SizedBox(
              height: 20,
            ),
            PageHeader(title: title),
            const SizedBox(
              height: 8,
            ),
            FilterBar(onChanged: onChanged),
            const SizedBox(
              height: 20,
            ),
            if (subdirs.isNotEmpty) ...[
              Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  for (dynamic subdir in subdirs)
                    SubdirCard(
                      route: route,
                      path: subdir['path'],
                      isRoot: false,
                      subdir: subdir,
                    ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
