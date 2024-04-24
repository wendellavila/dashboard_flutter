import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:provider/provider.dart';

import '../../config/navigation_data.dart';
import '../../services/theme_provider.dart';

class SideBar extends StatelessWidget {
  SideBar({
    super.key,
  });

  final NavigationData _navigationData = NavigationData.singletonInstance;

  bool _calculateSelectedIndex({required context, required String route}) {
    String currentRoute = Beamer.of(context).beamingHistory.last.state.routeInformation.uri.toString().substring(1);
    //removing pathParameters and subroutes
    currentRoute = currentRoute.split("?").first.split("/").first;
    return currentRoute == route;
  }

  SideMenuItemDataTile _sideMenuItem(
      {required context, required int index, required Map menuItemData, required bool isMenuOpen, required isSelected}) {
    return SideMenuItemDataTile(
      isSelected: isSelected,
      title: menuItemData['title'] ?? '',
      tooltip: isMenuOpen ? null : (menuItemData['title'] ?? ''),
      titleStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      selectedTitleStyle: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      icon: Icon(
        menuItemData['icon'] ?? '',
        weight: 650,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      selectedIcon: Icon(
        menuItemData['icon'] ?? '',
        weight: 650,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      highlightSelectedColor: Theme.of(context).colorScheme.primary,
      onTap: () => Beamer.of(context).beamToNamed("/${menuItemData['route']}"),
    );
  }

  List<SideMenuItemDataTile> _generateMenuItems({required context, required bool isMenuOpen}) {
    List<SideMenuItemDataTile> items = [];
    for (int i = 0; i < _navigationData.menuItems.length; i++) {
      items.add(
        _sideMenuItem(
          context: context,
          index: i,
          menuItemData: _navigationData.menuItems[i],
          isMenuOpen: isMenuOpen,
          isSelected: _calculateSelectedIndex(context: context, route: _navigationData.menuItems[i]['route']),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0),
            blurRadius: 1.0,
          ),
        ],
      ),
      child: SideMenu(
        maxWidth: 230,
        mode: SideMenuMode.auto,
        hasResizer: false,
        hasResizerToggle: true,
        resizerToggleData: ResizerToggleData(
          iconSize: 30,
          iconColor: Theme.of(context).colorScheme.onPrimary,
          backgroundColor: Theme.of(context).colorScheme.primary,
          topPosition: 5,
        ),
        builder: (data) {
          return SideMenuData(
            header: SideMenuHeader(isMenuOpen: data.isOpen),
            items: _generateMenuItems(context: context, isMenuOpen: data.isOpen),
            footer: const SizedBox(
              height: 10,
            ),
          );
        },
      ),
    );
  }
}

class SideMenuHeader extends StatelessWidget {
  const SideMenuHeader({
    super.key,
    required this.isMenuOpen,
  });

  final bool isMenuOpen;

  @override
  Widget build(BuildContext context) {
    if (isMenuOpen) {
      return ListTile(
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              InkWell(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Image(
                    width: 120,
                    image: AssetImage("assets/img/logo/${Provider.of<ThemeProvider>(context).isLight ? "logo.png" : "logo_dark.png"}"),
                  ),
                ),
                onTap: () => Beamer.of(context).beamToNamed("/inicio"),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "DASHBOARD",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.6,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 20),
            child: InkWell(
              child: Image(
                width: 30,
                image: AssetImage("assets/img/logo/${Provider.of<ThemeProvider>(context).isLight ? "logo.png" : "logo_dark.png"}"),
              ),
              onTap: () => Beamer.of(context).beamToNamed("/inicio"),
            ),
          )
        ],
      );
    }
  }
}
