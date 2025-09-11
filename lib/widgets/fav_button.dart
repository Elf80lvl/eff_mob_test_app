import 'dart:ui';

import 'package:eff_mob_tes_app/data/const.dart';
import 'package:eff_mob_tes_app/logic/favorites/bloc/favorites_bloc.dart';
import 'package:eff_mob_tes_app/model/character_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavButton extends StatefulWidget {
  final Character character;

  const FavButton({super.key, required this.character});

  @override
  State<FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> with TickerProviderStateMixin {
  late AnimationController _animationCtrl;

  @override
  void initState() {
    super.initState();
    _animationCtrl = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        final isFavorite = state.isFavorite(widget.character.id);

        return ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(999),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: CircleAvatar(
                  backgroundColor: Color(kColorAccent).withValues(alpha: 0.3),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      _animationCtrl.forward();
                      context.read<FavoritesBloc>().add(
                        FavoritesToggle(widget.character.id),
                      );
                    },
                    icon: Icon(
                      isFavorite ? Icons.grade : Icons.grade_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
            .animate(
              controller: _animationCtrl,
              autoPlay: false,
              onComplete: (controller) {
                controller.reset();
              },
            )
            .shake(
              duration: Duration(milliseconds: 300),
              offset: Offset(10, 10),
              curve: Curves.ease,
            );
      },
    );
  }
}
