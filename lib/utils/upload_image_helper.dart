// import 'dart:io';
// import 'dart:math';

// import 'package:bot_toast/bot_toast.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

// class UplodeImageHelper {
//   Future<MultipartFile> compressFile(File file) async {
//     if (file.path == null || file.path == "") {
//       BotToast.showText(
//           text: "يجب اضافة الصور المطلوبة ", contentColor: Colors.red);
//       return null;
//     } else {
//       var result = await FlutterImageCompress.compressWithFile(
//         file.absolute.path,
//         minHeight: 720,
//         minWidth: 720,
//         quality: 60,
//         format: CompressFormat.png,
//       );
//       MultipartFile multipartFile = MultipartFile.fromBytes(
//         result!,
//         filename: 'load_image${Random().nextInt(20)}.png',
//         contentType: MediaType("image", "png"),
//       );
//       return multipartFile;
//     }
//   }

//   Future<File?> getImage() async {
//     XFile? image = await pickImage(ImageSource.gallery);
//     return await imageCropper(image!.path);
//   }

//   Future<File?> imageCropper(String file) async {
//     try {
//       CroppedFile? croppedFile = await ImageCropper().cropImage(
//         sourcePath: file,
//         aspectRatioPresets: [
//           CropAspectRatioPreset.ratio4x3,
//           CropAspectRatioPreset.ratio3x2,
//           CropAspectRatioPreset.original,
//           CropAspectRatioPreset.ratio4x3,
//           CropAspectRatioPreset.ratio16x9
//         ],
//         uiSettings: [
//           AndroidUiSettings(
//               toolbarTitle: 'إضافة  صورة',
//               toolbarColor: Colors.white,
//               toolbarWidgetColor: Colors.white,
//               initAspectRatio: CropAspectRatioPreset.original,
//               lockAspectRatio: false),
//           IOSUiSettings(
//               title: 'Cropper',
//               minimumAspectRatio: 0.5,
//               rectHeight: 171,
//               rectWidth: 333),
//         ],
//       );

//       if (croppedFile != null) {
//         return File(croppedFile.path);
//       } else {
//         return File("error");
//       }
//     } catch (e) {
//       return File("error");
//     }
//   }

//   Future<XFile?> pickImage(
//     ImageSource source,
//   ) async {
//     return await ImagePicker().pickImage(source: source);
//   }
// }
