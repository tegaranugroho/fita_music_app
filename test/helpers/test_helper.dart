import 'package:fita_music_app/data/datasource/music_remote_datasource.dart';
import 'package:fita_music_app/domain/repositories/music_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MusicRepository,
  MusicRemoteDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
