import 'package:flutter/material.dart';
import '../../../../ui/screens/home/widgets/home_card.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class Birthdays extends StatelessWidget {
  const Birthdays({
    super.key,
    required this.context,
    required this.birthdayData,
    required this.currentDateTime,
    required this.month,
  });

  final BuildContext context;
  final Map<String, dynamic> birthdayData;
  final DateTime currentDateTime;
  final String month;

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    int dayCount = 0;
    late Color tileColor;
    late Color textColor;
    late Color? selectionColor;

    birthdayData.forEach(
      (day, nameList) {
        dayCount++;
        if (day == currentDateTime.day.toString()) {
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
                  for (int i = 0; i < (nameList as List).length; i++)
                    Theme(
                      data: Theme.of(context).copyWith(
                        textSelectionTheme: TextSelectionThemeData(
                          selectionColor: selectionColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 25,
                            child: Text(
                              i == 0 ? day : '',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: textColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              nameList[i],
                              style: TextStyle(
                                fontSize: 12,
                                color: textColor,
                              ),
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

    return HomeCard(
      title: "Aniversariantes",
      icon: Icon(
        Symbols.cake_sharp,
        weight: 650,
        size: 18,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    month,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
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
                            if (items.isNotEmpty)
                              ...items.sublist(
                                0,
                                (items.length / 2).ceil(),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            if (items.isNotEmpty)
                              ...items.sublist(
                                (items.length / 2).ceil(),
                                items.length,
                              ),
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
}
