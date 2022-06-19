import 'dart:convert';
import 'dart:io';
import 'package:capotcha/features/repository/s_helpar.dart';
import 'package:capotcha/models/cart_modal.dart';
import 'package:capotcha/value/string.dart';
import 'package:http/http.dart' as http;

class NewClient {
  NewClient._();
  static final NewClient newClient = NewClient._();

  http.Client client;

  http.Client initClient() {
    if (client == null) {
      client = http.Client();
      return client;
    } else {
      return client;
    }
  }

  Future<Map<String, dynamic>> getHome() async {
    try {
      client = initClient();
      http.Response response = await client.post(
        Uri.parse(beseUrl + "user/home"),
        headers: {
          HttpHeaders.acceptHeader: "application/json",
        },
      );
      Map map = json.decode(response.body) as Map;

      return map;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> replacePoint() async {
    try {
      String token = SHelper.sHelper.getToken();

      client = initClient();

      http.Response response = await client.get(
        Uri.parse(beseUrl + "user/replace_points"),
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
      Map map = json.decode(response.body) as Map;
      // setPoints();
      return map;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> getCarton(int cartonId) async {
    // try {
    print(cartonId);
    client = initClient();
    http.Response response = await client.post(
      Uri.parse(beseUrl + "product/get_cartons"),
      body: {"carton_id": cartonId.toString()},
    );

    Map map = json.decode(response.body) as Map;
    print(map.toString());

    return map;
    // } catch (e) {
    //   return null;
    // }
  }

  Future<Map<String, dynamic>> getProfile() async {
    try {
      client = initClient();
      String token = SHelper.sHelper.getToken();
      http.Response response = await client.post(
        Uri.parse(beseUrl + "user/my_profile"),
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      Map map = json.decode(response.body) as Map;

      return map;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> getCompleteCart(
      String areaId, String time, String later) async {
    try {
      client = initClient();
      String token = SHelper.sHelper.getToken();
      http.Response response = await client
          .post(Uri.parse(beseUrl + "user/complete_cart"), headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      }, body: {
        "area": areaId,
        "time": time,
        "later": "0"
      });

      Map map = json.decode(response.body) as Map;

      return map;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> getsearch({String search}) async {
    client = initClient();
    try {
      http.Response response =
          await client.post(Uri.parse(beseUrl + "product/products"), headers: {
        HttpHeaders.acceptHeader: "application/json",
      }, body: {
        "keyword": search ?? ''
      });

      Map map = json.decode(response.body) as Map;
      return map;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> getNotfcation(String token) async {
    client = initClient();
    try {
      http.Response response =
          await client.post(Uri.parse(beseUrl + "set_token"), headers: {
        HttpHeaders.acceptHeader: "application/json",
      }, body: {
        "fcm_token": token
      });

      Map map = json.decode(response.body) as Map;
      return map;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> loginUser(
      String mobile, String password, String token) async {
    client = initClient();
    try {
      http.Response response = await client.post(
          Uri.parse(beseUrl + "user/login"),
          body: {"mobile": mobile, "password": password, "fcm_token": token});

      Map map = json.decode(response.body) as Map;

      return map;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> verifyMobile(
      String mobile, String code, String password) async {
    try {
      client = initClient();

      http.Response response = await client
          .post(Uri.parse(beseUrl + "user/verify_mobile"), headers: {
        HttpHeaders.acceptHeader: "application/json",
      }, body: {
        "mobile": mobile,
        "code": code,
        "password": password,
      });

      Map map = json.decode(response.body) as Map;
      return map;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> resetPassword(String email) async {
    try {
      client = initClient();

      http.Response response = await client
          .post(Uri.parse(beseUrl + "user/reset_password"), headers: {
        HttpHeaders.acceptHeader: "application/json",
      }, body: {
        "email": email
      });

      Map map = json.decode(response.body) as Map;

      return map;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> setOrder(String orderid) async {
    try {
      client = initClient();
      String token = SHelper.sHelper.getToken();

      http.Response response =
          await client.post(Uri.parse(beseUrl + "order/orders"), headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      }, body: {
        "order_id": orderid
      });
      Map map = json.decode(response.body) as Map;
      return map;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> setChangePassword(
      String password, String newpassword) async {
    try {
      client = initClient();
      String token = SHelper.sHelper.getToken();

      http.Response response = await client
          .post(Uri.parse(beseUrl + "user/change_password"), headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      }, body: {
        "password": password,
        "new_password": newpassword,
      });

      Map map = json.decode(response.body) as Map;
      return map;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> registerUser(
      String name, String password, String mobile) async {
    try {
      client = initClient();

      http.Response response =
          await client.post(Uri.parse(beseUrl + "user/register"), headers: {
        HttpHeaders.acceptHeader: "application/json",
      }, body: {
        "password": password,
        "mobile": mobile,
        "name": name,
      });

      Map map = json.decode(response.body) as Map;

      return map;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> setSendMessage(
      String name, String mobile, String title, String body) async {
    try {
      client = initClient();

      http.Response response =
          await client.post(Uri.parse(beseUrl + "user/send_message"), headers: {
        HttpHeaders.acceptHeader: "application/json",
      }, body: {
        "name": name,
        "mobile": mobile,
        "title": title,
        "body": body
      });

      Map map = json.decode(response.body) as Map;

      return map;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> setPromoCode(String code) async {
    try {
      String token = SHelper.sHelper.getToken();

      client = initClient();

      http.Response response =
          await client.post(Uri.parse(beseUrl + "user/add_promo"), headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      }, body: {
        "code": code,
      });

      Map map = json.decode(response.body) as Map;

      return map;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> getDiscount() async {
    try {
      String token = SHelper.sHelper.getToken();

      client = initClient();

      http.Response response = await client.post(
        Uri.parse(beseUrl + "user/get_discount"),
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      Map map = json.decode(response.body) as Map;
      return map;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> setPoints() async {
    try {
      String token = SHelper.sHelper.getToken();

      client = initClient();

      http.Response response = await client.get(
        Uri.parse(beseUrl + "user/points"),
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      Map map = json.decode(response.body) as Map;

      return map;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> updateUser(
    String name,
    String email,
    String address,
    String mobile,
  ) async {
    try {
      String token = SHelper.sHelper.getToken();

      client = initClient();

      http.Response response =
          await client.post(Uri.parse(beseUrl + "user/update_user"), headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      }, body: {
        "name": name,
        "email": email,
        "address": address,
        "mobile": mobile,
      });

      Map map = json.decode(response.body) as Map;
      return map;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> getOffers() async {
    try {
      client = initClient();

      http.Response response = await client.post(
        Uri.parse(beseUrl + "product/products"),
        headers: {
          HttpHeaders.acceptHeader: "application/json",
        },
        body: {
          "offer": "1",
        },
      );

      Map map = json.decode(response.body) as Map;
      return map;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> setCart(String cart, String carton) async {
    // try {
    client = initClient();
    String token = SHelper.sHelper.getToken();

    http.Response response = await client.post(
      Uri.parse(beseUrl + "user/cart"),
      headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
      body: {
        "product_list": cart,
        "carton_list": carton,
      },
    );
    Map map = json.decode(response.body) as Map;
    print(map);
    // CartModel cartModel = CartModel.fromJson(map);
    return map;
    // } catch (e) {
    //   return null;
    // }
  }

  Future<Map<String, dynamic>> setSendOrder(
    String carton,
    String cart,
    String day,
    String time,
    String address,
    String notes,
    String long,
    String lat,
    var mobile,
    String balance,
  ) async {
    try {
      client = initClient();

      String token = SHelper.sHelper.getToken();

      http.Response response = await client.post(
        Uri.parse(beseUrl + "order/send_order"),
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
        body: {
          "product_list": cart,
          "carton_list": carton,
          "day": day,
          "time": time,
          "address": address,
          "notes": notes,
          "callme": "1",
          "long": long,
          "lat": lat,
          "mobile": mobile,
          "balance": balance,
        },
      );

      Map map = json.decode(response.body) as Map;
      return map;
    } catch (e) {
      return null;
    }
  }
}
