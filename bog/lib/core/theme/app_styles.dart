import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyle {
  AppTextStyle._();
  static const String _font = 'PP Telegraf';

  static TextStyle bodyText1 = const TextStyle(
    color: AppColors.platinum,
    fontFamily: _font,
    fontWeight: FontWeight.w500,
    fontSize: 16 * 0.90,
  );

  static TextStyle bodyText3 = const TextStyle(
    color: AppColors.platinum,
    fontFamily: _font,
    fontWeight: FontWeight.w500,
    fontSize: 17 * 0.90,
  );

  static TextStyle smallText = const TextStyle(
    color: AppColors.platinum,
    fontFamily: _font,
    fontSize: 10 * 0.90,
  );
  static TextStyle bodyText2 = const TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    fontSize: 15 * 0.90,
  );
  static TextStyle subtitle2 = const TextStyle(
    fontFamily: _font,
    color: AppColors.platinum,
    fontWeight: FontWeight.w500,
    fontSize: 14 * 0.90,
  );
  static TextStyle caption = const TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w500,
    color: AppColors.platinum,
    fontSize: 12 * 0.90,
  );

  static TextStyle tinyBold = const TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600,
    color: AppColors.platinum,
    fontSize: 8 * 0.90,
  );
  static TextStyle caption2 = const TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w500,
    color: AppColors.platinum,
    fontSize: 13 * 0.90,
  );
  static TextStyle subtitle1 = const TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.normal,
    color: AppColors.platinum,
    fontSize: 16 * 0.90,
  );
  static TextStyle headline5 = const TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600,
    color: AppColors.platinum,
    fontSize: 20 * 0.90,
  );
  static TextStyle headline4 = const TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600,
    color: AppColors.platinum,
    fontSize: 18 * 0.90,
  );
  static TextStyle headline6 = const TextStyle(
    fontFamily: _font,
    color: AppColors.platinum,
    fontWeight: FontWeight.w600,
    fontSize: 24 * 0.90,
  );
  static TextStyle mid1 = const TextStyle(
    fontFamily: _font,
    color: AppColors.platinum,
    fontWeight: FontWeight.w600,
    fontSize: 22 * 0.90,
  );
  static TextStyle button = const TextStyle(
    fontSize: 18 * 0.90,
    fontWeight: FontWeight.w700,
    fontFamily: _font,
    color: AppColors.platinum,
  );
  static TextStyle headline2 = const TextStyle(
    fontSize: 34 * 0.90,
    fontWeight: FontWeight.w500,
    color: AppColors.platinum,
    fontFamily: _font,
  );
}
