import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class CloseImageButton extends StatelessWidget {
  const CloseImageButton({super.key, required this.context, required this.onPressed});

  final BuildContext context;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            iconSize: 40,
            onPressed: onPressed,
            icon: const Icon(
              Symbols.close_sharp,
              size: 40,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
