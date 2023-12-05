import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';

import '../../services/navigation_data.dart';

class SideBar extends StatefulWidget {
  const SideBar({
    super.key,
  });

  @override
  State<SideBar> createState() => _SideBar();
}

class _SideBar extends State<SideBar> {
  final NavigationData _navigationData = NavigationData.singletonInstance;

  @override
  void initState() {
    super.initState();
  }

  bool _isThemeLight() {
    return Theme.of(context).colorScheme.brightness == Brightness.light;
  }

  Widget _sideMenuHeader({required bool isMenuOpen}) {
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
                    image: AssetImage("assets/img/logo/${_isThemeLight() ? "logo.png" : "logo_dark.png"}"),
                  ),
                ),
                onTap: () => Beamer.of(context).beamToNamed("/inicio"),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "SIDEROUTING",
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
                image: AssetImage("assets/img/logo/${_isThemeLight() ? "logo.png" : "logo_dark.png"}"),
              ),
              onTap: () => Beamer.of(context).beamToNamed("/inicio"),
            ),
          )
        ],
      );
    }
  }

  bool _calculateSelectedIndex({required String route}) {
    String currentRoute = Beamer.of(context).beamingHistory.last.state.routeInformation.uri.toString().substring(1);
    //removing pathParameters and subroutes
    currentRoute = currentRoute.split("?").first.split("/").first;
    return currentRoute == route;
  }

  SideMenuItemDataTile _sideMenuItem({required int index, required Map menuItemData, required bool isMenuOpen, required isSelected}) {
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
        color: Theme.of(context).colorScheme.onSurface,
      ),
      selectedIcon: Icon(
        menuItemData['icon'] ?? '',
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      highlightSelectedColor: Theme.of(context).colorScheme.primary,
      onTap: () => Beamer.of(context).beamToNamed("/${menuItemData['route']}"),
    );
  }

  List<SideMenuItemDataTile> _generateMenuItems({required bool isMenuOpen}) {
    List<SideMenuItemDataTile> items = [];
    List<Map> menuItemData = _navigationData.menuItems;
    for (int i = 0; i < menuItemData.length; i++) {
      items.add(
        _sideMenuItem(
          index: i,
          menuItemData: menuItemData[i],
          isMenuOpen: isMenuOpen,
          isSelected: _calculateSelectedIndex(route: menuItemData[i]['route']),
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
            header: _sideMenuHeader(isMenuOpen: data.isOpen),
            items: _generateMenuItems(isMenuOpen: data.isOpen),
            footer: const SizedBox(
              height: 10,
            ),
          );
        },
      ),
    );
  }
}
