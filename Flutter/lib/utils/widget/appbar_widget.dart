import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:algo_learn/theme/themes.dart';
import 'package:algo_learn/utils/me_util/user_preferences.dart';

AppBar buildAppBar(BuildContext context) {
  // final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final icon = Icons.exit_to_app;

  return AppBar(
    leading: BackButton(),
    backgroundColor: Palette.accentColor,
    elevation: 0,
    actions: [
      IconButton(
        icon: Icon(icon),
        onPressed: () {
          // UserPreferences.clearUser();
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/', (Route<dynamic> route) => false);
        },
      ),
    ],
  );
}