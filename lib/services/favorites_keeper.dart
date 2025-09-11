import 'package:shared_preferences/shared_preferences.dart';

class FavoritesKeeper {
  static const String _key = 'favorite_characters';
  final SharedPreferences _prefs;

  FavoritesKeeper(this._prefs);

  static Future<FavoritesKeeper> create() async {
    final prefs = await SharedPreferences.getInstance();
    return FavoritesKeeper(prefs);
  }

  List<String> getFavorites() {
    return _prefs.getStringList(_key) ?? [];
  }

  Future<bool> addToFavorites(String characterId) async {
    final favorites = getFavorites();
    if (!favorites.contains(characterId)) {
      favorites.add(characterId);
      return await _prefs.setStringList(_key, favorites);
    }
    return false;
  }

  Future<bool> removeFromFavorites(String characterId) async {
    final favorites = getFavorites();
    if (favorites.contains(characterId)) {
      favorites.remove(characterId);
      return await _prefs.setStringList(_key, favorites);
    }
    return false;
  }

  bool isFavorite(String characterId) {
    final favorites = getFavorites();
    return favorites.contains(characterId);
  }

  Future<bool> clearFavorites() async {
    return await _prefs.remove(_key);
  }
}
