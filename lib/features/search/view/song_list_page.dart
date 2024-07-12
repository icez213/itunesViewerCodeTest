// lib/screens/song_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itunesviewr/features/search/provider/song_provider.dart';

class SongListPage extends ConsumerWidget {
  const SongListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songListAsyncValue = ref.watch(songListProvider);
    final sortBy = ref.watch(sortByProvider);
    final filteredSongs = ref.watch(filteredSongsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('iTunes Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                ref
                    .read(searchQueryProvider.notifier)
                    .state = value;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio<String>(
                value: 'trackName',
                groupValue: sortBy,
                onChanged: (value) {
                  ref
                      .read(sortByProvider.notifier)
                      .setSortBy(value!);
                },
              ),
              const Text('Sort by Song Name'),
              Radio<String>(
                value: 'artistName',
                groupValue: sortBy,
                onChanged: (value) {
                  ref
                      .read(sortByProvider.notifier)
                      .setSortBy(value!);
                },
              ),
              const Text('Sort by Artist Name'),
            ],
          ),
          Expanded(
            child: songListAsyncValue.when(
              data: (songs) {
                return filteredSongs.isEmpty
                    ? const Center(
                        child: Text('No results found'))
                    : ListView.builder(
                        itemCount: filteredSongs.length,
                        itemBuilder: (context, index) {
                          final song = filteredSongs[index];
                          return ListTile(
                            leading: Image.network(
                                song.artworkUrl100),
                            title: Text(song.trackName),
                            subtitle: Text(song.artistName),
                          );
                        },
                      );
              },
              loading: () => const Center(
                  child: CircularProgressIndicator()),
              error: (error, stack) => const Center(
                  child: Text('Failed to load songs')),
            ),
          ),
        ],
      ),
    );
  }
}
