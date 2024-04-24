import 'package:flutter/material.dart';
import 'animations.dart';

ThemeData themeData({required ThemeMode themeMode}) {
  return ThemeData(
    useMaterial3: false,
    fontFamily: "Archivo",
    pageTransitionsTheme: pageTransitionsTheme,
    colorScheme: themeMode == ThemeMode.dark
        ? const ColorScheme(
            brightness: Brightness.dark,
            primary: Color.fromARGB(255, 114, 131, 45),
            onPrimary: Color(0XFFFFFFFF),
            background: Color(0XFF546122),
            onBackground: Color(0XFFFFFFFF),
            secondary: Color(0XFF563c2f),
            onSecondary: Color(0XFF1d1b19),
            tertiary: Color(0XFFE77573),
            onTertiary: Color(0XFFFFFFFF),
            surface: Color(0XFF373737),
            onSurface: Color.fromARGB(255, 230, 230, 230),
            error: Color(0XFFff9090),
            onError: Color(0XFFC6504E),
          )
        : const ColorScheme(
            brightness: Brightness.light,
            primary: Color(0XFF546122),
            onPrimary: Color(0XFFFFFFFF),
            background: Color(0XFF546122),
            onBackground: Color(0XFFFFFFFF),
            secondary: Color(0XFF563c2f),
            onSecondary: Color(0XFF1d1b19),
            tertiary: Color(0XFFE77573),
            onTertiary: Color(0XFFFFFFFF),
            surface: Color(0XFFFFFFFF),
            onSurface: Color(0XFF1d1b19),
            error: Color(0XFFff9090),
            onError: Color(0XFFC6504E),
          ),
    scaffoldBackgroundColor: themeMode == ThemeMode.dark ? const Color(0XFF454545) : const Color.fromARGB(255, 245, 245, 242),
    hoverColor: themeMode == ThemeMode.dark ? const Color.fromARGB(60, 100, 100, 100) : null,
  );
}
