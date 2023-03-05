import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/location_helper.dart';
import '../model/address_model.dart';

class MapController extends GetxController {
  Set<Marker>? markersset;
  bool loadAddress = false;
  // bool loadAddress = false;
  RxBool isEdit = false.obs;
  Rx<int> idAddress = 0.obs;
  String address = '';

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

  // Position _pickPosition = Position(
  //     longitude: 0,
  //     latitude: 0,
  //     timestamp: DateTime.now(),
  //     accuracy: 1,
  //     altitude: 1,
  //     heading: 1,
  //     speed: 1,
  //     speedAccuracy: 1);
  bool loading = false;

  setInitialCameraPosition(double lat, double lan) async {
    myLocation = CameraPosition(target: LatLng(lat, lan), zoom: 16);
  }

  Future<DataAddress> getCurrentLocation(bool fromAddress,
      {GoogleMapController? mapController,
      LatLng? defaultLatLng,
      bool notify = true}) async {
    loading = true;
    if (notify) {
      update(["gps"]);
    }
    DataAddress _addressModel;
    Position _myPosition;
    try {
      Position newLocalData = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      _myPosition = newLocalData;
    } catch (e) {
      _myPosition = Position(
        latitude: defaultLatLng != null ? defaultLatLng.latitude : 21.506845,
        longitude: defaultLatLng != null ? defaultLatLng.longitude : 39.852190,
        timestamp: DateTime.now(),
        accuracy: 1,
        altitude: 1,
        heading: 1,
        speed: 1,
        speedAccuracy: 1,
      );
    }
    if (fromAddress) {
      position = _myPosition;
    } else {
      // _pickPosition = _myPosition;
    }
    _addressModel = DataAddress(
      lat: _myPosition.latitude.toString(),
      lng: _myPosition.longitude.toString(),
    );
    loading = false;
    update(["gps"]);
    return _addressModel;
  }

  // Future getLocation(GoogleMapController controllerMap) async {
  //   loadAddress = true;

  //   position = await LocationHelper().getCurrentLocation();

  //   setInitialCameraPosition(position.latitude, position.longitude);
  //   setAddress(position);
  //   controllerMap.animateCamera(
  //       CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)));
  //   loadAddress = false;
  //   update(["gps"]);
  //   return position;
  // }

  Future<String> getNameAddress(Position position) async {
    loadAddress = true;

    update(["gps"]);

    String address = await LocationHelper()
        .getPlaceName(position.latitude, position.longitude);
    this.address = address;
    loadAddress = false;

    update(["gps"]);
    return address;
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

  Future<String> setAddress(Position position) async {
    loadAddress = true;
    addressControlelr.text = await LocationHelper()
        .getPlaceName(position.latitude, position.longitude);
    loadAddress = false;
    update(["gps"]);
    return addressControlelr.text;
  }
}
