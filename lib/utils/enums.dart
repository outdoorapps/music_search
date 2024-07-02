import 'package:dart_mappable/dart_mappable.dart';

part 'enums.mapper.dart';

enum BlocStatus { initializing, running, done }

@MappableEnum()
enum SortingType { song, album }