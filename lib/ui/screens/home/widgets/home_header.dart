import 'package:flutter/material.dart';
import 'theme_button.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.weekday,
    required this.date,
    required this.onThemeSwitch,
  });

  final String weekday;
  final String date;
  final void Function() onThemeSwitch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 820) {
            return Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dashboard",
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      "$weekday, $date",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
                const Spacer(),
                ThemeButton(
                  context: context,
                  onThemeSwitch: onThemeSwitch,
                ),
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
                      "Dashboard",
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      "$weekday, $date",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    ThemeButton(
                      context: context,
                      onThemeSwitch: onThemeSwitch,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
