import 'package:flutter/material.dart';
import 'dark_theme_colors.dart';
import 'light_theme_colors.dart';
import 'my_styles.dart';

class MyTheme {
  static getThemeData({required bool isLight}) {
    return ThemeData(
      // main color (app bar,tabs..etc)

      primaryColor: isLight
          ? LightThemeColors.primaryColor
          : DarkThemeColors.primaryColor,

      brightness: isLight ? Brightness.light : Brightness.dark,
      cardColor:
          isLight ? LightThemeColors.cardColor : DarkThemeColors.cardColor,
      hintColor: isLight
          ? LightThemeColors.hintTextColor
          : DarkThemeColors.hintTextColor,
      // divider color

      dividerColor: isLight
          ? LightThemeColors.dividerColor
          : DarkThemeColors.dividerColor,
      scaffoldBackgroundColor: isLight
          ? LightThemeColors.scaffoldBackgroundColor
          : DarkThemeColors.scaffoldBackgroundColor,

      // progress bar theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: isLight
            ? LightThemeColors.primaryColor
            : DarkThemeColors.primaryColor,
      ),

      // appBar theme
      appBarTheme: MyStyles.getAppBarTheme(isLightTheme: isLight),

      // elevated button theme
      elevatedButtonTheme:
          MyStyles.getElevatedButtonTheme(isLightTheme: isLight),

      // text theme
      textTheme: MyStyles.getTextTheme(isLightTheme: isLight),

      // chip theme
      chipTheme: MyStyles.getChipTheme(isLightTheme: isLight),

      // icon theme
      iconTheme: MyStyles.getIconTheme(isLightTheme: isLight),
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(
              secondary: isLight
                  ? LightThemeColors.accentColor
                  : DarkThemeColors.accentColor)
          .copyWith(
              background: isLight
                  ? LightThemeColors.backgroundColor
                  : DarkThemeColors.backgroundColor),
    );
  }

  // static changeTheme() {
  //   // bool isLightTheme = MySharedPref.getThemeIsLight();
  //   // MySharedPref.setThemeIsLight(!isLightTheme);
  //   // Get.changeThemeMode(!isLightTheme ? ThemeMode.light : ThemeMode.dark);
  // }

  // bool get getThemeIsLight => MySharedPref.getThemeIsLight();
}
