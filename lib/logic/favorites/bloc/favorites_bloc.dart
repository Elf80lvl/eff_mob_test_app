import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eff_mob_tes_app/services/favorites_keeper.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesKeeper _favoritesKeeper;

  FavoritesBloc(this._favoritesKeeper) : super(const FavoritesState([])) {
    on<FavoritesInitial>(_onInitial);
    on<FavoritesToggle>(_onToggle);
  }

  Future<void> _onInitial(
    FavoritesInitial event,
    Emitter<FavoritesState> emit,
  ) async {
    final favorites = _favoritesKeeper.getFavorites();
    emit(FavoritesState(favorites));
  }

  Future<void> _onToggle(
    FavoritesToggle event,
    Emitter<FavoritesState> emit,
  ) async {
    final characterId = event.characterId.toString();
    final favorites = List<String>.from(state.favoriteIds);

    if (favorites.contains(characterId)) {
      await _favoritesKeeper.removeFromFavorites(characterId);
      favorites.remove(characterId);
    } else {
      await _favoritesKeeper.addToFavorites(characterId);
      favorites.add(characterId);
    }

    emit(FavoritesState(favorites));
  }
}
