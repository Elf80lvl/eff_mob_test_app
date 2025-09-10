import 'package:eff_mob_tes_app/data/const.dart';
import 'package:flutter/material.dart';

class ButtonCloseWindow extends StatelessWidget {
  const ButtonCloseWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Color(kColorAccent).withValues(alpha: 0.3),
      child: IconButton(
        icon: Icon(Icons.close, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
