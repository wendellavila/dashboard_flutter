import 'dart:math';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class NewItemBadge extends StatelessWidget {
  const NewItemBadge({
    super.key,
    required this.isVisible,
    required this.child,
  });

  final bool isVisible;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Badge(
      label: Row(
        children: [
          Icon(
            Symbols.auto_awesome_sharp,
            weight: 650,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 10,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            "NEW",
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ],
      ),
      isLabelVisible: isVisible,
      backgroundColor: Theme.of(context).colorScheme.primary,
      offset: Offset.fromDirection(pi, 40),
      child: child,
    );
  }
}
