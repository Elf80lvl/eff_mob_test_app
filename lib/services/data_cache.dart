import 'package:hive/hive.dart';
import 'package:eff_mob_tes_app/model/character_model.dart';

class DataCache {
  static const String boxName = 'characterCacheBox';

  Future<void> saveCharacters(int page, List<Character> characters) async {
    final box = await Hive.openBox(boxName);
    box.put('page_$page', characters.map((e) => e.toJson()).toList());
  }

  Future<List<Character>?> getCharacters(int page) async {
    final box = await Hive.openBox(boxName);
    final data = box.get('page_$page');
    if (data == null) return null;
    // return (data as List)
    //     .map((e) => Character.fromJson(Map<String, dynamic>.from(e)))
    //     .toList();
    return (data as List)
        .map((e) => Character.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  Future<void> clearCache() async {
    final box = await Hive.openBox(boxName);
    await box.clear();
  }
}
