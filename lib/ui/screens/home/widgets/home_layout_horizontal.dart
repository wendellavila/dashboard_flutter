import 'package:flutter/material.dart';

import 'quote.dart';
import 'birthdays.dart';
import 'home_header.dart';
import 'newsletter.dart';
import 'currency_embed.dart';
import 'weather_embed.dart';
import 'highlight.dart';

class HomeLayoutHorizontal extends StatelessWidget {
  const HomeLayoutHorizontal({
    super.key,
    required this.baseUrl,
    required this.route,
    required this.headerWeekday,
    required this.headerDate,
    required this.birthdaysMonth,
    required this.quoteText,
    required this.quoteAuthor,
    required this.newsDate,
    required this.newsMonth,
    required this.newsYear,
    required this.newsUrl,
    required this.currentDateTime,
    required this.birthdayData,
    required this.onThemeSwitch,
  });

  final String baseUrl;
  final String route;
  final String headerWeekday;
  final String headerDate;
  final String birthdaysMonth;
  final String quoteText;
  final String quoteAuthor;
  final String newsDate;
  final String newsMonth;
  final String newsYear;
  final String newsUrl;
  final DateTime currentDateTime;
  final Map<String, dynamic> birthdayData;
  final void Function() onThemeSwitch;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeader(
          weekday: headerWeekday,
          date: headerDate,
          onThemeSwitch: onThemeSwitch,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 5,
                        child: WeatherEmbed(
                          baseUrl: baseUrl,
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: CurrencyEmbed(
                          baseUrl: baseUrl,
                        ),
                      ),
                    ],
                  ),
                  Hightlight(baseUrl: baseUrl),
                  Quote(
                    context: context,
                    quote: quoteText,
                    author: quoteAuthor,
                  ),
                  Newsletter(
                    route: route,
                    date: newsDate,
                    month: newsMonth,
                    year: newsYear,
                    url: newsUrl,
                    currentDateTime: currentDateTime,
                  ),
                ],
              ),
            ),
            SelectionArea(
              child: SizedBox(
                width: 300,
                child: Birthdays(
                  context: context,
                  birthdayData: birthdayData,
                  currentDateTime: currentDateTime,
                  month: birthdaysMonth,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
