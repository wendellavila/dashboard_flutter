import 'package:flutter/material.dart';

const PageTransitionsTheme pageTransitionsTheme = PageTransitionsTheme(
  builders: <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: NoTransitionsBuilder(),
    TargetPlatform.iOS: NoTransitionsBuilder(),
    TargetPlatform.linux: NoTransitionsBuilder(),
    TargetPlatform.macOS: NoTransitionsBuilder(),
    TargetPlatform.windows: NoTransitionsBuilder(),
  },
);

//Remove animation from page transitions
class NoTransitionsBuilder extends PageTransitionsBuilder {
  const NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T>? route,
    BuildContext? context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget? child,
  ) {
    return child!;
  }
}
