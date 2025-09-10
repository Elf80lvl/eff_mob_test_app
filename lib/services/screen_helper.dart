import 'package:eff_mob_tes_app/data/const.dart';
import 'package:flutter/material.dart';

class ScreenHelper {
  static bool isMobile(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < kMobileBreakpoint;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
