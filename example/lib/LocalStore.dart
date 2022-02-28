import 'package:shared_preferences/shared_preferences.dart';

class LocalStore {
  final String nudge_url = "nudge_url";
  Future<bool> setAppSharePopUp(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("SET _appSharePopUp");
    print(value);
    return (prefs.setString(nudge_url, value));
  }

  Future<String> getAppSharePopUp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("SET _appSharePopUp");
    var value = prefs.getString(nudge_url) ?? '';
    print(value);
    return value;
  }
}
