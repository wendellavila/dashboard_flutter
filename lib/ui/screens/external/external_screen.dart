import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/external_body.dart';

class ExternalScreen extends StatelessWidget {
  const ExternalScreen({
    required this.menuData,
    super.key,
  });

  final Map menuData;

  @override
  Widget build(BuildContext context) {
    launchUrl(Uri.parse(menuData['path']));

    return Scaffold(
      body: ExternalBody(
        title: menuData['title'],
        path: menuData['path'],
      ),
    );
  }
}
