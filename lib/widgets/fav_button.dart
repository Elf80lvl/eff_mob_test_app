import 'package:eff_mob_tes_app/data/const.dart';
import 'package:flutter/material.dart';

class FavButton extends StatelessWidget {
  const FavButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Color(kColorAccent).withValues(alpha: 0.3),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
        icon: Icon(
          Icons.grade_outlined,
          // size: 20,
          // color: Color(kColorAccent),
          color: Colors.white,
        ),
      ),
    );
  }
}
