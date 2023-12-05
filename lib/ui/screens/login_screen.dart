import 'package:flutter/material.dart';

import 'dir_viewer_screen.dart';
import '../../services/permission_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    required this.menuData,
    required this.baseUrl,
    super.key,
  });

  final String baseUrl;
  final Map menuData;

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  PermissionPreferences? permissionPreferences;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usercodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;
  bool _showErrorMessage = false;

  @override
  void initState() {
    super.initState();
    _readPermissionPreferences();
  }

  Future<void> _readPermissionPreferences() async {
    permissionPreferences = await PermissionPreferences.create();
    setState(() {});
  }

  Future<bool> _login({required String user, required String password}) async {
    return true;
  }

  bool _isThemeLight() {
    return Theme.of(context).colorScheme.brightness == Brightness.light;
  }

  void _loginNavigation() {
    _login(user: _usercodeController.text, password: _passwordController.text).then(
      (value) {
        if (value) {
          setState(() {
            permissionPreferences!.updateLoginPermission(true);
          });
        } else {
          setState(() {
            _showErrorMessage = true;
          });
        }
      },
    );
  }

  Card _cardItem({Widget? child}) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: child,
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.menuData['title'],
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ],
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 35),
            child: Text(
              "User",
              style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          SizedBox(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.next,
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                controller: _usercodeController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0.0,
                    horizontal: 40.0,
                  ),
                  border: OutlineInputBorder(),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              "Password",
              style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          SizedBox(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Stack(
                children: [
                  TextFormField(
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                    autocorrect: false,
                    enableSuggestions: false,
                    obscureText: _showPassword ? false : true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0,
                        horizontal: 30.0,
                      ),
                      suffixIconColor: Theme.of(context).colorScheme.primary,
                      suffixIcon: IconButton(
                        icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(
                          () {
                            _showPassword = _showPassword ? false : true;
                          },
                        ),
                      ),
                    ),
                    onChanged: (_) => setState(() {}),
                    onFieldSubmitted: (_) {
                      // On OK click in a mobile keyboard
                      if (_usercodeController.text.isEmpty || _passwordController.text.isEmpty) {
                        _loginNavigation();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 120,
            height: 40,
            child: SelectionContainer.disabled(
                child: ElevatedButton(
              onPressed: (_usercodeController.text.isEmpty || _passwordController.text.isEmpty)
                  ? null
                  : () {
                      _loginNavigation();
                    },
              child: Text(
                "ENTER",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            )),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _unloggedBody() {
    return SelectionArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _header(),
            const SizedBox(
              height: 20,
            ),
            _cardItem(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 120,
                      child: Image(
                        image: AssetImage(
                          'assets/img/logo/${_isThemeLight() ? "logo.png" : "logo_dark.png"}',
                        ),
                        width: 500,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Restricted Area",
                    style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.onSurface),
                    textAlign: TextAlign.center,
                  ),
                  _loginForm(),
                  if (_showErrorMessage)
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Invalid Credentials",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bodySwitcher() {
    if (permissionPreferences == null) {
      return const SizedBox.shrink();
    } else if (permissionPreferences!.getLoginPermission()) {
      return DirViewerScreen(
        baseUrl: widget.baseUrl,
        menuData: widget.menuData,
      );
    }
    return Scaffold(
      body: _unloggedBody(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _bodySwitcher();
  }
}
