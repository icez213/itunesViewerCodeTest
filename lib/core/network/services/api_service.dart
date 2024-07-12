// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itunesviewr/features/search/data/song.dart';

class ApiService {
  static const String _baseUrl =
      'https://itunes.apple.com/search?term=Taylor+Swift&limit=200&media=music';

  Future<List<Song>> fetchSongs() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data =
          json.decode(response.body)['results'];
      return data
          .map((json) => Song.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load songs');
    }
  }
}
