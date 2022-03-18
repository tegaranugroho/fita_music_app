import 'package:fita_music_app/presentation/page/music_list_page.dart';
import 'package:fita_music_app/presentation/page/music_search_page.dart';
import 'package:flutter/material.dart';
import 'package:fita_music_app/injection.dart' as di;
import 'package:provider/provider.dart';

import 'common/constant.dart';
import 'common/utils.dart';
import 'presentation/provider/music_list_notifier.dart';
import 'presentation/provider/music_player_notifier.dart';
import 'presentation/provider/music_search_notifier.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MusicListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MusicSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MusicPlayerNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Fita Music App',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: primaryColor,
          scaffoldBackgroundColor: primaryColor,
          textTheme: kTextTheme,
        ),
        initialRoute: MusicListPage.routeName,
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case MusicListPage.routeName:
              return MaterialPageRoute(builder: (_) => const MusicListPage());
            case MusicSearchPage.routeName:
              return MaterialPageRoute(builder: (_) => const MusicSearchPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
