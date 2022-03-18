import 'package:dartz/dartz.dart';
import 'package:fita_music_app/domain/entities/music.dart';
import 'package:fita_music_app/domain/usecase/get_music_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetMusicList usecase;
  late MockMusicRepository mockMusicRepository;

  setUp(() {
    mockMusicRepository = MockMusicRepository();
    usecase = GetMusicList(mockMusicRepository);
  });

  final tMusicList = <Music>[];

  test('should get list of music from the repository', () async {
    // arrange
    when(mockMusicRepository.getMusicList())
        .thenAnswer((_) async => Right(tMusicList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tMusicList));
  });
}
