import 'dart:convert';

import 'package:fita_music_app/data/model/music_model.dart';
import 'package:fita_music_app/data/model/music_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tMusicModel = MusicModel(
    wrapperType: "track",
    kind: "song",
    artistId: 909253,
    collectionId: 1469577723,
    trackId: 1469577741,
    artistName: "Jack Johnson",
    collectionName:
        "Jack Johnson and Friends: Sing-A-Longs and Lullabies for the Film Curious George",
    trackName: "Upside Down",
    collectionCensoredName:
        "Jack Johnson and Friends: Sing-A-Longs and Lullabies for the Film Curious George",
    trackCensoredName: "Upside Down",
    artistViewUrl: "1",
    collectionViewUrl: "1",
    trackViewUrl: "1",
    previewUrl: "1",
    artworkUrl30: "1",
    artworkUrl60: "1",
    artworkUrl100: "1",
    collectionPrice: 9.99,
    trackPrice: 1.29,
    releaseDate: "2005-01-01T12:00:00Z",
    collectionExplicitness: "notExplicit",
    trackExplicitness: "notExplicit",
    discCount: 1,
    discNumber: 1,
    trackCount: 14,
    trackNumber: 1,
    trackTimeMillis: 208643,
    country: "USA",
    currency: "USD",
    primaryGenreName: "Rock",
    isStreamable: true,
  );
  final tMusicResponseModel = MusicResponse(musicList: [tMusicModel]);
  group('fromJson', () {
    test('should return a valid music model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/music_list.json'));
      // act
      final result = MusicResponse.fromJson(jsonMap);
      // assert
      expect(result, tMusicResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tMusicResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "wrapperType": "track",
            "kind": "song",
            "artistId": 909253,
            "collectionId": 1469577723,
            "trackId": 1469577741,
            "artistName": "Jack Johnson",
            "collectionName":
                "Jack Johnson and Friends: Sing-A-Longs and Lullabies for the Film Curious George",
            "trackName": "Upside Down",
            "collectionCensoredName":
                "Jack Johnson and Friends: Sing-A-Longs and Lullabies for the Film Curious George",
            "trackCensoredName": "Upside Down",
            "artistViewUrl": "1",
            "collectionViewUrl": "1",
            "trackViewUrl": "1",
            "previewUrl": "1",
            "artworkUrl30": "1",
            "artworkUrl60": "1",
            "artworkUrl100": "1",
            "collectionPrice": 9.99,
            "trackPrice": 1.29,
            "releaseDate": "2005-01-01T12:00:00Z",
            "collectionExplicitness": "notExplicit",
            "trackExplicitness": "notExplicit",
            "discCount": 1,
            "discNumber": 1,
            "trackCount": 14,
            "trackNumber": 1,
            "trackTimeMillis": 208643,
            "country": "USA",
            "currency": "USD",
            "primaryGenreName": "Rock",
            "isStreamable": true
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
