import 'package:eff_mob_tes_app/logic/home_page/bloc/home_bloc_bloc.dart';
import 'package:eff_mob_tes_app/services/favorites_keeper.dart';
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
  late Future<FavoritesKeeper> _keeperFuture;

  @override
  void initState() {
    super.initState();
    _keeperFuture = FavoritesKeeper.create();
    context.read<HomeBlocBloc>().add(HomeBlocGetDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeBlocBloc, HomeBlocState>(
        builder: (context, state) {
          if (state is HomeBlocLoading) {
            return const Center(child: LoadingIndicator());
          }

          if (state is HomeBlocLoaded) {
            return FutureBuilder<FavoritesKeeper>(
              future: _keeperFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: LoadingIndicator());
                }

                final keeper = snapshot.data!;
                final favoriteIds = keeper.getFavorites();
                final characters = state.characters;
                final favoriteCharacters = characters
                    .where((char) => favoriteIds.contains(char.id.toString()))
                    .toList();

                if (favoriteCharacters.isEmpty) {
                  return const Center(child: NoFavoritesWidget());
                }

                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 800),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ScreenHelper.isMobile(context) ? 2 : 4,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      itemCount: favoriteCharacters.length,
                      itemBuilder: (context, index) {
                        final character = favoriteCharacters[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: CharacterCard(character: character),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }

          if (state is HomeBlocError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          return const Center(child: Text('error'));
        },
      ),
    );
  }
}
