import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../../../services/theme_provider.dart';
import 'embed.dart';

class CurrencyEmbed extends StatelessWidget {
  const CurrencyEmbed({
    super.key,
    required this.baseUrl,
  });

  final String baseUrl;
  @override
  Widget build(BuildContext context) {
    return Embed(
      title: "Currency",
      url: "$baseUrl/assets/assets/html/currency${Provider.of<ThemeProvider>(context).isLight ? "" : "_dark"}.html",
      icon: Icon(
        Symbols.currency_exchange_sharp,
        weight: 700,
        size: 18,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
