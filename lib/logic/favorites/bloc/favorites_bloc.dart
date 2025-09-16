import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eff_mob_tes_app/services/favorites_keeper.dart';
import 'package:eff_mob_tes_app/model/character_model.dart';
import 'package:eff_mob_tes_app/repo/characters_api.dart';
import 'package:eff_mob_tes_app/services/data_cache.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesKeeper _favoritesKeeper;
  final DataCache _dataCache;

  FavoritesBloc(this._favoritesKeeper)
    : _dataCache = DataCache(),
      super(const FavoritesStateInitial()) {
    on<FavoritesInitial>(_onInitial);
    on<FavoritesToggle>(_onToggle);
    on<FavoritesLoadCharacters>(_onLoadCharacters);
  }

  Future<void> _onInitial(
    FavoritesInitial event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesStateLoading());
    final favorites = _favoritesKeeper.getFavorites();
    add(FavoritesLoadCharacters(favorites));
  }

  Future<void> _onToggle(
    FavoritesToggle event,
    Emitter<FavoritesState> emit,
  ) async {
    final characterId = event.characterId.toString();
    final currentFavorites = _favoritesKeeper.getFavorites();

    if (currentFavorites.contains(characterId)) {
      await _favoritesKeeper.removeFromFavorites(characterId);
    } else {
      await _favoritesKeeper.addToFavorites(characterId);
    }

    // Перезагружаем все избранные персонажи
    final updatedFavorites = _favoritesKeeper.getFavorites();
    add(FavoritesLoadCharacters(updatedFavorites));
  }

  Future<void> _onLoadCharacters(
    FavoritesLoadCharacters event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesStateLoading());
    try {
      final List<Character> allCharacters = [];

      // проверяем кэш для каждого ID
      for (String id in event.favoriteIds) {
        Character? character = await _getCharacterFromCache(int.parse(id));
        if (character != null) {
          allCharacters.add(character);
          continue;
        }

        // нет в кэше, получаем с API
        try {
          final response = await CharactersApi.getCharacterById(id);
          if (response != null) {
            final character = Character.fromJson(response.data);
            allCharacters.add(character);
            // Сохраняем в кэш
            await _cacheCharacter(character);
          }
        } catch (e) {
          log('Error getting character from network $id: $e');
        }
      }

      emit(
        FavoritesStateLoaded(
          favoriteIds: event.favoriteIds,
          characters: allCharacters,
        ),
      );
    } catch (e) {
      emit(FavoritesStateError(e.toString()));
    }
  }

  Future<Character?> _getCharacterFromCache(int id) async {
    // идем по всем страницам в кэше ищем персонажа с нужным ID
    int page = 1;
    while (true) {
      final characters = await _dataCache.getCharacters(page);
      if (characters == null || characters.isEmpty) break;

      for (var character in characters) {
        if (character.id == id) {
          return character;
        }
      }
      page++;
    }
    return null;
  }

  Future<void> _cacheCharacter(Character character) async {
    final List<Character> characters = [character];
    await _dataCache.saveCharacters(character.id, characters);
  }
}
