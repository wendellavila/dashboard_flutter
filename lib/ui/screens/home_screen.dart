import 'dart:math';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:hyphenatorx/widget/texthyphenated.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'package:word_generator/word_generator.dart';

import '../../services/json_handler.dart' as json_handler;
import '../../services/theme_provider.dart';

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
  final Map<String, List<String>> _birthdayData = {};
  Map _newsData = {};
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
      'url': "${widget.baseUrl}/data/Home/newsletter.pdf",
      'year': _currentDateTime.year,
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

  bool _isThemeLight() {
    return Theme.of(context).colorScheme.brightness == Brightness.light;
  }

  String _dateText() {
    return "${_monthText()} ${_currentDateTime.day}, ${_currentDateTime.year}";
  }

  String _monthText({int monthNumber = -1}) {
    if (monthNumber < 0) {
      monthNumber = _currentDateTime.month - 1;
    } else {
      monthNumber -= 1;
    }

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
    return monthName[monthNumber];
  }

  String _weekDayText() {
    final List<String> weekDayName = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return weekDayName[_currentDateTime.weekday - 1];
  }

  Widget _cardItem({Widget? child}) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: child,
      ),
    );
  }

  Widget _quote() {
    return _cardItem(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.reviews_outlined,
                  size: 18,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Flexible(
                child: Text(
                  "Quote of the Day",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/img/photos/quote.jpg"),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 40,
              ),
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
                              _quoteData['quote']!,
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
                              "— ${_quoteData['author']!}",
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _whatsNew() {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      hoverColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
      onTap: () => Beamer.of(context).beamToNamed("/webview"),
      child: _cardItem(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.new_releases_outlined,
                    size: 18,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Flexible(
                  child: Text(
                    "What's New",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  constraints: BoxConstraints(minHeight: constraints.maxWidth * 0.28),
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 40,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xfff3f3f3),
                    image: const DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage("assets/img/photos/new.jpg"),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _news() {
    return InkWell(
      customBorder: BeveledRectangleBorder(borderRadius: BorderRadius.circular(1)),
      hoverColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
      borderRadius: BorderRadius.circular(6),
      onTap: () => Beamer.of(context).beamToNamed("/${widget.menuData['route']}/view?p=${_newsData['url']}&t=web"),
      child: _cardItem(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.newspaper_outlined,
                    size: 18,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Flexible(
                  child: Text(
                    "Newsletter",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              constraints: const BoxConstraints(minHeight: 160),
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 40,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/img/photos/newsletter.jpg"),
                ),
              ),
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
                          width: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Newsletter",
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${_newsData['month']}/${_newsData['year']}",
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Image(
                                image: AssetImage("assets/img/logo/logo_dark.png"),
                                height: 75,
                              ),
                              const Text(
                                "Newsletter",
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${_newsData['month']}/${_newsData['year']}",
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _weatherEmbed() {
    return _cardItem(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.cloud_outlined,
                  size: 18,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Flexible(
                child: Text(
                  "Weather",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 230,
            width: 500,
            child: PlatformWebViewWidget(
              PlatformWebViewWidgetCreationParams(
                controller: PlatformWebViewController(
                  const PlatformWebViewControllerCreationParams(),
                )..loadRequest(
                    LoadRequestParams(
                      uri: Uri.parse("${widget.baseUrl}/assets/html/weather${_isThemeLight() ? "" : "_dark"}.html"),
                    ),
                  ),
              ),
            ).build(context),
          ),
        ],
      ),
    );
  }

  Widget _currencyEmbed() {
    return _cardItem(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.currency_exchange_outlined,
                  size: 18,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Flexible(
                child: Text(
                  "Currency",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 230,
            child: PlatformWebViewWidget(
              PlatformWebViewWidgetCreationParams(
                controller: PlatformWebViewController(
                  const PlatformWebViewControllerCreationParams(),
                )..loadRequest(
                    LoadRequestParams(
                      uri: Uri.parse("${widget.baseUrl}/assets/html/currency${_isThemeLight() ? "" : "_dark"}.html"),
                    ),
                  ),
              ),
            ).build(context),
          ),
        ],
      ),
    );
  }

  Widget _birthdays() {
    List<Widget> items = [];
    int dayCount = 0;
    late Color tileColor;
    late Color textColor;
    late Color? selectionColor;

    _birthdayData.forEach(
      (day, nameList) {
        dayCount++;
        if (day == _currentDateTime.day.toString()) {
          tileColor = Theme.of(context).colorScheme.primary;
          textColor = Colors.white;
          selectionColor = const Color(0x62000000);
        } else {
          textColor = Theme.of(context).colorScheme.onSurface;
          if (dayCount % 2 == 0) {
            tileColor = Theme.of(context).colorScheme.surface;
          } else {
            tileColor = Theme.of(context).hoverColor;
          }
          selectionColor = null;
        }
        items.add(
          Container(
            decoration: BoxDecoration(
              color: tileColor,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
              child: Column(
                children: [
                  for (int i = 0; i < nameList.length; i++)
                    Theme(
                      data: Theme.of(context).copyWith(
                        textSelectionTheme: TextSelectionThemeData(selectionColor: selectionColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 25,
                            child: Text(
                              i == 0 ? day : '',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: textColor),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              nameList[i],
                              style: TextStyle(fontSize: 12, color: textColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
    return _cardItem(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.cake_outlined,
                    size: 18,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Flexible(
                  child: Text(
                    "Birthdays",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    _monthText(),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 1000 && constraints.maxWidth > 500) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            ...items.sublist(0, (items.length / 2).floor()),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            ...items.sublist((items.length / 2).floor(), items.length),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      ...items,
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _homeItemsHorizontal() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(4),
          child: _header(),
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
                        child: _weatherEmbed(),
                      ),
                      Flexible(
                        flex: 5,
                        child: _currencyEmbed(),
                      ),
                    ],
                  ),
                  _whatsNew(),
                  _news(),
                  _quote(),
                ],
              ),
            ),
            SelectionArea(
              child: SizedBox(
                width: 300,
                child: _birthdays(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _homeItemsVertical() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(4),
          child: _header(),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 820) {
              return Row(
                children: [
                  Flexible(
                    flex: 5,
                    child: _weatherEmbed(),
                  ),
                  Flexible(
                    flex: 5,
                    child: _currencyEmbed(),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  _weatherEmbed(),
                  _currencyEmbed(),
                ],
              );
            }
          },
        ),
        _whatsNew(),
        _news(),
        _quote(),
        _birthdays(),
      ],
    );
  }

  Widget _header() {
    final Widget themeButton = SelectionContainer.disabled(
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            Provider.of<ThemeProvider>(context, listen: false).switchTheme();
          });
        },
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(1),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 18, horizontal: 6),
          ),
          animationDuration: const Duration(seconds: 0),
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.white;
              }
              return Theme.of(context).colorScheme.onSurface;
            },
          ),
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.hovered)) {
                return Theme.of(context).colorScheme.primary;
              }
              return Theme.of(context).colorScheme.surface;
            },
          ),
        ),
        child: Row(
          children: [
            Icon(
              _isThemeLight() ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
              size: 15,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              "${_isThemeLight() ? "Dark" : "Light"} Theme",
            ),
          ],
        ),
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 820) {
          return Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "dashboard_flutter",
                    style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.onSurface),
                  ),
                  Text(
                    "${_weekDayText()}, ${_dateText()}",
                    style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
              const Spacer(),
              themeButton,
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "dashboard_flutter",
                    style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.onSurface),
                  ),
                  Text(
                    "${_weekDayText()}, ${_dateText()}",
                    style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [themeButton],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        }
      },
    );
  }

  Widget _homeBody() {
    return SelectionArea(
      child: ListView(
        primary: true,
        //shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return constraints.maxWidth > 1000 ? _homeItemsHorizontal() : _homeItemsVertical();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _homeBody(),
    );
  }
}
