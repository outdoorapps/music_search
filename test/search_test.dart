import 'package:flutter_test/flutter_test.dart';
import 'package:music_search/json_model/itunes_response.dart';
import 'package:music_search/utils/enums.dart';
import 'package:music_search/utils/search.dart';

void searchTests(List<Track> tracks) {
  group('Sample data initialized, testing queries and sorting', () {
    test('Testing queries', () {
      var results = Search.query('');
      expect(results.length, 200);

      results = Search.query('all');
      expect(results.length, 10);

      results = Search.query('shake it off');
      expect(results.length, 2);

      results = Search.query('love story');
      expect(results.length, 1);

      results = Search.query('abc');
      expect(results.length, 0);
    });

    test('Testing sorting', () {
      var tracksCopy = [...tracks];
      Search.sortBySortingType(tracksCopy, SortingType.song);
      expect(tracksCopy.first.trackName, '\'tis the damn season');
      expect(tracksCopy.last.trackName, 'willow');

      tracksCopy = [...tracks];
      Search.sortBySortingType(tracksCopy, SortingType.album);
      expect(tracksCopy.first.trackName, 'Bad Blood');
      expect(tracksCopy.last.trackName, 'Don’t Blame Me');

      tracksCopy = Search.query('all');
      Search.sortBySortingType(tracksCopy, SortingType.song);
      expect(tracksCopy.first.trackName,
          'All Too Well (10 Minute Version) [Taylor\'s Version] [From The Vault]');
      expect(tracksCopy.last.trackName, 'mirrorball');

      tracksCopy = Search.query('all');
      Search.sortBySortingType(tracksCopy, SortingType.album);
      expect(tracksCopy.first.trackName,
          'All You Had To Do Was Stay (Taylor\'s Version)');
      expect(tracksCopy.last.trackName, 'mirrorball');

      tracksCopy = Search.query('shake it off');
      Search.sortBySortingType(tracksCopy, SortingType.song);
      expect(tracksCopy.first.trackName, 'Shake It Off');
      expect(tracksCopy.last.trackName, 'Shake It Off (Taylor\'s Version)');

      tracksCopy = Search.query('shake it off');
      Search.sortBySortingType(tracksCopy, SortingType.album);
      expect(tracksCopy.first.trackName, 'Shake It Off');
      expect(tracksCopy.last.trackName, 'Shake It Off (Taylor\'s Version)');
    });
  });
}