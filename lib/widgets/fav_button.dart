import 'package:eff_mob_tes_app/data/const.dart';
import 'package:eff_mob_tes_app/logic/favorites/bloc/favorites_bloc.dart';
import 'package:eff_mob_tes_app/model/character_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavButton extends StatelessWidget {
  final Character character;

  const FavButton({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        final isFavorite = state.isFavorite(character.id);

        return CircleAvatar(
          backgroundColor: Color(kColorAccent).withValues(alpha: 0.3),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              context.read<FavoritesBloc>().add(FavoritesToggle(character.id));
            },
            icon: Icon(
              isFavorite ? Icons.grade : Icons.grade_outlined,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
