import 'package:eff_mob_tes_app/data/themes.dart';
import 'package:eff_mob_tes_app/logic/favorites/bloc/favorites_bloc.dart';
import 'package:eff_mob_tes_app/logic/home_page/bloc/home_bloc_bloc.dart';
import 'package:eff_mob_tes_app/logic/theme/bloc/theme_bloc.dart';
import 'package:eff_mob_tes_app/services/favorites_keeper.dart';
import 'package:eff_mob_tes_app/services/data_cache.dart';
import 'package:eff_mob_tes_app/repo/characters_repository.dart';
import 'package:eff_mob_tes_app/view/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final favoritesKeeper = await FavoritesKeeper.create();
  final dataCache = DataCache();
  final charactersRepository = CharactersApiRepository();

  runApp(
    MyApp(
      favoritesKeeper: favoritesKeeper,
      dataCache: dataCache,
      charactersRepository: charactersRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final FavoritesKeeper favoritesKeeper;
  final DataCache dataCache;
  final CharactersRepository charactersRepository;

  const MyApp({
    super.key,
    required this.favoritesKeeper,
    required this.dataCache,
    required this.charactersRepository,
  });

  @override
  Widget build(BuildContext context) {
    final isDark =
        View.of(context).platformDispatcher.platformBrightness ==
        Brightness.dark;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBlocBloc(
            charactersRepository: charactersRepository,
            cacheService: dataCache,
          ),
        ),
        BlocProvider(
          create: (context) =>
              ThemeBloc()..add(ThemeSetInitialTheme(isDark: isDark)),
        ),
        BlocProvider(
          create: (context) =>
              FavoritesBloc(favoritesKeeper)..add(FavoritesInitial()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Characters',
            debugShowCheckedModeBanner: false,
            theme: kLightTheme,
            darkTheme: kDarkTheme,
            themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
            home: const MainPage(),
          );
        },
      ),
    );
  }
}
