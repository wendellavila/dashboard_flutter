import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../../../services/theme_provider.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({
    super.key,
    required this.context,
    required this.onThemeSwitch,
  });

  final BuildContext context;
  final void Function() onThemeSwitch;

  @override
  Widget build(BuildContext context) {
    return SelectionContainer.disabled(
      child: ElevatedButton(
        onPressed: onThemeSwitch,
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
              Provider.of<ThemeProvider>(context).isLight ? Symbols.dark_mode_sharp : Symbols.light_mode_sharp,
              weight: 650,
              size: 15,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              "${Provider.of<ThemeProvider>(context).isLight ? "Dark" : "Light"} Theme",
            ),
          ],
        ),
      ),
    );
  }
}
