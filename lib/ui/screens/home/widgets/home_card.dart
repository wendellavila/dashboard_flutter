import 'package:flutter/material.dart';
import '../../../widgets/card_item.dart';
import 'new_item_badge.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.title,
    required this.icon,
    this.showBadge = false,
    this.onTap,
    this.child,
  });

  final String title;
  final Icon icon;
  final bool showBadge;
  final VoidCallback? onTap;
  final Widget? child;

  Widget _optionalInkwell({required BuildContext context, void Function()? onTap, required Widget child}) {
    return onTap == null
        ? child
        : InkWell(
            hoverColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
            onTap: onTap,
            child: child,
          );
  }

  @override
  Widget build(BuildContext context) {
    return NewItemBadge(
      isVisible: showBadge,
      child: _optionalInkwell(
        context: context,
        onTap: onTap,
        child: CardItem(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: icon,
                  ),
                  Flexible(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              if (child != null) child!
            ],
          ),
        ),
      ),
    );
  }
}
