import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import 'banner_card.dart';

class Newsletter extends StatelessWidget {
  const Newsletter(
      {super.key,
      required this.route,
      required this.date,
      required this.month,
      required this.year,
      required this.url,
      required this.currentDateTime});
  final String route;
  final String? date;
  final String? month;
  final String? year;
  final String url;
  final DateTime currentDateTime;

  @override
  Widget build(BuildContext context) {
    bool isBadgeVisible = false;

    if (date != null && DateTime.tryParse(date!) != null) {
      final DateTime fileDate = DateTime.parse(date!);
      final differenceInDays = currentDateTime.difference(fileDate).inDays;
      isBadgeVisible = differenceInDays <= 5;
    }
    return BannerCard(
      title: "Newsletter",
      icon: Icon(
        Symbols.newspaper_sharp,
        weight: 650,
        size: 18,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      showBadge: isBadgeVisible,
      image: "assets/img/photos/newsletter.jpg",
      onTap: () => Beamer.of(context).beamToNamed("/$route/view?p=$url&t=web"),
      child: LayoutBuilder(
        builder: ((context, constraints) {
          if (constraints.maxWidth > 520) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  filterQuality: FilterQuality.medium,
                  image: AssetImage("assets/img/logo/logo_dark.png"),
                  height: 80,
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Newsletter",
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    month != null && year != null
                        ? Text(
                            "$month/$year",
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ],
            );
          } else {
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  const Image(
                    image: AssetImage("assets/img/logo/logo_dark.png"),
                    height: 75,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    "Newsletter",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  month != null && year != null
                      ? Text(
                          "$month/$year",
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
