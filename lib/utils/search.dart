import 'package:music_search/internal_state/app_repository.dart';
import 'package:music_search/json_model/itunes_response.dart';
import 'package:music_search/utils/enums.dart';

class Search {
  static List<Track> query(String query) =>
      AppRepository.itunesResponse?.tracks
          .where((e) =>
              e.trackName.toLowerCase().contains(query) ||
              e.collectionName.toLowerCase().contains(query))
          .toList() ??
      [];

  static void sortBySortingType(List<Track> list, SortingType sortingType) {
    switch (sortingType) {
      case SortingType.song:
        list.sort((a, b) => a.trackName.compareTo(b.trackName));
        break;
      case SortingType.album:
        list.sort((a, b) => a.collectionName.compareTo(b.collectionName));
        break;
    }
  }
}
