import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Response> search(String term,
      {int limit = 20,
      int offset = 0,
      String country = 'US',
      String entity = 'musicTrack'}) async {
    final response = await _dio.get(
      'https://itunes.apple.com/search',
      queryParameters: {
        'term': term,
        'limit': limit,
        'offset': offset,
        'country': country,
        'entity': entity,
      },
    );
    return response;
  }
}
