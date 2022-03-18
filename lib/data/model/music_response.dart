import 'package:equatable/equatable.dart';

import 'music_model.dart';

class MusicResponse extends Equatable {
  final List<MusicModel> musicList;

  const MusicResponse({required this.musicList});

  factory MusicResponse.fromJson(Map<String, dynamic> json) => MusicResponse(
        musicList: List<MusicModel>.from((json["results"] as List)
            .map((x) => MusicModel.fromJson(x))
            .where((element) => element.artworkUrl100 != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(musicList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [musicList];
}
