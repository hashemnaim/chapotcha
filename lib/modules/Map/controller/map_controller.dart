import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/location_helper.dart';

class MapController extends GetxController {
  Set<Marker>? markersset;
  RxBool loadAddress = false.obs;
  RxBool isEdit = false.obs;
  Rx<int> idAddress = 0.obs;
  // InitialController initialController = Get.find();
  // Rx<ApiCallStatus> addressStatus = ApiCallStatus.holding.obs;
  TextEditingController addressControlelr = TextEditingController();
  TextEditingController noBuildControlelr = TextEditingController();
  TextEditingController areaControlelr = TextEditingController();
  TextEditingController noFloorControlelr = TextEditingController();
  TextEditingController mobileControlelr = TextEditingController();
  Rx<int> index = 0.obs;
  Rx<int> indexCity = 0.obs;
  CameraPosition myLocation = const CameraPosition(
      target: LatLng(
        21.506845,
        39.852190,
      ),
      zoom: 14);
  Position position = Position(
      latitude: 21.506845,
      longitude: 39.852190,
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1,
      timestamp: DateTime.now());

  setInitialCameraPosition(double lat, double lan) async {
    myLocation = CameraPosition(
      target: LatLng(lat, lan),
      zoom: 10,
    );
  }

  Future getLocation(
    GoogleMapController controllerMap,
  ) async {
    loadAddress.value = true;
    if (isEdit.value) {
    } else {
      position = await LocationHelper().getCurrentLocation();
    }

    setInitialCameraPosition(position.latitude, position.longitude);
    setAddress(position);
    controllerMap.animateCamera(CameraUpdate.newLatLng(
      LatLng(position.latitude, position.longitude),
    ));
    loadAddress.value = false;
    update(["gps"]);
    return position;
  }

  Position setNewLatLong(double lat, double lan) {
    position = Position(
        latitude: lat,
        longitude: lan,
        accuracy: 1,
        altitude: 1,
        heading: 1,
        speed: 1,
        speedAccuracy: 1,
        timestamp: DateTime.now());
    loadAddress.value = false;

    update();
    return position;
  }

  setAddress(Position position) async {
    loadAddress.value = true;
    String address = await (LocationHelper()
        .getPlaceName(position.latitude, position.longitude) as FutureOr<String>);
    addressControlelr.text = address;
    loadAddress.value = false;
    update();
  }
}
