import 'package:shared_preferences/shared_preferences.dart';

class PermissionPreferences {
  static late bool _loginPermission;
  static late SharedPreferences prefs;

  PermissionPreferences._();

  static Future<PermissionPreferences> create() async {
    await loadPreferences();
    return PermissionPreferences._();
  }

  static Future<void> loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    final bool? login = prefs.getBool('login');
    _loginPermission = login == true ? true : false;
  }

  bool getLoginPermission() {
    return _loginPermission;
  }

  void updateLoginPermission(bool value) async {
    _loginPermission = value;
    await prefs.setBool('login', value);
  }
}
