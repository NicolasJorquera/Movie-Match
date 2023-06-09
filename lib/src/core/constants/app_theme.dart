import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData dark = ThemeData(
    appBarTheme: const AppBarTheme(
      elevation: 0,
      foregroundColor: Colors.white,
      centerTitle: true,
      color: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    scaffoldBackgroundColor: Colors.black,
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.white,
      labelStyle: AppTextStyles.labelStyle,
      unselectedLabelStyle: AppTextStyles.unselectedLabelStyle,
    ),
  );
}
