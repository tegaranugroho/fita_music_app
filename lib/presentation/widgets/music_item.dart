import 'package:cached_network_image/cached_network_image.dart';
import 'package:fita_music_app/domain/entities/music.dart';
import 'package:fita_music_app/presentation/provider/music_player_notifier.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../common/constant.dart';

class MusicItem extends StatelessWidget {
  final Music music;

  const MusicItem({Key? key, required this.music}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MusicPlayerNotifier>(context, listen: false);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          if (provider.selected.trackId != music.trackId) {
            provider.play(music: music);
          }
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Consumer<MusicPlayerNotifier>(
              builder: (context, value, child) {
                bool isPlaying =
                    (value.selected.trackId == music.trackId) && !value.isEnded;
                return Card(
                  color:
                      isPlaying ? primaryColor.withOpacity(0.5) : primaryColor,
                  elevation: 5,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                        left: 16 + 80, bottom: 8, right: 8, top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          music.trackName ?? '-',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: kHeading6,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          music.artistName ?? '-',
                          maxLines: 2,
                          style: kSubtitle,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          music.collectionName ?? '-',
                          maxLines: 2,
                          style: kSubtitle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: ClipRRect(
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: '${music.artworkUrl100}',
                      width: 60,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Positioned.fill(
                      child: Consumer<MusicPlayerNotifier>(
                        builder: (context, value, child) {
                          bool isPlaying =
                              (value.selected.trackId == music.trackId) &&
                                  !value.isEnded;
                          return isPlaying
                              ? Lottie.asset('assets/playing.json', width: 40)
                              : const Icon(Icons.play_arrow);
                        },
                      ),
                    ),
                  ],
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
