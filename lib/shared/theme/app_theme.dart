import 'package:flutter/material.dart';

/// ### App Theme
/// This class is used to define the app theme.
///
/// #### Methods:
/// - [getTheme]: Returns the app theme.
///
/// #### Author:
/// Gonzalo Quedena
class AppTheme {
  ThemeData getTheme() {
    const seedColor = Colors.lightGreen;

    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: seedColor,
      listTileTheme: const ListTileThemeData(
        iconColor: seedColor,
      ),
    );
  }
}
