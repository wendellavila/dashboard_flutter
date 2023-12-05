import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ExternalScreen extends StatefulWidget {
  const ExternalScreen({
    required this.menuData,
    super.key,
  });

  final Map menuData;

  @override
  State<ExternalScreen> createState() => _ExternalScreen();
}

class _ExternalScreen extends State<ExternalScreen> {
  @override
  void initState() {
    super.initState();
    launchUrl(Uri.parse(widget.menuData['path']));
  }

  Widget _header() {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.menuData['title'] ?? "",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ],
    );
  }

  Widget _externalBody() {
    return SelectionArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            _header(),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
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
                              text: widget.menuData['title'],
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
                          launchUrl(Uri.parse(widget.menuData['path']));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 2,
                          ),
                          child: Text(
                            widget.menuData['title'],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _externalBody(),
    );
  }
}
