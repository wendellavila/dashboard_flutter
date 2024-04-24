import 'package:flutter/material.dart';

import '../../../widgets/card_item.dart';
import 'subdir_list.dart';
import '../../../widgets/image_list.dart';

class ArticleBody extends StatelessWidget {
  const ArticleBody(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.date,
      required this.route,
      required this.text,
      required this.images,
      required this.subdirs,
      required this.showDate});

  final String title;
  final String subtitle;
  final String? date;
  final String route;
  final String text;
  final List images;
  final List subdirs;
  final bool showDate;

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width < 950 ? MediaQuery.of(context).size.width * 0.8 : MediaQuery.of(context).size.width * 0.6,
                  child: CardItem(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 40,
                    ),
                    child: Column(
                      children: [
                        if (images.isNotEmpty)
                          Container(
                            constraints: const BoxConstraints(maxHeight: 400),
                            child: Image(
                              image: NetworkImage(images[0]['url']),
                            ),
                          ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                subtitle,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            if (date != null)
                              Text(
                                date ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          text,
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SubdirList(
                          subdirs: subdirs,
                          showDate: showDate,
                          route: route,
                        ),
                        ImageList(
                          images: images,
                          showBanner: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
