// import 'dart:async';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import '../../../config/theme/light_theme_colors.dart';
// import '../../components/custom_button.dart';
// import '../../components/custom_svg.dart';
// import '../../routes/app_pages.dart';
// import 'auth_controller.dart';

// class ActiveCodeScreen extends StatefulWidget {
//   const ActiveCodeScreen({Key? key}) : super(key: key);

//   @override
//   State<ActiveCodeScreen> createState() => _ActiveCodeScreenState();
// }

// class _ActiveCodeScreenState extends State<ActiveCodeScreen>
//     with TickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();

//   StreamController<ErrorAnimationType>? errorController;

//   AnimationController? controller;
//   AuthController authController = Get.find<AuthController>();
//   int levelClock = 120;
//   @override
//   void initState() {
//     errorController = StreamController<ErrorAnimationType>();
//     controller = AnimationController(
//         vsync: this, duration: Duration(seconds: levelClock));

//     controller!.forward();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     errorController!.close();
//     controller!.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           leading: InkWell(
//             onTap: () {
//               Get.offAllNamed(
//                 Routes.SignInScreen,
//               );
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(6.0),
//               child: CustomSvgImage(
//                 "back",
//                 height: 40.h,
//                 width: 40.w,
//               ),
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: 100.h,
//               ),
//               Text(
//                 "تأكيد رقم الهاتف",
//                 textAlign: TextAlign.center,
//                 style: Theme.of(context)
//                     .textTheme
//                     .headline4!
//                     .copyWith(fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 20.h,
//               ),
//               Center(
//                 child: Text(
//                   'المرجو تاكيد رقم الهاتف الخاصة بك',
//                   textAlign: TextAlign.center,
//                   style: Theme.of(context).textTheme.headline6!.copyWith(
//                       color: LightThemeColors.body2TextColor,
//                       fontWeight: FontWeight.normal),
//                 ),
//               ),
//               SizedBox(
//                 height: 8.h,
//               ),
//               Center(
//                 child: Text.rich(
//                     TextSpan(
//                       text: 'تم ارسال الرمز الى هدا الرقم\n',
//                       style: Theme.of(context).textTheme.headline6!.copyWith(
//                           color: LightThemeColors.body2TextColor,
//                           fontWeight: FontWeight.normal),
//                       children: <TextSpan>[
//                         TextSpan(
//                             text: "00${authController.codeCountry.value}" +
//                                 authController.mobileControlelr.value.text +
//                                 "  ",
//                             style:
//                                 Theme.of(context).textTheme.headline6!.copyWith(
//                                       fontWeight: FontWeight.normal,
//                                       color: LightThemeColors.body2TextColor,
//                                       fontSize: 16.sp,
//                                     ),
//                             recognizer: TapGestureRecognizer()..onTap = () {}),
//                         TextSpan(
//                             text: 'تعديل',
//                             style:
//                                 Theme.of(context).textTheme.headline6!.copyWith(
//                                       fontWeight: FontWeight.normal,
//                                       height: 2,
//                                       fontSize: 16.sp,
//                                       color: LightThemeColors.primaryColor,
//                                     ),
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = () {
//                                 Navigator.of(context).pop();
//                               })
//                       ],
//                     ),
//                     textAlign: TextAlign.center),
//               ),
//               SizedBox(
//                 height: 50.h,
//               ),
//               Text(
//                 "رمز التأكيد",
//                 textAlign: TextAlign.start,
//                 style: Theme.of(context)
//                     .textTheme
//                     .headline5!
//                     .copyWith(fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 16.h,
//               ),
//               Form(
//                 key: _formKey,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 40.0.w),
//                   child: PinCodeTextField(
//                     length: 4,
//                     appContext: context,

//                     animationType: AnimationType.fade,
//                     validator: (v) {
//                       if (v!.length < 4) {
//                         return '';
//                       } else {
//                         return null;
//                       }
//                     },
//                     pinTheme: PinTheme(
//                       shape: PinCodeFieldShape.box,
//                       borderRadius: BorderRadius.circular(12.sp),
//                       borderWidth: 2,
//                       errorBorderColor: Colors.red,
//                       fieldHeight: 70.h,
//                       fieldWidth: 56.w,
//                       selectedColor: Colors.white,
//                       inactiveColor: Colors.white,
//                       inactiveFillColor: Colors.white,
//                       selectedFillColor: Colors.white,
//                       activeColor: Colors.white,
//                       activeFillColor: Colors.white,
//                     ),

//                     animationDuration: const Duration(milliseconds: 300),
//                     // backgroundColor: null,
//                     enableActiveFill: true,
//                     errorAnimationController: errorController,
//                     keyboardType: TextInputType.text,
//                     // backgroundColor: Colors.grey,

//                     controller: authController.codeValtionController.value,
//                     onChanged: (value) {},
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 50.h,
//               ),
//               CustomButton(
//                   buttonText: "تأكيد",
//                   onPressed: () => authController.verification(_formKey)),
//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text.rich(
//                       TextSpan(
//                         text: "",
//                         style: Theme.of(context).textTheme.headline5!.copyWith(
//                               fontSize: 16.sp,
//                             ),
//                         children: <TextSpan>[
//                           TextSpan(
//                               text: "إعادة ارسال الرمز",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .headline6!
//                                   .copyWith(
//                                       fontWeight: FontWeight.normal,
//                                       fontSize: 16,
//                                       color: LightThemeColors.primaryColor,
//                                       decoration: TextDecoration.underline),
//                               recognizer: TapGestureRecognizer()
//                                 ..onTap = () {
//                                   authController.resendOtp();
//                                 })
//                         ],
//                       ),
//                       textAlign: TextAlign.start,
//                     ),
//                     Countdown(
//                         animation: StepTween(
//                       begin: levelClock,
//                       end: 0,
//                     ).animate(controller!)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }

// class Countdown extends AnimatedWidget {
//   const Countdown({Key? key, required this.animation})
//       : super(key: key, listenable: animation);
//   final Animation<int> animation;

//   @override
//   build(BuildContext context) {
//     Duration clockTimer = Duration(seconds: animation.value);

//     String timerText =
//         '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

//     return Text(
//       timerText,
//       style: const TextStyle(
//         fontSize: 20,
//         color: Colors.grey,
//       ),
//     );
//   }
// }
