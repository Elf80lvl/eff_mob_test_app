import 'dart:ui';

import 'package:eff_mob_tes_app/data/const.dart';
import 'package:eff_mob_tes_app/model/character_model.dart';
import 'package:eff_mob_tes_app/services/screen_helper.dart';
import 'package:eff_mob_tes_app/widgets/button_close_window.dart';
import 'package:eff_mob_tes_app/widgets/fav_button.dart';
import 'package:eff_mob_tes_app/widgets/info_big_card.dart';
import 'package:flutter/material.dart';

class CharacterCardContent extends StatelessWidget {
  final Character character;
  const CharacterCardContent({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800,
      width: ScreenHelper.isMobile(context)
          ? ScreenHelper.getScreenWidth(context)
          : kDialogMaxWidth,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: buildBorderRadius(context),
            child: Image.network(
              character.image,
              width: kDialogMaxWidth,
              // width: ScreenHelper.isMobile(context)
              //     ? double.infinity
              //     : kDialogMaxWidth,
              height: kDialogMaxWidth,
              fit: BoxFit.cover,
            ),
          ),

          //*bg darker with gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.zero,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.5),
                    Colors.black.withValues(alpha: 0.9),
                  ],
                ),
              ),
            ),
          ),

          //*handler
          if (ScreenHelper.isMobile(context))
            Positioned.fill(
              top: 8,
              // right: 0,
              // left: 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 3,
                  width: 50,
                  decoration: BoxDecoration(
                    // color: Colors.black.withValues(alpha: 0.5),
                    color: Color(kColorAccent),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
            ),

          //Close button and fav
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsetsGeometry.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FavButton(character: character),
                  if (!ScreenHelper.isMobile(context))
                    const SizedBox(width: 16),
                  if (!ScreenHelper.isMobile(context)) ButtonCloseWindow(),
                ],
              ),
            ),
          ),

          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: InfoBigCard(character: character),
            ),
          ),
        ],
      ),
    );
  }

  BorderRadius buildBorderRadius(BuildContext context) {
    return BorderRadius.only(
      topLeft: Radius.circular(ScreenHelper.isMobile(context) ? 20 : 0),
      topRight: Radius.circular(ScreenHelper.isMobile(context) ? 20 : 0),
      bottomLeft: Radius.circular(ScreenHelper.isMobile(context) ? 0 : 0),
      bottomRight: Radius.circular(ScreenHelper.isMobile(context) ? 0 : 0),
    );
  }
}

class InfoMiniCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const InfoMiniCard({super.key, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: Color(kColorAccent).withValues(alpha: 0.5),
            // color: Colors.black.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Color(kColorAccent).withValues(alpha: 0.9),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (subtitle != null) TextSecondaryContent(text: subtitle!),
              // const SizedBox(height: 4),
              TextPrimaryContent(
                text: (title != null && title!.isNotEmpty) ? title! : 'Unknown',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextPrimaryContent extends StatelessWidget {
  const TextPrimaryContent({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        // color: Color(kColorAccent),
        color: const Color.fromARGB(255, 190, 243, 185),
      ),
    );
  }
}

class TextSecondaryContent extends StatelessWidget {
  final String text;
  const TextSecondaryContent({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        // color: Theme.of(context).textTheme.bodySmall?.color,
        // color: Color(kColorAccent).withValues(alpha: 0.7),
        color: const Color.fromARGB(255, 190, 243, 185),
        // fontWeight: FontWeight.bold,
      ),
    );
  }
}
