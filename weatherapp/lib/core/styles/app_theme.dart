import 'package:flutter/material.dart';
import 'package:weatherapp/core/styles/app_color.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.Color1,
    scaffoldBackgroundColor: AppColors.Color3,
    appBarTheme: const AppBarTheme(
      color: AppColors.Color1basic,
      iconTheme: IconThemeData(color: AppColors.Color3),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.Color4,
        fontFamily: 'Helvetica',
        fontSize: 50,
        fontWeight: FontWeight.w800,
        fontStyle: FontStyle.italic,
      ),
      labelLarge: TextStyle(
        color: AppColors.Color3,
        fontFamily: 'Helvetica',
        fontSize: 30,
        fontWeight: FontWeight.w800,
        fontStyle: FontStyle.normal,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.Color1,
        foregroundColor: AppColors.Color3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
