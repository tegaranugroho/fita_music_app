import 'package:fita_music_app/common/constant.dart';
import 'package:fita_music_app/common/state_enum.dart';
import 'package:fita_music_app/presentation/provider/music_list_notifier.dart';
import 'package:fita_music_app/presentation/provider/music_player_notifier.dart';
import 'package:fita_music_app/presentation/provider/music_search_notifier.dart';
import 'package:fita_music_app/presentation/widgets/music_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicSearchPage extends StatefulWidget {
  static const routeName = '/search-music';

  const MusicSearchPage({Key? key}) : super(key: key);

  @override
  State<MusicSearchPage> createState() => _MusicSearchPageState();
}

class _MusicSearchPageState extends State<MusicSearchPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<MusicSearchNotifier>(context, listen: false).resetSearch());
    Future.microtask(() =>
        Provider.of<MusicListNotifier>(context, listen: false)
            .fetchMusicList());
    Future.microtask(
        () => Provider.of<MusicPlayerNotifier>(context, listen: false).log());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      bottomNavigationBar: _playing(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                Provider.of<MusicSearchNotifier>(context, listen: false)
                    .fetchMusicSearch(query);
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Consumer<MusicSearchNotifier>(
              builder: (context, data, child) {
                if (data.state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.state == RequestState.Loaded) {
                  final result = data.searchResult;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final music = data.searchResult[index];
                        return MusicItem(music: music);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  _playing() {
    return Consumer<MusicPlayerNotifier>(
      builder: (context, value, child) => value.showPlayer
          ? GestureDetector(
              onTap: () {
                value.playOrPause();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                height: 60,
                decoration: const BoxDecoration(
                    border:
                        Border(top: BorderSide(color: Colors.grey, width: 1))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.skip_previous, size: 32),
                    Icon(value.isEnded ? Icons.play_arrow : Icons.pause,
                        size: 32),
                    const Icon(Icons.skip_next, size: 32),
                  ],
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
