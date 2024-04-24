import 'package:flutter/material.dart';

import 'home_card.dart';

class BannerCard extends StatelessWidget {
  const BannerCard({
    super.key,
    required this.title,
    required this.icon,
    this.image,
    this.onTap,
    this.showBadge = false,
    this.minHeight = 0.0,
    this.fit = BoxFit.cover,
    this.backgroundColor = const Color(0xFF948076),
    this.child,
  });

  final String title;
  final Icon icon;
  final String? image;
  final VoidCallback? onTap;
  final bool showBadge;
  final double minHeight;
  final BoxFit fit;
  final Color backgroundColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return HomeCard(
      title: title,
      icon: icon,
      onTap: onTap,
      showBadge: showBadge,
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: minHeight),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: backgroundColor,
          image: image != null
              ? DecorationImage(
                  fit: fit,
                  image: image!.substring(0, 4) == 'http' ? NetworkImage(image!) : AssetImage(image!) as ImageProvider,
                )
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 40,
          ),
          child: child,
        ),
      ),
    );
  }
}
