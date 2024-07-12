// lib/providers/song_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itunesviewr/core/network/services/api_service.dart';
import 'package:itunesviewr/features/search/data/song.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final songListProvider =
    FutureProvider<List<Song>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchSongs();
});

final searchQueryProvider =
    StateProvider<String>((ref) => '');

final sortByProvider =
    StateNotifierProvider<SortByNotifier, String>((ref) {
  return SortByNotifier();
});

class SortByNotifier extends StateNotifier<String> {
  SortByNotifier() : super('trackName');

  void setSortBy(String value) {
    state = value;
  }
}

final filteredSongsProvider = Provider<List<Song>>((ref) {
  final songs = ref.watch(songListProvider).maybeWhen(
        data: (songs) => songs,
        orElse: () => <Song>[],
      );

  final searchQuery = ref.watch(searchQueryProvider);
  final sortBy = ref.watch(sortByProvider);

  final filtered = songs.where((song) {
    return song.trackName
            .toLowerCase()
            .contains(searchQuery.toLowerCase()) ||
        song.artistName
            .toLowerCase()
            .contains(searchQuery.toLowerCase());
  }).toList();

  filtered.sort((a, b) {
    if (sortBy == 'trackName') {
      return a.trackName.compareTo(b.trackName);
    } else {
      return a.artistName.compareTo(b.artistName);
    }
  });

  return filtered;
});
