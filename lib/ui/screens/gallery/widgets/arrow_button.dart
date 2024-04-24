import 'package:flutter/material.dart';

class ArrowButton extends StatelessWidget {
  const ArrowButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 40,
          onPressed: onPressed,
          icon: icon,
          disabledColor: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
