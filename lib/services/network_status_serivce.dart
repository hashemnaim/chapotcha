import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'error_snackbar.dart';

class NetworkController extends GetxController {
  var connectionStatus = 1.obs;
  final Connectivity _connectivity = Connectivity();
  // ignore: unused_field
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void onInit() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.onInit();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult? result;
    {
      try {
        result = await _connectivity.checkConnectivity();
        // ignore: empty_catches
      } on PlatformException {}
    }
    return _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(ConnectivityResult? result) {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.ethernet:
        if (connectionStatus.value == 0) {
          connectionStatus.value = 1;
          // Get.find<DataSyncController>().syncData();
        }
        break;
      case ConnectivityResult.none:
        connectionStatus.value = 0;
        break;
      default:
        ErrorSnackbar.displayErrorSnackbar(
            'Network Error', 'Unable to retrieve connection status');
        break;
    }
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
