import 'package:music_search/json_model/itunes_response.dart';
import 'package:music_search/web_services.dart';

class AppRepository {
  static ItunesResponse? itunesResponse;

  static Future<void> ensureInitialized() async {
    itunesResponse = await WebServices.getItunesResponse();
  }
}
