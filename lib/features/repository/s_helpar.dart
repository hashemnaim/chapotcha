import 'package:shared_preferences/shared_preferences.dart';

class SHelper {
  SHelper._();
  static SHelper sHelper = SHelper._();

  SharedPreferences sharedPreferences;

  Future<SharedPreferences> initSharedPrefrences() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences;
    } else {
      return sharedPreferences;
    }
  }

  // addNew(String key, String value) async {
  //   sharedPreferences = await initSharedPrefrences();
  //   sharedPreferences.setString(key, value);
  // }

  // Future<String> getValue(String key) async {
  //   sharedPreferences = await initSharedPrefrences();
  //   String x = sharedPreferences.getString(key);
  //   return x;
  // }

  String getToken() {
    initSharedPrefrences();

    String x = sharedPreferences.getString('token');
    return x;
  }

  Future<void> setLanguge(String token) {
    return sharedPreferences.setString("Lang", token);
  }

  String getLanguge() {
    return sharedPreferences.getString("Lang");
  }

  setToken(String value) {
    initSharedPrefrences();

    sharedPreferences.setString('token', value);
  }

  clearSp() async {
    sharedPreferences = await initSharedPrefrences();
    sharedPreferences.clear();
  }
}
