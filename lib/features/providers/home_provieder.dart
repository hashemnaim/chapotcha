import 'package:capotcha/features/repository/api_client.dart';
import 'package:capotcha/features/repository/home_repository.dart';
import 'package:capotcha/features/repository/s_helpar.dart';
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
import 'package:capotcha/value/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomeProvieder extends ChangeNotifier {
  HomeModel homeModel;
  Search dataProdactsSeach;
  LoginModel loginModel;
  Discount discountModel;
  PromoCode promoCode;
  CompleteCart completeCart;
  UpdateUser updateUser;
  OfferModel dataOffers;
  CartModel cartModel;
  SendMassage sendMassage;
  OrderFollow order;
  ChangePassword changePassword;
  Profile_Modal profilemodal;
  SendOrder sendOrder;
  List<DataCart> dataCart = [];
  List<DataCarontCart> cartonCart = [];
  CartonModel cartonModel;
  // Map r;
  List<int> dataprId = [];
  RegisterModel registerModel;
  Map<int, double> quantityMap = {};
  int index;
  int indexN = 0;
  String name = "";
  double quantity = 0.5;
  double quantityCart = 0.5;
  String errorMessage = "";
  bool loading = false;
  bool isLoad = false;
  String token;
  String day;
  String time;
  String address = "";
  String notes;
  String mobileSendCart;
  String delivery;
  ResetPassword resetPassword;
  String nameDay;
  String password;
  String mail;
  String lang;
  String tax;
  String lat;
  String dataDiscount;
  String mobile;
  double lo = 0.0;
  double la = 0.0;
  Color locton = AppColors.bluColor;
  Position position;

  String tim;
  num price;
  double priceTotel;
  Points points;
  String point;
  int orderId;
  String search = "";
  bool toggleEye = true;
  IconData iconData = FontAwesomeIcons.eyeSlash;

  Future<HomeModel> getHome() async {
    try {
      HomeModel homeModel = await HomeRepository.homeRepository.getHome();
      this.homeModel = homeModel;
      return homeModel;
    } catch (e) {
      return null;
    }
  }
// setPostion(){
//   position =completeCart.locationlong!=""?
//    Position(latitude:double.parse(completeCart.locationlat), longitude:double.parse(completeCart.locationlong)):

//   Position(latitude: 24.4539, longitude: 54.3773);

// }

  Future<OrderFollow> getOrder(String orderid) async {
    try {
      OrderFollow order = await HomeRepository.homeRepository.getOrder(orderid);
      this.order = order;
      return order;
    } catch (e) {
      return null;
    }
  }

  getCartDB() async {
    try {
      List<DataCart> data = await HomeRepository.homeRepository.getCartDB();

      this.dataCart = data;

      notifyListeners();
      return dataCart;
    } catch (e) {
      return null;
    }
  }

  getCartonDB() async {
    try {
      List<DataCarontCart> data =
          await HomeRepository.homeRepository.getCartonDB();

      this.cartonCart = data;
      notifyListeners();
      return dataCart;
    } catch (e) {
      return null;
    }
  }

  getCarton(int cartonId) async {
    try {
      CartonModel cartonModel =
          await HomeRepository.homeRepository.getCarton(cartonId);

      this.cartonModel = cartonModel;

      notifyListeners();
      return cartonModel;
    } catch (e) {
      return null;
    }
  }
  //  replacePoint(int cartonId) async {
  //   print(0);
  //   try {
  //     Map cartonModel =
  //         await NewClient.newClient.replacePoint();

  //     // this.cartonModel = cartonModel;

  //     notifyListeners();
  //     return cartonModel;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  getprdaDB() {
    try {
      List<int> dataprId = dataCart.map((e) => e.productId).toList();
      this.dataprId = dataprId;
      return dataprId;
    } catch (e) {}
  }

  Future<List<DataCart>> getProdactIdDB() async {
    try {
      List<DataCart> data = await HomeRepository.homeRepository.getCartDB();
      this.dataCart = data;
      return data;
    } catch (e) {
      return null;
    }
  }

  Future<CartModel> setCart() async {
    try {
      CartModel cartModel = await HomeRepository.homeRepository.setCart(
        await DBClint.dbClint.getProductDB(),
        await DBClint.dbClint.getProductCartonDB(),
      );
      this.cartModel = cartModel;
      // notifyListeners();
      return cartModel;
    } catch (e) {
      return null;
    }
  }

  double getPriceCart() {
    double priceTotel = 0.0;

    for (int i = 0; cartModel.dataCart.length - 1 >= i; i++) {
      priceTotel = priceTotel +
          cartModel.dataCart[i].price * cartModel.dataCart[i].quantity;
      this.priceTotel = priceTotel;
    }
    return priceTotel;
  }

  num getPrice(int i) {
    try {
      price = cartModel.dataCart[i].price * cartModel.dataCart[i].quantity;
      this.price = price;
      return price;
    } catch (e) {
      return null;
    }
  }

  bool maxCleck = true;

  Future<double> getConter(int add, int id, double quantity, DataCart dataCart,
      int i, String unit, double max, double stock, context) async {
    add == 1
        ? stock > quantity
            ? max > quantity
                ? quantityCart = unit == "carton"
                    ? await DBClint.dbClint
                        .updateCartonInCartFromInside(quantity, id, i, unit)
                    : await DBClint.dbClint
                        .updateProductInCartFromInside(dataCart, i, unit)
                : maxCleck = false
            : Scaffold.of(context).showSnackBar(
                SnackBar(content: Text("الكمية المتاحة غير متوفرة حاليا")))
        : quantityCart = unit == "carton"
            ? await DBClint.dbClint
                .updateCartonInCartFromInside(quantity, id, i, unit)
            : await DBClint.dbClint
                .updateProductInCartFromInside(dataCart, i, unit);
    notifyListeners();

    this.quantityCart = quantityCart;
    return quantityCart;
  }

  Future<Position> setCurrentLocation() async {
    try {
      this.position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      this.la = position.latitude;
      this.lo = position.longitude;
      locton = AppColors.greenColor;
      notifyListeners();
      return position;
    } catch (e) {
      return null;
    }
  }

  Future<SendOrder> setSendOrder(
      List<Map<String, dynamic>> cart,
      List<Map<String, dynamic>> carton,
      String day,
      String time,
      String address,
      String notes,
      String mobile,
      String long,
      String lat,
      String balance) async {
    try {
      SendOrder sendOrder = await HomeRepository.homeRepository.setSendOrder(
          carton, cart, day, time, address, notes, mobile, long, lat, balance);
      this.sendOrder = sendOrder;
      return sendOrder;
    } catch (e) {
      return null;
    }
  }

  getdelet(DataCart dataCart) async {
    try {
      await DBClint.dbClint.deleteproduct(dataCart);
      setquantity(1, dataCart.productId);
      await getCartDB();
    } catch (e) {
      return null;
    }
  }

  getCartondelet(int id) async {
    try {
      print(id);
      await DBClint.dbClint.deleteCarton(id);
      setquantity(1, id);
      await getCartonDB();
    } catch (e) {
      return null;
    }
  }

  Future<Search> setAllSearch(String search) async {
    try {
      Search dataProdactsSeach =
          await HomeRepository.homeRepository.getAllSearch(search: search);
      this.dataProdactsSeach = dataProdactsSeach;
      return dataProdactsSeach;
    } catch (e) {
      return null;
    }
  }

  Future<PromoCode> setPromoCode(String code) async {
    try {
      PromoCode promoCode =
          await HomeRepository.homeRepository.setPromoCode(code);
      this.promoCode = promoCode;
      return promoCode;
    } catch (e) {
      return null;
    }
  }

  Future<CompleteCart> getCompleteCart(String areaId) async {
    try {
      int l;
      if (cartModel.later == 1) {
        l = cartModel.later;
      } else {
        l = 0;
      }

      CompleteCart completeCart =
          await HomeRepository.homeRepository.getCompleteCart(areaId, "$l");
      this.completeCart = completeCart;
      return completeCart;
    } catch (e) {
      return null;
    }
  }

  Future<Points> setPoints() async {
    try {
      Points points = await HomeRepository.homeRepository.setPoints();
      if (token == null && token == "") {
        this.point = points.points;
      } else {
        this.points = points;
      }
      return points;
    } catch (e) {
      return null;
    }
  }

  Future<SendMassage> setSendMassage(
      String name, String mobile, String title, String body) async {
    try {
      SendMassage sendMassage = await HomeRepository.homeRepository
          .getSendMasseg(name, mobile, title, body);
      this.sendMassage = sendMassage;
      return sendMassage;
    } catch (e) {
      return null;
    }
  }

  Future<ChangePassword> getcChangePassword(
      String password, String newpassword) async {
    try {
      ChangePassword changePassword = await HomeRepository.homeRepository
          .getchangePassword(password, newpassword);
      this.changePassword = changePassword;
      return changePassword;
    } catch (e) {
      return null;
    }
  }

  Future<OfferModel> getOffers() async {
    try {
      OfferModel dataOffers = await HomeRepository.homeRepository.getOffers();
      this.dataOffers = dataOffers;
      return dataOffers;
    } catch (e) {
      return null;
    }
  }

  Future<Profile_Modal> getProfile() async {
    try {
      Profile_Modal profilemodal =
          await HomeRepository.homeRepository.getProfile();
      this.profilemodal = profilemodal;
      return profilemodal;
    } catch (e) {
      return null;
    }
  }

  setUpdateUser(String name, String email, String adress, String mobile) async {
    try {
      UpdateUser loginModel = await HomeRepository.homeRepository
          .getUpdate(name, email, adress, mobile);
      this.updateUser = loginModel;
      notifyListeners();
    } catch (e) {
      return null;
    }
  }

  setResetPassword(String email) async {
    try {
      ResetPassword resetPassword =
          await HomeRepository.homeRepository.resetPassword(email);
      this.resetPassword = resetPassword;

      notifyListeners();
    } catch (e) {
      return null;
    }
  }

  fetchUser(String mobile, String password, String token) async {
    try {
      Map<String, dynamic> map =
          await NewClient.newClient.loginUser(mobile, password, token);
      LoginModel loginModel = LoginModel.fromJson(map);

      this.loginModel = loginModel;
      await SHelper.sHelper.setToken(loginModel.accessToken);

      notifyListeners();
    } catch (e) {
      return null;
    }
  }

  Future<NotfcationModel> getNotfcation(String token) async {
    try {
      NotfcationModel notfcationModel =
          await HomeRepository.homeRepository.getNotfcation(token);
      print(notfcationModel.message);
      return notfcationModel;
    } catch (e) {
      return null;
    }
  }

  verifyMobile(String mobile, String code, String password) async {
    LoginModel loginModel = await HomeRepository.homeRepository
        .verifyMobile(mobile, code, password);
    this.loginModel = loginModel;

    notifyListeners();
  }

  regsterUser(
    String name,
    String password,
    String mobile,
  ) async {
    try {
      RegisterModel registerModel =
          await HomeRepository.homeRepository.registerUser(
        name,
        password,
        mobile,
      );
      this.registerModel = registerModel;
      await SHelper.sHelper.setToken(registerModel.accessToken);
      notifyListeners();
    } catch (e) {
      return null;
    }
  }

  changeModelhan(bool isload) {
    this.isLoad = isload;
    notifyListeners();
  }

  void setIndex(value) {
    this.index = value;
    notifyListeners();
  }

  void setNav(value) {
    this.indexN = value;
    notifyListeners();
  }

  bool isUser() {
    return loading != null ? true : false;
  }

  setSend(
    String day,
    String time,
    String address,
    String mobile,
    String notes,
    String delivery,
  ) {
    this.day = day;
    this.time = time;
    this.address = address;
    this.notes = notes;
    this.mobileSendCart = mobile;
    this.delivery = delivery;

    notifyListeners();
  }

  setPassword(String value, String email) {
    this.password = value;
    this.mail = email;
    notifyListeners();
  }

  setNameDay(String nameDay, String tim) {
    this.nameDay = nameDay;
    this.tim = tim;
    notifyListeners();
  }

  setquantity(double quantity, int index) {
    this.quantityMap[index] = quantity;
    notifyListeners();
  }

  double getTotalPrice(
      String tax, String delavery, String discount, String point) {
    double totalPrice = priceTotel +
        ((double.parse(tax ?? "0") * priceTotel) +
            double.parse(delavery) -
            (double.parse(discount) * priceTotel));

    // notifyListeners();
    return totalPrice;
  }

  double getTotalAfter(
      String tax, String delavery, String discount, String point) {
    double totalPrice = priceTotel +
        ((double.parse(tax ?? "0") * priceTotel) +
            double.parse(delavery) -
            (double.parse(discount) * priceTotel) -
            double.parse(point));

    // notifyListeners();
    return totalPrice;
  }

  setOrderId(orderId) {
    this.orderId = orderId;
    notifyListeners();
  }

  String setTax() {
    this.tax = cartModel.tax;
    // notifyListeners();
    return tax;
  }

  String setpoint() {
    this.tax = cartModel.tax;
    // notifyListeners();
    return tax;
  }

  String setDataDiscount() {
    try {
      this.dataDiscount = discountModel.dataDiscount;
      // notifyListeners();
      return dataDiscount;
    } catch (e) {
      return null;
    }
  }

  setNumber(String mobile, String password) {
    this.mobile = mobile;
    this.password = password;
    notifyListeners();
  }

  setLoction(Color locton) {
    this.locton = locton;
    notifyListeners();
  }

  Future<String> getToken() async {
    this.token = SHelper.sHelper.getToken();
    // notifyListeners();
    return token;
  }

  setSearch(String search) {
    this.search = search;
    notifyListeners();
  }

  eyes() {
    toggleEye = !toggleEye;
    iconData = toggleEye ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye;
    notifyListeners();
  }
}
