import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_styles.dart';

class AppThemes {
  AppThemes._();

  static const double appPaddingVal = 16;

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    platform: TargetPlatform.iOS,
    fontFamily: 'PP Telegraf',
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.background,
      foregroundColor: Colors.black,
      titleTextStyle: AppTextStyle.headline4.copyWith(
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(AppColors.primary),
    ),
    tabBarTheme: TabBarTheme(
      labelStyle: AppTextStyle.subtitle1.copyWith(
        fontWeight: FontWeight.w600,
      ),
      labelColor: AppColors.primary,
      labelPadding:
          const EdgeInsets.symmetric(horizontal: AppThemes.appPaddingVal),
      unselectedLabelColor: AppColors.onyx,
      unselectedLabelStyle: AppTextStyle.subtitle1.copyWith(
        fontWeight: FontWeight.w500,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: AppTextStyle.bodyText1,
      bodyMedium: AppTextStyle.bodyText2,
      titleSmall: AppTextStyle.subtitle2,
      bodySmall: AppTextStyle.caption,
      titleMedium: AppTextStyle.subtitle1,
      headlineSmall: AppTextStyle.headline5,
      titleLarge: AppTextStyle.headline6,
      labelLarge: AppTextStyle.button,
      headlineMedium: AppTextStyle.headline4,
    ),
    timePickerTheme: const TimePickerThemeData(
      backgroundColor: Colors.white,
    ),
    colorScheme: const ColorScheme(
      primary: AppColors.primary,
      secondary: AppColors.bostonUniRed,
      surface: Color(0xFFC4C4C4),
      background: Color(0xFFE3E5E5),
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: AppColors.bostonUniRed,
      onSurface: Colors.white,
      onBackground: AppColors.bostonUniRed,
      onError: AppColors.bostonUniRed,
      brightness: Brightness.dark,
    ),
  );
}
