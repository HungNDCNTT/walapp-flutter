import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSize {
  static const double figmaWidth = 375;
  static const double figmaHeight = 812;

  double get height => Get.size.height;

  double get width => Get.size.width;

  bool isSmallScreen() {
    if (width < 350) {
      return true;
    } else
      return false;
  }

  bool isIpad(BuildContext context) {
    if (MediaQuery.of(context).size.shortestSide < 550) {
      return false;
    }
    return true;
  }

  double getHeight(double size) {
    return size * (height / figmaHeight);
  }

  double getWidth(double size) {
    return size * (width / figmaWidth);
  }
}
