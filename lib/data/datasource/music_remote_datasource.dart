import 'dart:convert';
import 'package:fita_music_app/data/model/music_model.dart';
import 'package:fita_music_app/data/model/music_response.dart';
import 'package:http/http.dart' as http;

import '../../common/exception.dart';

abstract class MusicRemoteDataSource {
  Future<List<MusicModel>> getMusicList();
  Future<List<MusicModel>> searchMusic(String query);
}

class MusicRemoteDataSourceImpl implements MusicRemoteDataSource {
  static const baseUrl = 'https://itunes.apple.com';

  final http.Client client;

  MusicRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MusicModel>> getMusicList() async {
    final response = await client.get(Uri.parse('$baseUrl/search?term=avril'));

    if (response.statusCode == 200) {
      return MusicResponse.fromJson(json.decode(response.body)).musicList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MusicModel>> searchMusic(String query) async {
    final response = await client.get(Uri.parse('$baseUrl/search?term=$query'));

    if (response.statusCode == 200) {
      return MusicResponse.fromJson(json.decode(response.body)).musicList;
    } else {
      throw ServerException();
    }
  }
}
