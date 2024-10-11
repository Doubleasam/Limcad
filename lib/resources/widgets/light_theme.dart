import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/size_util.dart';


ThemeData lightTheme() {
  return ThemeData(
      useMaterial3: false,
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              textStyle: MaterialStateProperty.resolveWith((states) {
                return const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: "Josefin Sans",
                    color: CustomColors.limcadPrimary);
              }),
              elevation: MaterialStateProperty.resolveWith((states) => 0),
              minimumSize: MaterialStateProperty.resolveWith(
                      (states) => const Size(double.infinity, 48)),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              foregroundColor:
              MaterialStateProperty.all(CustomColors.limcadPrimary),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(
                  color: CustomColors.black500,
                  width: 1,
                ),
              )))
      ),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: CustomColors.rpLighterGreen,
      secondaryHeaderColor: CustomColors.rpLighterGreen,
      iconTheme: const IconThemeData(color: CustomColors.rpLighterGreen),
      fontFamily: "Josefin Sans",
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedIconTheme:
        IconThemeData(color: CustomColors.rpLighterGreen),
        selectedItemColor: CustomColors.rpLighterGreen,
        unselectedItemColor: CustomColors.unselectedBottomNavColor,
        showUnselectedLabels: true,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: CustomColors.rpLighterGreen,
          secondary: CustomColors.rpLighterGreen),
      appBarTheme: const AppBarTheme(
          elevation: 2,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          iconTheme: IconThemeData(color: CustomColors.notificationIcon),
          systemOverlayStyle: SystemUiOverlayStyle.dark),
      radioTheme: RadioThemeData(
          fillColor: MaterialStateColor.resolveWith(
                  (states) => CustomColors.limcadPrimary)),
      elevatedButtonTheme:
      ElevatedButtonThemeData(style: elevatedButtonStyle()),
      textButtonTheme: TextButtonThemeData(style: textButtonStyle()),
      // textSelectionTheme: const TextSelectionThemeData(
      //   selectionColor: Colors.white, // Color when not empty
      //   cursorColor: Colors.white,
      //   selectionHandleColor: Colors.white// Color when not empty
      // ),
      inputDecorationTheme: InputDecorationTheme(
        //focusColor: CustomColors.fillColor,

        //fillColor: CustomColors.fillColor, // Color when empty
        filled: true,

        floatingLabelStyle: const TextStyle(
          color: Colors.black,
        ),
        contentPadding: const EdgeInsets.only(left: 50, right: 5),
        labelStyle:
        const TextStyle(color: CustomColors.labelColor, fontSize: 15),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(width: 1, color: CustomColors.red400)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(width: 1, color: CustomColors.red400)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(width: 1, color: Color(0xffEBE8E8))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(width: 1, color: Color(0xffEBE8E8))),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(width: 1, color: Color(0xffEBE8E8))),
      ),
      textTheme: const TextTheme(
          headlineSmall: TextStyle(
              color: CustomColors.limcadPrimary,
              fontWeight: FontWeight.w500,
              fontSize: 18),
          headlineLarge: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 22,
          ),
          headlineMedium: TextStyle(
              fontWeight: FontWeight.w800, fontSize: 20, color: Colors.black),
          bodyLarge: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: CustomColors.bodyLargecolor),
          bodyMedium: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.black,
              height: 1.3),
          titleMedium: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: CustomColors.subtitle1Color)));
}

ButtonStyle elevatedButtonStyle() {
  return ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        return Colors.white;
      }),
      textStyle: MaterialStateProperty.resolveWith((states) {
        return const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, fontFamily: "Josefin Sans");
      }),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
        } else {
          return CustomColors.limcadPrimary;
        }
      }),
      shape: MaterialStateProperty.resolveWith((states) {
        return  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30));
      }),


      elevation: MaterialStateProperty.resolveWith((states) => 0),
      minimumSize: MaterialStateProperty.resolveWith(
              (states) => const Size(double.infinity, 48)));
}

ButtonStyle textButtonStyle() {
  return ButtonStyle(
    foregroundColor: MaterialStateProperty.all(CustomColors.rpLighterGreen),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    elevation: MaterialStateProperty.resolveWith((states) => 0),
    // minimumSize: MaterialStateProperty.resolveWith(
    //     (states) => Size(double.infinity, 42.h))
  );
}

ButtonStyle roundedButtonStyle({required Color outlineColor}) {
  return ElevatedButton.styleFrom(
    minimumSize: Size(154.w, 49.h),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    side: BorderSide(color: outlineColor),
  );
}

ButtonStyle roundedButtonStyleNoBorder() {
  return ElevatedButton.styleFrom(
    minimumSize: Size(154.w, 49.h),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
  );
}

ButtonStyle whatsappSupportButton({required Color outlineColor}) {
  return OutlinedButton.styleFrom(
    minimumSize: const Size.fromHeight(49),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    side: BorderSide(color: outlineColor),
  );
}

ButtonStyle outlineButtonStyle(
    {bool roundedCorners = false,
      double roundRadius = 18,
      Color borderColor = CustomColors.rpLighterGreen}) {
  return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.white),
      foregroundColor:
      MaterialStateProperty.all(CustomColors.rpLighterGreen),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(roundRadius),
        side: BorderSide(color: borderColor),
      )));
}
