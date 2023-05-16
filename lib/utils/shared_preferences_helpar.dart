import 'package:shared_preferences/shared_preferences.dart';

import '../modules/My_Order/model/details_order_model.dart';

class SHelper {
  SHelper._();
  static SHelper sHelper = SHelper._();

  SharedPreferences? sharedPreferences;

  Future<SharedPreferences?> initSharedPrefrences() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences;
    } else {
      return sharedPreferences;
    }
  }

  Future<void> saveAddress(Address address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("lat", address.lat.toString());
    await prefs.setString("lng", address.lng.toString());
    await prefs.setString("city", address.city.toString());
    await prefs.setString("area", address.area.toString());
    await prefs.setString("city_id", address.city_id.toString());
    await prefs.setString("street", address.street.toString());
    await prefs.setString("building", address.building.toString());
    await prefs.setString("apartment", address.apartment.toString());
  }

  Address getAddress() {
    initSharedPrefrences();
    String latitude = sharedPreferences!.getString("lat") ?? "";
    String longitude = sharedPreferences!.getString("lng") ?? "";
    String city = sharedPreferences!.getString("city") ?? "";
    String area = sharedPreferences!.getString("area") ?? "";
    String city_id = sharedPreferences!.getString("city_id") ?? '';
    String street = sharedPreferences!.getString("street") ?? '';
    String building = sharedPreferences!.getString("building") ?? '';
    String apartment = sharedPreferences!.getString("apartment") ?? '';
    return Address(
      lat: latitude,
      lng: longitude,
      city: city,
      area: area,
      city_id: city_id,
      street: street,
      building: building,
      apartment: apartment,
    );
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
  String? getIdAddress() {
    initSharedPrefrences();
    String? x = sharedPreferences!.getString('id_address');
    return x;
  }

  setIdAddress(String value) {
    initSharedPrefrences();
    sharedPreferences!.setString('id_address', value);
  }

  String? getToken() {
    initSharedPrefrences();
    String? x = sharedPreferences!.getString('token');
    return x;
  }

  setToken(String value) {
    initSharedPrefrences();
    sharedPreferences!.setString('token', value);
  }

  removeToken() {
    initSharedPrefrences();
    sharedPreferences!.remove('token');
  }

  String? getFcmToken() {
    initSharedPrefrences();
    String? x = sharedPreferences!.getString('fcmToken');
    return x;
  }

  setFcmToken(String value) {
    initSharedPrefrences();
    sharedPreferences!.setString('fcmToken', value);
  }

  Future<void> setLanguge(String token) {
    return sharedPreferences!.setString("Lang", token);
  }

  String? getLanguge() {
    return sharedPreferences!.getString("Lang");
  }

  clearSp() async {
    sharedPreferences = await initSharedPrefrences();
    sharedPreferences!.clear();
  }
}
