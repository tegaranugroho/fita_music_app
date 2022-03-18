import 'package:dartz/dartz.dart';
import 'package:fita_music_app/domain/entities/music.dart';
import 'package:fita_music_app/domain/usecase/search_music.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchMusic usecase;
  late MockMusicRepository mockMusicRepository;

  setUp(() {
    mockMusicRepository = MockMusicRepository();
    usecase = SearchMusic(mockMusicRepository);
  });

  final tMusic = <Music>[];
  const tQuery = 'avril';

  test('should get list of music from the repository', () async {
    // arrange
    when(mockMusicRepository.searchMusic(tQuery))
        .thenAnswer((_) async => Right(tMusic));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tMusic));
  });
}
