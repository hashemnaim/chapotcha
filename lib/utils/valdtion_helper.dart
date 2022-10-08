import 'package:get/get.dart';

class ValidationHelper {
  static final ValidationHelper validationHelper = ValidationHelper._internal();
  ValidationHelper._internal();
  factory ValidationHelper() {
    return validationHelper;
  }

  String? validatePassword(String value) {
    if (value.trim().isEmpty) {
      return 'هذه الخانة مطلوبه!';
    } else if (value.trim().length < 5) {
      return 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل.';
    } else {
      return null;
    }
  }

  String? validateNull(String value) {
    if (value.isEmpty) {
      return 'هذه الخانة مطلوبه!';
    } else {
      return null;
    }
  }

  String? validateConfrmationPassword(String value, String confirmValue) {
    if (value.trim().isEmpty) {
      return 'هذه الخانة مطلوبه! ';
    } else if (value.trim() != confirmValue) {
      return 'كلمة المرور غير متطابقة';
    } else {
      return null;
    }
  }

  String? validateMobile(
    String value,
  ) {
    if (value.trim().isEmpty) {
      return 'هذه الخانة مطلوبه! ';
    } else if (value.trim().length < 10) {
      return 'رقم الهاتف غير صحيح';
    } else if (GetUtils.isPhoneNumber(value.trim()) == false) {
      return 'رقم الهاتف غير صحيح';
    } else {
      return null;
    }
  }

  String? validateUserName(String value) {
    if (value.trim().isEmpty) {
      return 'هذه الخانة مطلوبه! ';
    } else {
      return null;
    }
  }

  String? validateWebsite(String value) {
    bool _validURL = Uri.parse(value).isAbsolute;
    if (!_validURL) {
      return 'الرابط غير صالح';
    } else {
      return null;
    }
  }

  String? validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());

    if (!regex.hasMatch(value.trim())) {
      return 'أدخل بريد إلكتروني صالح';
    } else {
      return null;
    }
  }
}
