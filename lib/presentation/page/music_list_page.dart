import 'package:fita_music_app/presentation/page/music_search_page.dart';
import 'package:fita_music_app/presentation/provider/music_list_notifier.dart';
import 'package:fita_music_app/presentation/provider/music_player_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/state_enum.dart';
import '../widgets/music_item.dart';

class MusicListPage extends StatefulWidget {
  static const routeName = '/music-list';

  const MusicListPage({Key? key}) : super(key: key);

  @override
  _MusicListPageState createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {
  @override
  void initState() {
    super.initState();
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
        title: const Text('Fita Music App'),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, MusicSearchPage.routeName),
            child: const Icon(Icons.search),
          ),
          const SizedBox(width: 10),
        ],
      ),
      bottomNavigationBar: _playing(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<MusicListNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final musicList = data.musicList[index];
                  return MusicItem(music: musicList);
                },
                itemCount: data.musicList.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
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
