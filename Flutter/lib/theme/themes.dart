export 'package:flutter/material.dart';
export 'package:algo_learn/di/service_locator.dart';
export 'package:algo_learn/routes/route_configurator.dart';
export 'package:get_it/get_it.dart';
export 'package:hive/hive.dart';
export 'package:hive_flutter/hive_flutter.dart';

export 'dimens.dart';
export 'palette.dart';
export 'styles/text_styles.dart';
export 'theme.dart';
//export 'themes/button_themes.dart';
import 'package:flutter/material.dart';

class MyThemes {
  static final primary = Colors.blue;
  static final primaryColor = Colors.blue.shade300;

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColorDark: primaryColor,
    colorScheme: ColorScheme.dark(primary: primary),
    dividerColor: Colors.white,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Color.fromARGB(255, 15, 239, 243),
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(primary: primary),
    dividerColor: Colors.black,
  );
}