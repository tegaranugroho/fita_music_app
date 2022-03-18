import 'package:fita_music_app/data/datasource/music_remote_datasource.dart';
import 'package:fita_music_app/data/repositories/music_repository_impl.dart';
import 'package:fita_music_app/domain/repositories/music_repository.dart';
import 'package:fita_music_app/domain/usecase/get_music_list.dart';
import 'package:fita_music_app/presentation/provider/music_player_notifier.dart';
import 'package:fita_music_app/presentation/provider/music_search_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'domain/usecase/search_music.dart';
import 'presentation/provider/music_list_notifier.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MusicListNotifier(
      getMusicList: locator(),
    ),
  );
  locator.registerFactory(
    () => MusicSearchNotifier(
      searchMusic: locator(),
    ),
  );
  locator.registerFactory(
    () => MusicPlayerNotifier(),
  );
  // use case music
  locator.registerLazySingleton(() => GetMusicList(locator()));
  locator.registerLazySingleton(() => SearchMusic(locator()));

  // repository
  locator.registerLazySingleton<MusicRepository>(
    () => MusicRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MusicRemoteDataSource>(
      () => MusicRemoteDataSourceImpl(client: locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
}
