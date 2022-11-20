import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/location_helper.dart';

class MapController extends GetxController {
  Set<Marker>? markersset;
  bool loadAddress = false;
  // bool loadAddress = false;
  RxBool isEdit = false.obs;
  Rx<int> idAddress = 0.obs;

  TextEditingController addressControlelr = TextEditingController();
  TextEditingController noBuildControlelr = TextEditingController();
  TextEditingController noWordBuildControlelr = TextEditingController();
  TextEditingController noFlatControlelr = TextEditingController();
  TextEditingController areaControlelr = TextEditingController();
  TextEditingController noFloorControlelr = TextEditingController();
  TextEditingController mobileControlelr = TextEditingController();
  Rx<int> index = 0.obs;
  Rx<int> indexCity = 0.obs;
  CameraPosition myLocation = const CameraPosition(
      target: LatLng(
        29.944785,
        30.881651,
      ),
      zoom: 16);
  Position position = Position(
      latitude: 29.944785,
      longitude: 30.881651,
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1,
      timestamp: DateTime.now());

  setInitialCameraPosition(double lat, double lan) async {
    myLocation = CameraPosition(
      target: LatLng(lat, lan),
      zoom: 16,
    );
  }

  Future getLocation(
    GoogleMapController controllerMap,
  ) async {
    loadAddress = true;

    position = await LocationHelper().getCurrentLocation();
    update(["gps"]);

    setInitialCameraPosition(position.latitude, position.longitude);
    setAddress(position);
    controllerMap.animateCamera(CameraUpdate.newLatLng(
      LatLng(position.latitude, position.longitude),
    ));
    loadAddress = false;
    update(["gps"]);
    return position;
  }

  Position setNewLatLong(double lat, double lan) {
    loadAddress = true;
    position = Position(
        latitude: lat,
        longitude: lan,
        accuracy: 1,
        altitude: 1,
        heading: 1,
        speed: 1,
        speedAccuracy: 1,
        timestamp: DateTime.now());
    loadAddress = false;

    update(["gps"]);
    return position;
  }

  setAddress(Position position) async {
    loadAddress = true;
    await (LocationHelper()
        .getPlaceName(position.latitude, position.longitude));
    // addressControlelr.text = address;
    loadAddress = false;
    update(["gps"]);
  }
}
