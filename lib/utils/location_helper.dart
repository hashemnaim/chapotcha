import 'package:bot_toast/bot_toast.dart';
import 'package:capotcha/utils/permission_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import '../modules/Map/controller/map_controller.dart';

class LocationHelper {
  Geolocator? geolocator;
  MapController mapController = Get.find();

  Future<String> getPlaceName(double lat, double long) async {
    try {
      List<geocoding.Placemark> placemarks = await geocoding
          .placemarkFromCoordinates(lat, long, localeIdentifier: 'ar_EG');
      return placemarks.first.street!;
    } catch (e) {
      mapController.loadAddress = false;
      return "";
    }
  }

  static void checkLocationPermission(Function onTap) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      BotToast.showText(text: 'لا يمكن السماح بذلك'.tr);
    } else if (permission == LocationPermission.deniedForever) {
      Get.dialog(PermissionDialog());
    } else {
      onTap();
    }
  }
}
