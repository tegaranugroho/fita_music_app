import 'dart:convert';

import 'package:fita_music_app/common/exception.dart';
import 'package:fita_music_app/data/datasource/music_remote_datasource.dart';
import 'package:fita_music_app/data/model/music_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  const baseUrl = 'https://itunes.apple.com';

  late MusicRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = MusicRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Music list', () {
    final tMusicList = MusicResponse.fromJson(
            json.decode(readJson('dummy_data/music_list.json')))
        .musicList;

    test('should return list of Music Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/search?term=avril')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/music_list.json'), 200));
      // act
      final result = await dataSource.getMusicList();
      // assert
      expect(result, equals(tMusicList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search?term=avril')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getMusicList();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search music', () {
    final tSearchResult = MusicResponse.fromJson(
            json.decode(readJson('dummy_data/music_list.json')))
        .musicList;
    const tQuery = 'avril';

    test('should return list of music when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search?term=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/music_list.json'), 200));
      // act
      final result = await dataSource.searchMusic(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search?term=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchMusic(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
