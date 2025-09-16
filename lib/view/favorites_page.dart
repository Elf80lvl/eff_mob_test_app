import 'package:eff_mob_tes_app/logic/favorites/bloc/favorites_bloc.dart';
import 'package:eff_mob_tes_app/services/screen_helper.dart';
import 'package:eff_mob_tes_app/widgets/character_card.dart';
import 'package:eff_mob_tes_app/widgets/loading_indicator.dart';
import 'package:eff_mob_tes_app/widgets/no_favorites_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesBloc>().add(FavoritesInitial());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesStateLoading) {
            return const Center(child: LoadingIndicator());
          }

          if (state is FavoritesStateLoaded) {
            if (state.characters.isEmpty) {
              return const Center(child: NoFavoritesWidget());
            }

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ScreenHelper.isMobile(context) ? 2 : 4,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  itemCount: state.characters.length,
                  itemBuilder: (context, index) {
                    final character = state.characters[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CharacterCard(character: character),
                    );
                  },
                ),
              ),
            );
          }

          if (state is FavoritesStateError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          return Center(child: LoadingIndicator());
        },
      ),
    );
  }
}
