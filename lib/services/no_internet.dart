// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:remak/view/custom_widget/custom_image.dart';
// import 'package:remak/view/home_screen/home_screen.dart';
// import '../../values/colors.dart';
// import 'custom_text.dart';

// class NoInternetScreen extends StatefulWidget {
//   @override
//   State<NoInternetScreen> createState() => _NoInternetScreenState();
// }

// class _NoInternetScreenState extends State<NoInternetScreen> {
//   final ConnectivityResult connectionStatus = ConnectivityResult.none;

//   bool hasInternt = true;

//   @override
//   initState() {
//     super.initState();

//     InternetConnectionChecker().onStatusChange.listen(
//       (event) {
//         bool hasInternt = event == InternetConnectionStatus.connected;
//         setState(() {
//           this.hasInternt = hasInternt;
//         });
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//           leading: InkWell(
//               onTap: () => Get.offAll(() => HomeScreen()),
//               child: Row(
//                 children: [
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Icon(
//                     Icons.refresh,
//                     size: 30,
//                     color: AppColors.primary,
//                   ),
//                 ],
//               )),
//           centerTitle: true,
//           title: InkWell(
//             child: CustomSvgImage(
//               imageName: "logo",
//               height: 43.21,
//             ),
//           )),
//       body: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Align(
//                 alignment: Alignment.center,
//                 child: Icon(
//                   Icons.wifi_off,
//                   size: 300,
//                   color: Colors.grey,
//                 )),
//             CustomText(
//               text: "No Intetnet",
//               fontSize: 50,
//               color: Colors.black54,
//               fontWeight: FontWeight.bold,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
