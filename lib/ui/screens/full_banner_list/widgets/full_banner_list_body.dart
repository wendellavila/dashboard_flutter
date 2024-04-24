import 'package:flutter/material.dart';

import '../../../widgets/page_header.dart';
import 'file_list.dart';
import 'full_subdir_card.dart';
import '../../../widgets/access_count.dart';

class FullBannerListBody extends StatelessWidget {
  const FullBannerListBody({
    super.key,
    required this.count,
    required this.title,
    required this.route,
    required this.files,
    required this.subdirs,
    required this.image,
    this.isRoot = false,
  });

  final String count;
  final String title;
  final String route;
  final List<dynamic> files;
  final List<dynamic> subdirs;
  final String? image;
  final bool isRoot;

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
            PageHeader(
              title: title,
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: FileList(
                context: context,
                files: files,
                route: route,
                image: image,
              ),
            ),
            if (subdirs.isNotEmpty) ...[
              Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  for (dynamic subdir in subdirs)
                    FullSubdirCard(
                      route: route,
                      path: subdir['path'],
                      isRoot: isRoot,
                      subdir: subdir,
                      extraQueryParameters: '&r=0&s=nameAsc',
                    ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
            AccessCount(count: count),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
