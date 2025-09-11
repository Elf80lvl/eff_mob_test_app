import 'dart:ui';

import 'package:eff_mob_tes_app/data/const.dart';
import 'package:eff_mob_tes_app/model/character_model.dart';
import 'package:eff_mob_tes_app/services/screen_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class InfoBigCard extends StatelessWidget {
  final Character character;
  const InfoBigCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(kColorAccent).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(width: 2, color: Color(kColorAccent)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: AnimateList(
                interval: 200.ms,
                effects: [FadeEffect(duration: 300.ms)],
                children: [
                  RowWithTextInBigInfo(
                    leftText: 'Name',
                    rightText: character.name,
                  ),
                  RowWithTextInBigInfo(
                    leftText: 'Gender',
                    rightText: character.gender,
                  ),
                  RowWithTextInBigInfo(
                    leftText: 'Location',
                    rightText: character.location.name,
                  ),
                  RowWithTextInBigInfo(
                    leftText: 'Species',
                    rightText: character.species,
                  ),

                  RowWithTextInBigInfo(
                    leftText: 'Type',
                    rightText: character.type,
                  ),
                  RowWithTextInBigInfo(
                    leftText: 'Status',
                    rightText: character.status,
                  ),

                  // RowWithTextInBigInfo(
                  //   leftText: 'Gender',
                  //   rightText: character.origin.name,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RowWithTextInBigInfo extends StatelessWidget {
  final String leftText;
  final String? rightText;
  const RowWithTextInBigInfo({
    super.key,
    required this.leftText,
    this.rightText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leftText,
          style: TextStyle(
            color: Color(kColorAccent),
            fontSize: ScreenHelper.isMobile(context) ? 14 : 16,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 5),
            child: Container(
              height: 10,
              // width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(kColorAccent),
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
          ),
        ),
        (rightText != null && rightText!.isNotEmpty)
            ? Text(
                rightText!,
                style: TextStyle(
                  color: Color(kColorAccent),
                  fontSize: ScreenHelper.isMobile(context) ? 14 : 16,
                ),
              )
            : Text(
                '*Unknown*',
                style: TextStyle(
                  color: Color(kColorAccent),
                  fontSize: ScreenHelper.isMobile(context) ? 14 : 16,
                ),
              ),
      ],
    );
  }
}
