import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eff_mob_tes_app/model/character_model.dart';
import 'package:eff_mob_tes_app/repo/characters_repository.dart';
import 'package:eff_mob_tes_app/services/data_cache.dart';
import 'package:equatable/equatable.dart';
import 'dart:developer';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBlocBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  final CharactersRepository _charactersRepository;
  final DataCache _cacheService;

  HomeBlocBloc({
    required CharactersRepository charactersRepository,
    required DataCache cacheService,
  }) : _charactersRepository = charactersRepository,
       _cacheService = cacheService,
       super(HomeBlocInitial()) {
    on<HomeBlocGetDataEvent>((event, emit) => _onGetData(event, emit));
    on<HomeBlocClearCacheEvent>((event, emit) => _onClearCache(event, emit));
  }

  Future<void> _onGetData(
    HomeBlocGetDataEvent event,
    Emitter<HomeBlocState> emit,
  ) async {
    if (state is! HomeBlocLoaded) {
      emit(HomeBlocLoading());
    }

    List<Character> oldCharacters = [];
    if (state is HomeBlocLoaded) {
      oldCharacters = (state as HomeBlocLoaded).characters;
    }

    int currentPage = event.page;

    try {
      List<Character>? cachedCharacters = await _cacheService.getCharacters(
        currentPage,
      );
      List<Character> pageCharacters;
      bool hasMore = true;

      //есть ли кэш
      if (cachedCharacters != null && cachedCharacters.isNotEmpty) {
        pageCharacters = cachedCharacters;
        log('Got characters from cache');
        hasMore = true;
        //нет кэша, загружаем из сети
      } else {
        final response = await _charactersRepository.getCharacters(
          page: currentPage,
        );
        final characterModel = CharacterModel.fromJson(response.data);
        pageCharacters = characterModel.results;
        hasMore = characterModel.info.next != null;
        //сохраняем в кэш
        await _cacheService.saveCharacters(currentPage, pageCharacters);
        log('Characters saved to cache');
      }
      //объединяем старых и новых персонажей в список, убираем дубликаты
      final newCharacters = List<Character>.from(oldCharacters)
        ..addAll(pageCharacters);
      final uniqueCharacters = newCharacters.toSet().toList();

      emit(
        HomeBlocLoaded(
          characters: uniqueCharacters,
          page: currentPage,
          hasMore: hasMore,
        ),
      );
    } catch (e) {
      emit(HomeBlocError(message: e.toString()));
    }
  }

  Future<void> _onClearCache(
    HomeBlocClearCacheEvent event,
    Emitter<HomeBlocState> emit,
  ) async {
    emit(HomeBlocLoading());
    //очищаем кэш
    await _cacheService.clearCache();
    log('Cache cleared');
    //загружаем заново первую страницу
    add(HomeBlocGetDataEvent(page: 1));
  }
}
