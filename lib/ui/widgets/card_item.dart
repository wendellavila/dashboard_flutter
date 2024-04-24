import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.child,
    this.padding,
  });

  final EdgeInsets? padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(4),
        child: child,
      ),
    );
  }
}
