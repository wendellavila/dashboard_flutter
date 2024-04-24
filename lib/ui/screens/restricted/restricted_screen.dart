import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dir_viewer/dir_viewer_screen.dart';
import '../../../services/permission_preferences.dart';
import '../../../services/theme_provider.dart';
import '../../widgets/card_item.dart';
import '../../widgets/page_header.dart';
import 'widgets/login_form.dart';

class RestrictedScreen extends StatefulWidget {
  const RestrictedScreen({
    required this.menuData,
    required this.baseUrl,
    super.key,
  });

  final String baseUrl;
  final Map menuData;

  @override
  State<RestrictedScreen> createState() => _RestrictedScreen();
}

class _RestrictedScreen extends State<RestrictedScreen> {
  PermissionPreferences? permissionPreferences;

  @override
  void initState() {
    super.initState();
    _readPermissionPreferences();
  }

  Future<void> _readPermissionPreferences() async {
    permissionPreferences = await PermissionPreferences.create();
    setState(() {});
  }

  void refreshPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (permissionPreferences == null) {
          return const SizedBox.shrink();
        } else if (permissionPreferences!.getLoginPermission()) {
          return DirViewerScreen(
            baseUrl: widget.baseUrl,
            menuData: widget.menuData,
          );
        }
        return Scaffold(
          body: SelectionArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageHeader(
                    title: widget.menuData['title'],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: CardItem(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 25, bottom: 30),
                            width: 120,
                            child: Image(
                              image: AssetImage(
                                'assets/img/logo/${Provider.of<ThemeProvider>(context).isLight ? "logo.png" : "logo_dark.png"}',
                              ),
                              width: 500,
                            ),
                          ),
                          Text(
                            "Restricted Area",
                            style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.onSurface),
                            textAlign: TextAlign.center,
                          ),
                          LoginForm(
                            permissionPreferences: permissionPreferences!,
                            baseUrl: widget.baseUrl,
                            menuData: widget.menuData,
                            onLoginSuccessful: refreshPage,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
