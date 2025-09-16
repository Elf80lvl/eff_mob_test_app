// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:eff_mob_tes_app/repo/characters_repository.dart';
import 'package:eff_mob_tes_app/services/data_cache.dart';
import 'package:eff_mob_tes_app/services/favorites_keeper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:eff_mob_tes_app/main.dart';

late FavoritesKeeper _favoritesKeeper;
late DataCache _dataCache;
late CharactersRepository _charactersRepository;

void initialLaunch() async {
  _favoritesKeeper = await FavoritesKeeper.create();
  _dataCache = DataCache();
  _charactersRepository = CharactersApiRepository();
}

void main() {
  initialLaunch();
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MyApp(
        favoritesKeeper: _favoritesKeeper,
        dataCache: _dataCache,
        charactersRepository: _charactersRepository,
      ),
    );

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
