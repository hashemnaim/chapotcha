import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Constants {
  static const baseUrl = "https://cabuch.com";
  static const mainUrl = baseUrl + '/api/v1/';
  static const imgUrl = baseUrl + '/public/images/products/';
  static const imgUrlSlider = baseUrl + '/public/images/';

  /// Home
  static const HomeUrl = mainUrl + 'user/home';
  static const productUrl = mainUrl + 'product/products';
  static const newProductUrl = mainUrl + 'product/new-products';
  static const cartonsUrl = mainUrl + 'product/get_cartons';

  /// Auth
  static const loginUrl = mainUrl + 'user/login';
  static const registerUrl = mainUrl + 'user/register';
  static const settingUrl = mainUrl + 'user/setting';
  static const resendPasswordUrl = mainUrl + 'user/reset_password';
  static const changePasswordUrl = mainUrl + 'user/change_password';

  /// Profile
  static const updateProfileUrl = mainUrl + 'user/update_user';
  static const removeUserUrl = mainUrl + 'remove-user';
  static const profileUrl = mainUrl + 'user/my_profile';
  static const changeMobileUrl = mainUrl + 'changeMobile';
  static const passwordUpdateUrl = mainUrl + 'user/change_password';
  static const sendMessageUrl = mainUrl + 'user/send_message';

  /// Cart
  static const completeCartUrl = mainUrl + 'user/complete_cart';
  static const ordersCountPeriodUrl = mainUrl + 'order/orders-count-period';
  static const sendOrder = mainUrl + 'order/create-new-order';
  static const getCartUrl = mainUrl + 'order/cart';
  static const addCartUrl = mainUrl + 'order/add-cart';
  static const deleteCartUrl = mainUrl + 'order/delete-cart';
  static const updateCartUrl = mainUrl + 'order/update-cart';

  /// Order
  static const getOrder = mainUrl + 'order/orders';

  /// MyAddresses
  static const myAddressesUrl = mainUrl + 'address-list';
  static const deleteAddressUrl = mainUrl + 'delete-address';
  static const citiesApiUrl = mainUrl + 'cities';
  static const areaApiUrl = mainUrl + 'city-areas';
  static const addAddressUrl = mainUrl + 'store-address';

  static const currency = 'جنيه';

//DB Items
  static final String TableCartName = 'cartProduct';
  static final String ColumnId = 'id';
  static final String ColumnName = 'name';
  static final String ColumnUnit = 'unit';
  static final String ColumnPrice = 'price';
  static final String ColumnImage = 'image';
  static final String ColumnMaxQuantity = 'max_quantity';
  static final String ColumnStock = 'stock';
  static final String ColumnQuantity = 'quantity';

  static final String quntiteyProduct = 'quantity';
}

// Form Error

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 15.w),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.w),
    borderSide: BorderSide(
      color: ThemeData().primaryColor,
    ),
  );
}

Decoration backgroundImage = BoxDecoration(
  image: DecorationImage(
      image: AssetImage("assets/images/background.png"), fit: BoxFit.fill),
);
