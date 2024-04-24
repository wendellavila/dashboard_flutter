import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import '../../../../services/permission_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.permissionPreferences, required this.menuData, required this.baseUrl, required this.onLoginSuccessful});

  final PermissionPreferences permissionPreferences;
  final String baseUrl;
  final Map menuData;
  final VoidCallback onLoginSuccessful;

  @override
  State<LoginForm> createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usercodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;
  bool _showErrorMessage = false;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _login({required String user, required String password}) async {
    return true;
  }

  void _loginNavigation() {
    _login(user: _usercodeController.text, password: _passwordController.text).then(
      (value) {
        if (value) {
          setState(() {
            widget.permissionPreferences.updateLoginPermission(true);
          });
          widget.onLoginSuccessful();
        } else {
          setState(() {
            _showErrorMessage = true;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 15),
            child: Text(
              "Username",
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
                        icon: Icon(_showPassword ? Symbols.visibility_off_sharp : Symbols.visibility_sharp),
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
                "ENTRAR",
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
          if (_showErrorMessage)
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Login Inválido.",
                style: TextStyle(color: Colors.red),
              ),
            )
        ],
      ),
    );
  }
}
