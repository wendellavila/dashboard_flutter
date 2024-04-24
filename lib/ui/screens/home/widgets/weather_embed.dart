import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../../../services/theme_provider.dart';
import 'embed.dart';

class WeatherEmbed extends StatelessWidget {
  const WeatherEmbed({
    super.key,
    required this.baseUrl,
  });

  final String baseUrl;

  @override
  Widget build(BuildContext context) {
    return Embed(
      title: "Weather",
      url: "$baseUrl/assets/html/weather${Provider.of<ThemeProvider>(context).isLight ? "" : "_dark"}.html",
      icon: Icon(
        Symbols.partly_cloudy_day_sharp,
        size: 18,
        weight: 700,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
