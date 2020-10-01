import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String KEY_USERNAME = "key_username";
  static SharedPreferences _sharedPreferences;

  init() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
  }

  String get getUsername => _sharedPreferences.getString(KEY_USERNAME) ?? "";

  set setUsername(String value) {
    _sharedPreferences.setString(KEY_USERNAME, value);
  }
}

final sharedPrefs = SharedPrefs();
