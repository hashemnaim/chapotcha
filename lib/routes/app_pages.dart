import 'package:capotcha/modules/Auth/view/sign_up_screen.dart';
import 'package:capotcha/modules/splash/splash_screen.dart';
import 'package:get/get.dart';
import '../modules/Main/main_binding.dart';
import '../modules/Main/main_screen.dart';
import '../modules/Map/view/enter_location_screen.dart';
import '../modules/Map/controller/map_binding.dart';
import '../modules/Products/controller/product_binding.dart';
import '../modules/Products/view/product_screen.dart';
import '../modules/Profile/view/add_address.dart';
import '../modules/Splash/splash_binding.dart';
import '../modules/Auth/controller/auth_binding.dart';
import '../modules/Auth/view/sign_in_screen.dart';

class Routes {
  static const INITIAL = Routes.SPLASH;
  static const MAIN = '/main';
  static const SPLASH = '/splash';
  static const Profile = '/Profile';
  static const ProductScreen = '/ProductScreen';
  static const EnterLocationScreen = '/EnterLocationScreen';
  static const SignInScreen = '/SignInScreen';
  static const SignUpScreen = '/SignUpScreen';
  static const GoogleMapScreen = '/GoogleMapScreen';
  static const CartScreen1 = '/CartScreen1';
  static const AddAddressScreen = '/AddAddressScreen';
  static const NotificationScreen = '/NotificationScreen';
}

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.MAIN,
      page: () => MainScreen(),
      bindings: [MainBinding(), MapBinding()],
    ),
    GetPage(
      name: Routes.ProductScreen,
      page: () => ProductScreen(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: Routes.SignInScreen,
      page: () => SignInScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.SignUpScreen,
      page: () => SignUpScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.EnterLocationScreen,
      page: () => EnterLocationScreen(),
      binding: MapBinding(),
    ),
    GetPage(
      name: Routes.AddAddressScreen,
      page: () => AddAddressScreen(),
      binding: MapBinding(),
    ),
  ];
}
