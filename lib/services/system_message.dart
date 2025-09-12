import 'package:eff_mob_tes_app/data/const.dart';
import 'package:flutter/material.dart';

class SystemMessage {
  static void showBottomMessage({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color(kColorAccent),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        width: 300,
        behavior: SnackBarBehavior.floating,
        content: Text(message),
      ),
    );
  }
}
