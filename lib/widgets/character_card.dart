import 'dart:ui';

import 'package:eff_mob_tes_app/data/const.dart';
import 'package:eff_mob_tes_app/model/character_model.dart';
import 'package:eff_mob_tes_app/services/screen_helper.dart';
import 'package:eff_mob_tes_app/widgets/character_card_content.dart';
import 'package:eff_mob_tes_app/widgets/fav_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CharacterCard extends StatefulWidget {
  final Character character;
  const CharacterCard({super.key, required this.character});

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GestureDetector(
        onTap: () {
          !ScreenHelper.isMobile(context)
              ? showDialog(
                  // barrierColor: Colors.black.withValues(alpha: 0.8),
                  // barrierColor: Color(kColorAccent).withValues(alpha: 0.3),
                  context: context,
                  builder: (context) {
                    return Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: kMobileBreakpoint,
                        ),
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Dialog(
                              // shadowColor: Colors.black,
                              // backgroundColor: Colors.black,
                              child: CharacterCardContent(
                                character: widget.character,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return CharacterCardContent(character: widget.character);
                  },
                );
        },
        child: MouseRegion(
          onHover: (event) {
            setState(() {
              if (!ScreenHelper.isMobile(context)) _isHover = true;
            });
          },
          onExit: (event) {
            setState(() {
              if (!ScreenHelper.isMobile(context)) _isHover = false;
            });
          },
          cursor: _isHover ? SystemMouseCursors.click : MouseCursor.defer,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            child: Stack(
              children: [
                Image.network(
                  widget.character.image,
                  // height: 100,
                  // width: 100,
                  fit: BoxFit.cover,
                ),
                //*name
                _isHover
                    ? SizedBox()
                    : Positioned(
                            bottom: 3,
                            left: 3,
                            right: 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green.withValues(alpha: 0.6),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 5,
                                    ),
                                    child: SizedBox(
                                      // width: ScreenHelper.isMobile(context)
                                      //     ? ScreenHelper.getScreenHeight(context) / 3
                                      //     : 155,
                                      child: Center(
                                        child: Text(
                                          widget.character.name,
                                          softWrap: true,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                ScreenHelper.isMobile(context)
                                                ? 14
                                                : 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 300.ms)
                          .slideY(begin: 0.5, end: 0, duration: 300.ms),

                if (_isHover)
                  Positioned.fill(
                    child: ClipRRect(
                      // borderRadius: BorderRadius.circular(2),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                        child: Container(
                          // color: Color(kColorAccent).withValues(alpha: 0.2),
                          color: Colors.black.withValues(alpha: 0.5),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  widget.character.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  widget.character.status,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenHelper.isMobile(context)
                                        ? 14
                                        : 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.character.species,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenHelper.isMobile(context)
                                        ? 14
                                        : 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).animate().fadeIn(duration: 500.ms),
                      ),
                    ),
                  ),

                //*кнопка избранное
                Positioned(
                  top: 6,
                  right: 6,
                  child: FavButton(character: widget.character),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
