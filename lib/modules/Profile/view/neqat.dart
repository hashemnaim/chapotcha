// import 'package:capotcha/View/widgets/background.dart';
// import 'package:capotcha/View/widgets/isload.dart';
// import 'package:capotcha/features/providers/home_provieder.dart';
// import 'package:capotcha/models/points_model.dart';
// import 'package:capotcha/value/colors.dart';
// import 'package:capotcha/value/styles.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../utils/shared_preferences_helpar.dart';

// class Neqat extends StatefulWidget {
//   @override
//   _NeqatState createState() => _NeqatState();
// }

// class _NeqatState extends State<Neqat> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Points>(
//         future: Provider.of<HomeProvieder>(context).setPoints(),
//         builder: (context, AsyncSnapshot snapshot) {
//           if (snapshot.hasData) {
//             Points points = snapshot.data;
//             if (points != null) {
//               return Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Container(
//                     child: Column(
//                   children: [
//                     Expanded(
//                       child: Stack(
//                         children: [
//                           Bakeground(),
//                           Column(
//                             children: [
//                               if (SHelper.sHelper.getToken() == null)
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Align(
//                                         alignment: Alignment.topRight,
//                                         child: Text("اهلا بيك كزائر, \n ",
//                                             style: TextStyle(
//                                               color: AppColors.bluColor,
//                                               fontFamily: 'Cairo',
//                                               fontSize: 30.0,
//                                             ))),
//                                     InkWell(
//                                       onTap: () {
//                                         // Get.offAll(() => LoginScreen());
//                                       },
//                                       child: Text(
//                                         " عليك تسجيل الدخول لمعرفة رصيدك نقاطك",
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 56, 136, 205),
//                                           fontFamily: 'Cairo',
//                                           fontSize: 24.0,
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 )
//                               else
//                                 // Container(
//                                 //   child: Align(
//                                 //       alignment: Alignment.topRight,
//                                 //       child: Text(
//                                 //           "الرصيد : " +
//                                 //                   tokenProvider.profilemodal
//                                 //                       .user.balance ??
//                                 //               "" + " جنيه" ??
//                                 //               "0" + " جنيه",
//                                 //           style: TextStyle(
//                                 //             color: AppColors.bluColor,
//                                 //             fontFamily: 'Cairo',
//                                 //             fontSize: 30.0,
//                                 //             height: 1.2,
//                                 //           ))),
//                                 // ),

//                                 // SizedBox(
//                                 //   height:
//                                 //       MediaQuery.of(context).size.height * 0.01,
//                                 // ),
//                                 Container(
//                                     width:
//                                         MediaQuery.of(context).size.width * 0.8,
//                                     height: MediaQuery.of(context).size.height *
//                                         0.15,
//                                     child: Align(
//                                         alignment: Alignment.topRight,
//                                         child: RichText(
//                                           text: TextSpan(
//                                             text: points.details,
//                                             style: Style.cairo,
//                                           ),
//                                         ))),
//                               Expanded(
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(left: 20),
//                                   child: Container(
//                                     //  width: 220,
//                                     child: Center(
//                                       child: Image.asset(
//                                         "assets/images/neqt.png",
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               // Center(
//                               //     child: Text(
//                               //   'النقاط',
//                               //   style: Style.cairog,
//                               // )),
//                               // SizedBox(
//                               //   height: MediaQuery.of(context).size.height * 0.01,
//                               // ),
//                               // Center(
//                               //     child: points.points != null
//                               //         ? Text(
//                               //             "${points.points}",
//                               //             style: Style.cairo,
//                               //           )
//                               //         : Text(
//                               //             "${0}",
//                               //             style: Style.cairo,
//                               //           )),
//                               // SizedBox(
//                               //   height:
//                               //       MediaQuery.of(context).size.height * 0.02,
//                               // ),
//                               // Container(
//                               //   width: 300,
//                               //   decoration: BoxDecoration(
//                               //       borderRadius: BorderRadius.circular(10),
//                               //       color: AppColors.greenColor),
//                               //   child: RaisedButton(
//                               //       color: Colors.transparent,
//                               //       elevation: 0,
//                               //       onPressed: () async {
//                               //         if (double.parse(points.points) > 50) {
//                               //           print(points.points);
//                               //           await NewClient.newClient
//                               //               .replacePoint();
//                               //           Provider.of<HomeProvieder>(context,
//                               //                   listen: false)
//                               //               .setPoints();
//                               //           tokenProvider.getProfile();

//                               //           await Fluttertoast.showToast(
//                               //               msg: "تم استبدال النقاط",
//                               //               toastLength: Toast.LENGTH_SHORT,
//                               //               gravity: ToastGravity.BOTTOM,
//                               //               timeInSecForIosWeb: 1,
//                               //               backgroundColor: Colors.green,
//                               //               textColor: Colors.white,
//                               //               fontSize: 16.0);
//                               //           setState(() {});
//                               //         } else {
//                               //           await Fluttertoast.showToast(
//                               //               msg: "النقاط اقل من 50",
//                               //               toastLength: Toast.LENGTH_SHORT,
//                               //               gravity: ToastGravity.BOTTOM,
//                               //               timeInSecForIosWeb: 1,
//                               //               backgroundColor: Colors.red,
//                               //               textColor: Colors.white,
//                               //               fontSize: 16.0);
//                               //         }
//                               //       },
//                               //       child: Text(
//                               //         "استبدال ",
//                               //         style: Style.cairoW,
//                               //       )),
//                               // ),

//                               SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.02,
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//               );
//             } else {
//               return Center(child: IsLoad());
//             }
//           } else {
//             return Center(child: IsLoad());
//           }
//         });
//   }
// }
