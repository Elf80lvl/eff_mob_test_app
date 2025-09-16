import 'dart:developer';

import 'package:dio/dio.dart';

abstract class CharactersRepository {
  Future<Response> getCharacters({int page = 1});
  Future<Response?> getCharacterById(String id);
}

class CharactersApiRepository implements CharactersRepository {
  static const urlCharacter = 'https://rickandmortyapi.com/api/character';
  final Dio _dio;

  CharactersApiRepository({Dio? dio}) : _dio = dio ?? Dio();

  @override
  Future<Response> getCharacters({int page = 1}) async {
    final url = '$urlCharacter?page=$page';
    return await _dio.get(url);
  }

  @override
  Future<Response?> getCharacterById(String id) async {
    try {
      final url = '$urlCharacter/$id';
      return await _dio.get(url);
    } catch (e) {
      log('Error getting character by id: $e');
      return null;
    }
  }
}
