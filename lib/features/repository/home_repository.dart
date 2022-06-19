import 'dart:convert';

import 'package:capotcha/features/repository/sql_table.dart';
import 'package:capotcha/models/ChangePassword.dart';
import 'package:capotcha/models/cart_modal.dart';
import 'package:capotcha/models/carton_model.dart';
import 'package:capotcha/models/complete_cart.dart';
import 'package:capotcha/models/discount_model.dart';
import 'package:capotcha/models/home_model.dart';
import 'package:capotcha/models/login_model.dart';
import 'package:capotcha/models/notfcation.dart';
import 'package:capotcha/models/offer_model.dart';
import 'package:capotcha/models/order.dart';
import 'package:capotcha/models/points_model.dart';
import 'package:capotcha/models/profile_modal.dart';
import 'package:capotcha/models/promo_code_model.dart';
import 'package:capotcha/models/regsiter_model.dart';
import 'package:capotcha/models/reset_password.dart';
import 'package:capotcha/models/search.dart';
import 'package:capotcha/models/send_order_model.dart';
import 'package:capotcha/models/support_model.dart';
import 'package:capotcha/models/update_model.dart';
import 'package:intl/intl.dart';
import 'api_client.dart';

class HomeRepository {
  HomeRepository._();
  static final HomeRepository homeRepository = HomeRepository._();

  // Future<LoginModel> loginUser(
  //     String mobile, String password, String token) async {
  //   try {
  //     Map<String, dynamic> map =
  //         await NewClient.newClient.loginUser(mobile, password, token);
  //     LoginModel loginModel = LoginModel.fromJson(map);
  //     return loginModel;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  Future<RegisterModel> registerUser(
      String name, String password, String mobile) async {
    try {
      Map<String, dynamic> map =
          await NewClient.newClient.registerUser(name, password, mobile);
      RegisterModel registerModel = RegisterModel.fromJson(map);
      print(registerModel.accessToken);
      return registerModel;
    } catch (e) {
      return null;
    }
  }

  Future<ResetPassword> resetPassword(String email) async {
    try {
      Map<String, dynamic> map = await NewClient.newClient.resetPassword(email);
      ResetPassword resetPassword = ResetPassword.fromJson(map);
      return resetPassword;
    } catch (e) {
      return null;
    }
  }

  Future<NotfcationModel> getNotfcation(String token) async {
    try {
      Map<String, dynamic> map = await NewClient.newClient.getNotfcation(token);
      NotfcationModel notfcationModel = NotfcationModel.fromJson(map);
      return notfcationModel;
    } catch (e) {
      return null;
    }
  }

  Future<LoginModel> verifyMobile(
      String mobile, String code, String password) async {
    try {
      Map<String, dynamic> map =
          await NewClient.newClient.verifyMobile(mobile, code, password);
      LoginModel verifyMobile = LoginModel.fromJson(map);
      return verifyMobile;
    } catch (e) {
      return null;
    }
  }

  Future<HomeModel> getHome() async {
    try {
      Map<String, dynamic> map = await NewClient.newClient.getHome();
      HomeModel homeModel = HomeModel.fromJson(map);
      return homeModel;
    } catch (e) {
      return null;
    }
  }

  Future<CartonModel> getCarton(int cartonId) async {
    // try {
    Map<String, dynamic> map = await NewClient.newClient.getCarton(cartonId);

    CartonModel cartonModel = CartonModel.fromJson(map);
    return cartonModel;
    // } catch (e) {
    //   return null;
    // }
  }

  Future<Profile_Modal> getProfile() async {
    try {
      Map<String, dynamic> map = await NewClient.newClient.getProfile();
      Profile_Modal profileModal = Profile_Modal.fromJson(map);
      return profileModal;
    } catch (e) {
      return null;
    }
  }

  Future<UpdateUser> getUpdate(
    String name,
    String email,
    String address,
    String mobile,
  ) async {
    try {
      Map<String, dynamic> map = await NewClient.newClient.updateUser(
        name,
        email,
        address,
        mobile,
      );
      UpdateUser updateUser = UpdateUser.fromJson(map);
      return updateUser;
    } catch (e) {
      return null;
    }
  }

  Future<List<DataCart>> getCartDB() async {
    // try {
    List<Map<String, dynamic>> map = await DBClint.dbClint.getProductDB();

    List<DataCart> data = map.map((e) => DataCart.fromJsonDB(e)).toList();
    return data;
    // } catch (e) {
    //   return null;
    // }
  }

  Future<List<DataCarontCart>> getCartonDB() async {
    // try {
    List<Map<String, dynamic>> map = await DBClint.dbClint.getProductCartonDB();

    List<DataCarontCart> data =
        map.map((e) => DataCarontCart.fromJsonDB(e)).toList();

    return data;
    // } catch (e) {
    //   return null;
    // }
  }

  Future<SendMassage> getSendMasseg(
      String name, String mobile, String title, String body) async {
    try {
      Map<String, dynamic> map =
          await NewClient.newClient.setSendMessage(name, mobile, title, body);
      SendMassage sendMassage = SendMassage.fromJson(map);
      return sendMassage;
    } catch (e) {
      return null;
    }
  }

  Future<PromoCode> setPromoCode(String code) async {
    try {
      Map<String, dynamic> map = await NewClient.newClient.setPromoCode(code);
      PromoCode promoCode = PromoCode.fromJson(map);
      return promoCode;
    } catch (e) {
      return null;
    }
  }

  Future<Discount> getDiscount() async {
    try {
      Map<String, dynamic> map = await NewClient.newClient.getDiscount();
      Discount discount = Discount.fromJson(map);

      return discount;
    } catch (e) {
      return null;
    }
  }

  Future<Points> setPoints() async {
    try {
      Map<String, dynamic> map = await NewClient.newClient.setPoints();
      Points points = Points.fromJson(map);
      return points;
    } catch (e) {
      return null;
    }
  }

  Future<ChangePassword> getchangePassword(
      String password, String newpassword) async {
    try {
      Map<String, dynamic> map =
          await NewClient.newClient.setChangePassword(password, newpassword);
      ChangePassword changePassword = ChangePassword.fromJson(map);
      return changePassword;
    } catch (e) {
      return null;
    }
  }

  Future<OrderFollow> getOrder(String orderid) async {
    try {
      Map<String, dynamic> map = await NewClient.newClient.setOrder(orderid);

      OrderFollow order = OrderFollow.fromJson(map);
      return order;
    } catch (e) {
      return null;
    }
  }

  Future<CartModel> setCart(
    List<Map<String, dynamic>> cart,
    List<Map<String, dynamic>> carton,
  ) async {
    try {
      String cartTojson = jsonEncode(cart);
      String cartonTojson = jsonEncode(carton);

      Map<String, dynamic> map =
          await NewClient.newClient.setCart(cartTojson, cartonTojson);
      CartModel cartModel = CartModel.fromJson(map);

      return cartModel;
    } catch (e) {
      return null;
    }
  }

  Future<SendOrder> setSendOrder(
    List<Map<String, dynamic>> carton,
    List<Map<String, dynamic>> cart,
    String day,
    String time,
    String address,
    String notes,
    String mobile,
    String long,
    String lat,
    String balance,
  ) async {
    try {
      String carts = jsonEncode(cart);
      String cartons = jsonEncode(carton);
      Map<String, dynamic> map = await NewClient.newClient.setSendOrder(cartons,
          carts, day, time, address, notes, mobile, long, lat, balance);
      SendOrder sendOrder = SendOrder.fromJson(map);

      return sendOrder;
    } catch (e) {
      return null;
    }
  }

  Future<OfferModel> getOffers() async {
    try {
      Map<String, dynamic> map = await NewClient.newClient.getOffers();

      OfferModel prodacts = OfferModel.fromJson(map);

      return prodacts;
    } catch (e) {
      return null;
    }
  }

  Future<Search> getAllSearch({String search}) async {
    try {
      Map<String, dynamic> map =
          await NewClient.newClient.getsearch(search: search);

      Search prodacts = Search.fromJson(map);
      return prodacts;
    } catch (e) {
      return null;
    }
  }

  Future<CompleteCart> getCompleteCart(String areaId, String later) async {
    try {
      Map<String, dynamic> map = await NewClient.newClient.getCompleteCart(
          areaId, DateFormat.Hm().format(new DateTime.now()), later);
      CompleteCart lastLo = CompleteCart.fromJson(map);
      return lastLo;
    } catch (e) {
      return null;
    }
  }
}
