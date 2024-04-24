import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'package:word_generator/word_generator.dart';

import '../../../services/json_handler.dart' as json_handler;
import '../../../services/theme_provider.dart';

import 'widgets/home_layout_vertical.dart';
import 'widgets/home_layout_horizontal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    required this.menuData,
    required this.baseUrl,
    super.key,
  });

  final String baseUrl;
  final Map menuData;

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final Map<String, dynamic> _birthdayData = {};
  Map<String, dynamic> _newsData = {};
  final DateTime _currentDateTime = DateTime.now();
  final Map<String, String> _quoteData = {
    'author': '',
    'quote': '',
  };

  @override
  void initState() {
    super.initState();
    _loadBirthdays();
    _loadNews();
    _loadQuote();
    WebViewPlatform.instance = WebWebViewPlatform();
  }

  void _loadBirthdays() async {
    int lastDay = 30;
    if (_currentDateTime.month == 02) {
      lastDay = 28;
    } else if ([1, 3, 5, 7, 8, 10, 12].contains(_currentDateTime.month)) {
      lastDay = 31;
    }
    final random = Random();
    final wordGenerator = WordGenerator();

    for (int i = 1; i < lastDay + 1; i++) {
      _birthdayData[i.toString()] = [];
      final randomInt = 1 + random.nextInt(5 - 1);
      for (int _ = 0; _ < randomInt; _++) {
        _birthdayData[i.toString()]!.add(wordGenerator.randomName());
      }
    }
    setState(() {});
  }

  void _loadNews() async {
    _newsData = {
      'url': "${widget.baseUrl}/assets/placeholder/placeholder.pdf",
      'year': _currentDateTime.year.toString(),
      'month': _monthText(),
    };
    setState(() {});
  }

  void _loadQuote() async {
    final int seedFromDate = int.parse("${_currentDateTime.year}${_currentDateTime.month}${_currentDateTime.day}");

    final Random random = Random(seedFromDate);

    final Map quotesData = await json_handler.readFromAssets("assets/json/quotes.json");
    final int randomIndex = random.nextInt(int.parse(quotesData['quoteCount']));

    _quoteData['author'] = quotesData['quotes'][randomIndex]['author'];
    _quoteData['quote'] = quotesData['quotes'][randomIndex]['quote'];
    setState(() {});
  }

  String _dateText() {
    return "${_monthText()} ${_currentDateTime.day}, ${_currentDateTime.year}";
  }

  String _monthText() {
    final List<String> monthName = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthName[_currentDateTime.month - 1];
  }

  String _weekDayText() {
    final List<String> weekDayName = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Satuday',
      'Sunday',
    ];
    return weekDayName[_currentDateTime.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: ListView(
          primary: true,
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 1000) {
                  return HomeLayoutHorizontal(
                    baseUrl: widget.baseUrl,
                    route: widget.menuData['route'],
                    headerWeekday: _weekDayText(),
                    headerDate: _dateText(),
                    birthdaysMonth: _monthText(),
                    quoteText: _quoteData['quote'] ?? '',
                    quoteAuthor: _quoteData['author'] ?? '',
                    newsDate: _newsData['date'] ?? '',
                    newsMonth: _newsData['month'] ?? '',
                    newsYear: _newsData['year'] ?? '',
                    newsUrl: _newsData['url'] ?? '',
                    currentDateTime: _currentDateTime,
                    birthdayData: _birthdayData,
                    onThemeSwitch: () => setState(() {
                      Provider.of<ThemeProvider>(context, listen: false).switchTheme();
                    }),
                  );
                } else {
                  return HomeLayoutVertical(
                    baseUrl: widget.baseUrl,
                    context: context,
                    route: widget.menuData['route'],
                    headerWeekday: _weekDayText(),
                    headerDate: _dateText(),
                    birthdaysMonth: _monthText(),
                    quoteText: _quoteData['quote'] ?? '',
                    quoteAuthor: _quoteData['author'] ?? '',
                    newsDate: _newsData['date'] ?? '',
                    newsMonth: _newsData['month'] ?? '',
                    newsYear: _newsData['year'] ?? '',
                    newsUrl: _newsData['url'] ?? '',
                    currentDateTime: _currentDateTime,
                    birthdayData: _birthdayData,
                    onThemeSwitch: () => setState(() {
                      Provider.of<ThemeProvider>(context, listen: false).switchTheme();
                    }),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
