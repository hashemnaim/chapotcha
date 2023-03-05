// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// // import 'package:internet_connection_checker/internet_connection_checker.dart';

// import '../modules/Home/view/home_screen.dart';
// import '../utils/colors.dart';
// import '../widgets/custom_svg.dart';

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

//     // InternetConnectionChecker().onStatusChange.listen(
//     //   (event) {
//     //     bool hasInternt = event == InternetConnectionStatus.connected;
//     //     setState(() {
//     //       this.hasInternt = hasInternt;
//     //     });
//     //   },
//     // );
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
//                     color: AppColors.greenColor,
//                   ),
//                 ],
//               )),
//           centerTitle: true,
//           title: InkWell(
//             child: CustomSvgImage(
//               "logo",
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
//             Text(
//               "No Intetnet",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
