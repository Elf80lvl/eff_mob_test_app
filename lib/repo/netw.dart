import 'package:dio/dio.dart';

class Netw {
  static const urlCharacter = 'https://rickandmortyapi.com/api/character';

  static getCharacters({int page = 1}) async {
    final dio = Dio();
    final url = '$urlCharacter?page=$page';
    final response = await dio.get(url);
    return response;
  }
}
