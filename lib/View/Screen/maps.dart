import 'package:capotcha/View/widgets/AppCustomer.dart';
import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/value/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapsG extends StatefulWidget {
  static String routeName = 'LocationCollecter';
  @override
  State<StatefulWidget> createState() {
    return LocationCollecterState();
  }
}

class LocationCollecterState extends State<MapsG> {
  GoogleMapController mapController;
  GlobalKey<ScaffoldState> scaffolState = GlobalKey();
  String label = '';

  final LatLng _center = const LatLng(24.4539, 54.3773);

  Future<Position> getCurrentLocation() async {
    Position position = await Provider.of<HomeProvieder>(context, listen: false)
        .setCurrentLocation();
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 15)));
    return position;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    getCurrentLocation().then((position) {
      markerPosition = position;
      _markers.clear();
      _markers.add(Marker(
          markerId: MarkerId('userSelection'),
          position: LatLng(position.latitude, position.longitude)));
      setState(() {});
    });
  }

  Set<Marker> _markers = {};
  Position markerPosition;
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Scaffold(
            key: scaffolState,
            appBar: PreferredSize(
              child: AppCustomer("تحديد الموقع"),
              preferredSize: const Size(double.infinity, 60),
            ),
            body: Stack(
              children: <Widget>[
                GoogleMap(
                  zoomControlsEnabled: false,
                  markers: _markers,
                  onTap: (piclerLocation) {
                    _markers.clear();
                    _markers.add(Marker(
                        markerId: MarkerId('userSelection'),
                        position: LatLng(piclerLocation.latitude,
                            piclerLocation.longitude)));
                    setState(() {});
                    markerPosition = Position(
                        latitude: piclerLocation.latitude,
                        longitude: piclerLocation.longitude);
                  },
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 5.0,
                  ),
                ),
                Positioned(
                  bottom: 30,
                  right: 15,
                  child: FlatButton(
                      onPressed: () async {
                        Position position = await Provider.of<HomeProvieder>(
                                context,
                                listen: false)
                            .setCurrentLocation();
                        print(position.latitude);
                        mapController
                            .animateCamera(CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target:
                                  LatLng(position.latitude, position.longitude),
                              zoom: 15),
                        ));

                        await Fluttertoast.showToast(
                            msg: " تم اضافة موقعك",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: AppColors.greenColor,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        _markers.clear();
                        _markers.add(Marker(
                            markerId: MarkerId('currentLocation'),
                            position:
                                LatLng(position.latitude, position.longitude)));
                        setState(() {});
                        markerPosition = position;
                      },
                      child: CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColors.greenColor,
                          child: Icon(Icons.done, color: Colors.white))),
                )
              ],
            ),
          ),
        ));
  }
}
