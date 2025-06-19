import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static const _kId = 'userId';
  static const _kEmail = 'email';

  static Future<void> saveUser(String id, String email) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_kId, id);
    await sp.setString(_kEmail, email);
  }

  static Future<(String?, String?)> loadUser() async {
    final sp = await SharedPreferences.getInstance();
    return (sp.getString(_kId), sp.getString(_kEmail));
  }

  static Future<void> clear() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_kId);
    await sp.remove(_kEmail);
  }
}
