import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:capotcha/utils/colors.dart';
import 'package:capotcha/utils/permission_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import '../modules/Map/controller/map_controller.dart';

class LocationHelper {
  Geolocator? geolocator;
  MapController mapController = Get.find();
  // Future<Position> getCurrentLocation() async {
  //   try {
  //     Position position = await determinePosition();

  //     return position;
  //   } catch (e) {
  //     return Position(
  //         latitude: 29.944785,
  //         longitude: 30.881651,
  //         accuracy: 1,
  //         altitude: 1,
  //         heading: 1,
  //         speed: 1,
  //         speedAccuracy: 1,
  //         timestamp: DateTime.now());
  //   }
  // }

  // Future<Position> determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     if (Platform.isAndroid) {
  //       Get.defaultDialog(
  //         title: '',
  //         barrierDismissible: false,
  //         content: Column(
  //           children: [
  //             const Icon(
  //               Icons.my_location_outlined,
  //               size: 50,
  //               color: AppColors.greenColor,
  //             ),
  //             const SizedBox(
  //               height: 26,
  //             ),
  //             Text('تفعيل الموقع',
  //                 style: Theme.of(Get.context!).textTheme.bodyText1),
  //             const SizedBox(height: 8),
  //             Container(
  //               constraints: const BoxConstraints(maxWidth: 235),
  //               child: Text(
  //                   'يرجى تفعيل استخدام موقعك لإظهار الخدمات القريبة على الخريطة',
  //                   style: Theme.of(Get.context!).textTheme.bodyText1),
  //             ),
  //             const SizedBox(height: 44),
  //             TextButton(
  //               onPressed: () {
  //                 Get.back();
  //                 Get.back();
  //                 Geolocator.openLocationSettings();
  //               },
  //               style: TextButton.styleFrom(
  //                 backgroundColor: AppColors.greenColor,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //               ),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Text(
  //                   'تمكين موقعي',
  //                   style: Theme.of(Get.context!).textTheme.bodyText1!.copyWith(
  //                       color: Colors.white, fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //         // onWillPop: () {
  //         //   Get.back();
  //         //   return Future.value(false);
  //         // },
  //       );
  //     }
  //     return Future.error('الموقع غير مفعل');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('الموقع غير مفعل');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     Get.defaultDialog(
  //       title: '',
  //       content: Column(
  //         children: [
  //           const Icon(
  //             Icons.my_location_outlined,
  //           ),
  //           const SizedBox(
  //             height: 26,
  //           ),
  //           Text('تفعيل الموقع',
  //               style: Theme.of(Get.context!).textTheme.bodyText1),
  //           const SizedBox(height: 8),
  //           Container(
  //               constraints: const BoxConstraints(maxWidth: 235),
  //               child: Text(
  //                 'يرجى تفعيل استخدام موقعك لإظهار الخدمات القريبة على الخريطة',
  //                 style: Theme.of(Get.context!).textTheme.bodyText1,
  //               )),
  //           const SizedBox(height: 44),
  //           TextButton(
  //             onPressed: () {
  //               Geolocator.openLocationSettings();
  //             },
  //             child: const Text('تمكين موقعي'),
  //           )
  //         ],
  //       ),
  //       onWillPop: () {
  //         Get.back();
  //         return Future.value(false);
  //       },
  //     );

  //     return Future.error('الموقع غير مفعل');
  //   }

  //   return await Geolocator.getCurrentPosition();
  // }

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
