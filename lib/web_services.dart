import 'dart:convert';

import 'package:http/http.dart';
import 'package:music_search/json_model/itunes_response.dart';
import 'package:music_search/utils/debug.dart';

class WebServices {
  static const _authority = 'itunes.apple.com';
  static const _path = 'search';
  static final Map<String, dynamic> _parameters = {
    'term': 'Taylor Swift',
    'limit': '200',
    'media': 'music'
  };

  static Future<ItunesResponse?> getItunesResponse() async {
    try {
      Uri request = Uri.https(_authority, _path, _parameters);
      Response response = await get(request);
      return response.statusCode == 200
          ? ItunesResponse.fromJson(jsonDecode(response.body))
          : null;
    } catch (e) {
      p(e.toString());
      return null;
    }
  }
}
