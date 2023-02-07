import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constrains/app_colors.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Muli",
    // brightness: Brightness.dark,
    bottomNavigationBarTheme: bottomNavigationBarThemeData(),
    primaryColor: kPrimaryColor,
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    buttonTheme: buttonThemeData(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

BottomNavigationBarThemeData bottomNavigationBarThemeData() {
  return const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent

  );
}


ButtonThemeData buttonThemeData() {
  return const ButtonThemeData(
    buttonColor: kPrimaryColor
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: const BorderSide(color: AppColors.blackColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(horizontal: 42, vertical: 10),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: AppColors.blackColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.orange,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w500),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  );
}
