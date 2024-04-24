import 'package:flutter/material.dart';

class AccessCount extends StatelessWidget {
  const AccessCount({
    super.key,
    required this.count,
  });

  final String count;

  @override
  Widget build(BuildContext context) {
    if (count != '') {
      return Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Text(
            "ACESSOS",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            count,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 22,
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
