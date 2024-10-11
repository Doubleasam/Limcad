import 'package:flutter/material.dart';

class SizeUtil {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeUtil.screenHeight;

  return (inputHeight / 800) * screenHeight;
}

double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeUtil.screenWidth;

  return (inputWidth / 360) * screenWidth;
}

extension SizeUtilExtension on num {
  double get w => (this / 360) * SizeUtil.screenWidth;

  double get h => (this / 800) * SizeUtil.screenHeight;
}
