import 'package:bloc/bloc.dart';
import 'package:eff_mob_tes_app/model/character_model.dart';
import 'package:eff_mob_tes_app/repo/netw.dart';
import 'package:eff_mob_tes_app/services/data_cache.dart';
import 'package:equatable/equatable.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBlocBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeBlocBloc() : super(HomeBlocInitial()) {
    on<HomeBlocGetDataEvent>((event, emit) async {
      // Эмитим загрузку если нет данных загруженных
      if (state is! HomeBlocLoaded) {
        emit(HomeBlocLoading());
      }

      // сохраняем предыдущие данные, если они есть
      List<Character> oldCharacters = [];
      if (state is HomeBlocLoaded) {
        oldCharacters = (state as HomeBlocLoaded).characters;
      }

      int currentPage = event.page;
      final cacheService = DataCache();

      try {
        // Проверяем есть ли кэш для текущей страницы
        List<Character>? cachedCharacters = await cacheService.getCharacters(
          currentPage,
        );
        List<Character> pageCharacters;
        bool hasMore = true;

        //если есть в кэше берем оттуда
        if (cachedCharacters != null && cachedCharacters.isNotEmpty) {
          pageCharacters = cachedCharacters;

          hasMore = true;
          //берем новых персонажей из сети
        } else {
          final response = await Netw.getCharacters(page: currentPage);
          final data = response.data;
          final characterModel = CharacterModel.fromJson(data);
          pageCharacters = characterModel.results;
          hasMore = characterModel.info.next != null;
          // Сохраняем в кэш
          await cacheService.saveCharacters(currentPage, pageCharacters);
        }

        // Добавляем новых персонажей к существующим
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
    });
  }
}
