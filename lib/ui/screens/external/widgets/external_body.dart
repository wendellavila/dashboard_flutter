import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/page_header.dart';

class ExternalBody extends StatelessWidget {
  const ExternalBody({super.key, required this.title, required this.path});

  //final ExternalScreen parentWidget;
  final String title;
  final String path;

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageHeader(title: title),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: SizedBox(
                width: 500,
                child: Card(
                  color: Theme.of(context).colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "External URL",
                          style: TextStyle(
                            fontSize: 28,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: title,
                                style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.primary),
                              ),
                              TextSpan(
                                text: " was opened in a new tab.",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "To open again, click the button below.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            launchUrl(Uri.parse(path));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 2,
                            ),
                            child: Text(
                              title,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
