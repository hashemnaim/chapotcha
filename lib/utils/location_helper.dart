import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class LocationHelper {
  Geolocator? geolocator;

  Future<Position> getCurrentLocation() async {
    try {
      Position position = await determinePosition();

      return position;
    } catch (e) {
      return Position(
          latitude: 21.506845,
          longitude: 39.852190,
          accuracy: 1,
          altitude: 1,
          heading: 1,
          speed: 1,
          speedAccuracy: 1,
          timestamp: DateTime.now());
    }
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (Platform.isAndroid) {
        Get.defaultDialog(
          title: '',
          // textConfirm: '       Enable my location       ',
          // confirmTextColor: Colors.white,
          // middleText:'Please enable to use your location to show nearby services on the map' ,
          content: Column(
            children: [
              const Icon(
                Icons.my_location_outlined,
              ),
              const SizedBox(
                height: 26,
              ),
              const Text(
                'Enable Your Location',
              ),
              const SizedBox(height: 8),
              Container(
                constraints: const BoxConstraints(maxWidth: 235),
                child: const Text(
                    'Please enable to use your location to show nearby services on the map'),
              ),
              const SizedBox(height: 44),
              TextButton(
                onPressed: () async {
                  Get.back();
                },
                child: const Text('Enable my location'),
              )
            ],
          ),
          onWillPop: () {
            return Future.value(false);
          },
        );
      }
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.defaultDialog(
        title: '',
        content: Column(
          children: [
            const Icon(
              Icons.my_location_outlined,
            ),
            const SizedBox(
              height: 26,
            ),
            const Text(
              'Enable Your Location',
            ),
            const SizedBox(height: 8),
            Container(
              constraints: const BoxConstraints(maxWidth: 235),
              child: const Text(
                  'Please enable to use your location to show nearby services on the map'),
            ),
            const SizedBox(height: 44),
            TextButton(
              onPressed: () {
                Get.back();
                Geolocator.openLocationSettings();
              },
              child: const Text('Enable my location'),
            )
          ],
        ),
        onWillPop: () {
          return Future.value(false);
        },
      );

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future getPlaceName(double lat, double long) async {
    try {
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(lat, long);
      return placemarks.first.name;
    } catch (e) {
      // mapController.loadAddress.value = false;
    }
  }
}
