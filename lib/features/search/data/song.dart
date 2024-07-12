import 'package:freezed_annotation/freezed_annotation.dart';

part 'song.freezed.dart';
part 'song.g.dart';

@freezed
class Song with _$Song {
  const factory Song({
    required String trackName,
    required String artistName,
    required String artworkUrl100,
  }) = _Song;

  factory Song.fromJson(Map<String, dynamic> json) =>
      _$SongFromJson(json);
}
