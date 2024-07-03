// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "album": MessageLookupByLibrary.simpleMessage("Album"),
        "caching_itunes_data":
            MessageLookupByLibrary.simpleMessage("Caching iTunes data..."),
        "fail_to_cache":
            MessageLookupByLibrary.simpleMessage("Failed to cache from itunes"),
        "no_results": MessageLookupByLibrary.simpleMessage("No results"),
        "refresh": MessageLookupByLibrary.simpleMessage("Retry"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "song_name": MessageLookupByLibrary.simpleMessage("Song name"),
        "sort_by": MessageLookupByLibrary.simpleMessage("Sort by"),
        "you_may_like": MessageLookupByLibrary.simpleMessage("You may like...")
      };
}
