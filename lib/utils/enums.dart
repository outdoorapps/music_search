import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_search/generated/l10n.dart';

part 'enums.mapper.dart';

enum BlocStatus { initializing, running, done }

@MappableEnum()
enum SortingType { song, album }

extension SortingTypeExtension on SortingType {
  String toName(BuildContext context) {
    switch (this) {
      case SortingType.song:
        return S.of(context).song_name;
      case SortingType.album:
        return S.of(context).album;
    }
  }
}
