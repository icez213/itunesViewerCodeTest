import 'package:flutter/material.dart';
// import 'package:itunesviewr/features/search/view/home_page.dart';
import 'package:itunesviewr/features/search/view/song_list_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SongListPage(),
    );
  }
}
