import 'package:flutter/material.dart';

import '../../../widgets/page_header.dart';
import '../../../widgets/page_banner.dart';
import '../../../widgets/image_list.dart';
import 'menu_list.dart';
import '../../../widgets/access_count.dart';

class DirViewerBody extends StatelessWidget {
  const DirViewerBody({
    super.key,
    required this.title,
    required this.subtitle,
    required this.route,
    required this.date,
    required this.text,
    required this.count,
    required this.files,
    required this.subdirs,
    required this.links,
    required this.images,
    required this.showBanner,
    required this.showDate,
  });

  final String title;
  final String subtitle;
  final String route;
  final String? date;
  final String? text;
  final String count;
  final List<dynamic> files;
  final List<dynamic> subdirs;
  final List<dynamic> links;
  final List<dynamic> images;
  final bool showBanner;
  final bool showDate;

  @override
  Widget build(BuildContext context) {
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
              PageHeader(
                title: title,
                subtitle: subtitle,
                date: date,
              ),
              const SizedBox(
                height: 20,
              ),
              if (showBanner) PageBanner(images: images),
              if (text != null)
                Center(
                  child: SizedBox(
                    width:
                        MediaQuery.of(context).size.width < 950 ? MediaQuery.of(context).size.width * 0.8 : MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      text.toString(),
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              Center(
                child: MenuList(
                  files: files,
                  subdirs: subdirs,
                  links: links,
                  route: route,
                  showBanner: showBanner,
                  showDate: showDate,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ImageList(
                  images: images,
                  showBanner: showBanner,
                ),
              ),
              AccessCount(count: count),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
