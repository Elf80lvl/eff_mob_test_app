import 'package:dio/dio.dart';

class Netw {
  static const urlCharacter = 'https://rickandmortyapi.com/api/character';

  static getCharacters({int page = 1}) async {
    final dio = Dio();
    final url = '$urlCharacter?page=$page';
    final response = await dio.get(url);
    return response;
  }

  static Future<Response?> getCharacterById(String id) async {
    try {
      final dio = Dio();
      final url = '$urlCharacter/$id';
      final response = await dio.get(url);
      return response;
    } catch (e) {
      print('Error getting character by id: $e');
      return null;
    }
  }

  // static Future<Response?> getCharacterById(String id) async {
  //   try {
  //     final dio = Dio();
  //     final url = '$urlCharacter/$id';
  //     final response = await dio.get(url);
  //     return response;
  //   } catch (e) {
  //     print('Error getting character by id: $e');
  //     return null;
  //   }
  // }
}
