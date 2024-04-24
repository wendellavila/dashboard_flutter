import 'package:flutter/material.dart';
import 'package:hyphenatorx/widget/texthyphenated.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import 'banner_card.dart';

class Quote extends StatelessWidget {
  const Quote({
    super.key,
    required this.context,
    required this.quote,
    required this.author,
  });

  final BuildContext context;
  final String quote;
  final String author;

  @override
  Widget build(BuildContext context) {
    return BannerCard(
      title: "Quote of the Day",
      icon: Icon(
        Symbols.reviews_sharp,
        weight: 650,
        size: 18,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      image: "assets/img/photos/quote.jpg",
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Image(
              height: 50,
              image: AssetImage("assets/img/icons/quote_white_small.png"),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: TextHyphenated(
                      quote,
                      'pt',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: constraints.maxWidth > 800 ? 40 : 25,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(
            height: 30,
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      "— $author",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: constraints.maxWidth > 800 ? 25 : 18,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
