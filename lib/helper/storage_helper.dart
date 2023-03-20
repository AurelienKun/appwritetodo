import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static late SharedPreferences _prefs;
  Future<void> init() async {
    await SharedPreferences.getInstance().then((value) => _prefs = value);
  }

  void setSession(String id) {
    _prefs.setString('session', id);
  }

  String getSession() {
    return _prefs.getString('session') ?? '';
  }
}
