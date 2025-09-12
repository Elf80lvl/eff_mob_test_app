
<p align="center">
<img width="600" height="233" alt="rick-welcome" src="https://github.com/user-attachments/assets/47ff6eb7-2fb7-4604-87e1-7a94cef798d7" />
</p>

## Описание
Приложение показывает список персонажей из мультсериала используя публичный API.

Реализованные функции:
* Загрузка списка персонажей, подгрузка новых персонажей при скролле
* Отображение списка персонажей в виде карточек
* Кеширование списка с помощью базы данных для офлайн доступа
* Список избранных персонажей, добавление и удаление
* Переключение между светлой и темной темы приложения
* Использование state менеджера (bloc) 
* Чистая архитектура и легкая поддержка кодовой базы
* Анимации для улучшения обратной связи и стиля приложения
* Современный дизайн, цвета подходящие под стиль мультсериала
* NavBar и AppBar для переключения между экранами
* Адаптивная верстка - desktop, mobile

## Скриншоты
<p align="center">
<img width="691" height="375" alt="rick-screens" src="https://github.com/user-attachments/assets/4415aeb5-ae18-4b08-a993-f85928d84bb1" />
</p>

## Видеодемо

https://github.com/user-attachments/assets/b9152bf9-859e-4962-8953-f752568aac28


## Библиотеки
В приложении использованы следующие библиотеки:
*  dio: доступ к API
*  flutter_bloc: state manager
*  equatable: сравнение объектов, использование с state manager
*  hive_flutter: база данных для кэширования загруженных персонажей
*  loading_animation_widget: виджеты загрузки экрана, более продвинутые варианты CircularProgressIndicator
*  flutter_animate: различные анимации при загрузке или взаимодествия с виджетами
*  shared_preferences: сохранение короткого списка ID избранных персонажей

## Внешний вид
* 1 экран: список всех загруженных персонажей
* 2 экран: список избранных персонажей
* 3 экран: окно настроек приложения

## Архитектура
Используется bloc state management для поддержания чистой архитектуры, разделения бизнесс логики.

* /lib/data:  хранение общих данных, констант
* /lib/logic: бизнесс логика приложения, взаимодействие презентационного слоя, данных, репозиторий сетевых и локальных
* /lib/model: классы для более удобной работы с сетью, json
* /lib/repo: доступ к данным
* /lib/services: различные классы-прослойки для манипуляции с данными и виджетами
* /lib/view: пользовательский интерфейс приложения 
* /lib/widgets: переиспользуемые кастомные виджеты

## Как работает
Пользовательсий сценарий и основная логика работы приложения:

<b>1. Пользователь запускает приложение:</b>
* загрузка списка избранных персонажей (lib/main.dart)
* определение темы устройства пользователя и установка соответсвующей темы (lib/main.dart)
* загрузка главного экрана (lib/view/home_page.dart) 
* загрузка первой страницы персонажей по REST API (lib/logic/home_bloc_bloc.dart)

<b>2. Пользователь скроллит список персонажей вниз</b>
* при достижении конца списка происходит проверка наличия следующей страницы в API, загрузка, добавление к общему списку, кэширование.

загрузка следующей страницы в соответсвии с API:
```
    "next": "https://rickandmortyapi.com/api/character/?page=2"
```

Триггер загрузки происходит с помощью ScrollController списка:
``` 
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (state is HomeBlocLoaded && state.hasMore) {
        bloc.add(HomeBlocGetDataEvent(page: state.page + 1));
      }
    }
```

кэширование в базе данных для офлайн доступа (lib/services/data_cache.dart):
```
    box.put('page_$page', characters.map((e) => e.toJson()).toList());
```

добавление новых персонажей к старым без дубликатов (lib/logic/home_page/bloc/home_bloc_bloc/dart):
```
    final newCharacters = List<Character>.from(oldCharacters)..addAll(pageCharacters);
    final uniqueCharacters = newCharacters.toSet().toList();
```

<b>3. Пользователь добавляет персонажа в избранное при нажатии на кнопку FavButton</b>
```
    if (!favorites.contains(characterId)) {
      favorites.add(characterId);
      return await _prefs.setStringList(_key, favorites);
    }
```
_Вмеcто того, чтобы добавлять объектов персонажей, принято решение сохранять ID, так как кеширование происходит автоматически в любом случае, так избежим добавление дубликатных данных_


<b>4. Пользователь переходит на страницу избранных персонажей</b>
* загрузка списка персонажей, ID которых соотвествуют списку ID избранных (lib/view/favorites_page.dart):
```
    final favoriteIds = keeper.getFavorites();
    final characters = state.characters;
    final favoriteCharacters = characters.where((char) => favoriteIds.contains(char.id.toString())).toList();
```

* При нажатии на кнопку избранное на странице избранных произойдет удаление персонажа из избранных (lib/services/favorites_keeper.dart):
  ```
  Future<bool> removeFromFavorites(String characterId) async {
    final favorites = getFavorites();
    if (favorites.contains(characterId)) {
      favorites.remove(characterId);
      return await _prefs.setStringList(_key, favorites);
    }
    return false;
  }
  ```

<b>5. Пользователь переходит на страницу настроек</b>
* При смене темы приложения, происходит перключение на темную если была светлая и наоборот (lib/logic/theme/bloc/theme_bloc.dart):
```
     on<ThemeSwitchThemeEvent>((event, emit) {
      emit(ThemeWithDataState(isDark: !state.isDark));
    });
```

* При нажатии на удаление кэша произодет удаление сохраненных песронажей из базы данных:
```
    final box = await Hive.openBox(boxName);
    await box.clear();
```

## Тестирование
Тестирование происходило:
* web: https://elf80lvl.github.io/rick/
* android physical device (Android 13) 




