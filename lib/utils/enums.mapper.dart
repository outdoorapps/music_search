// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'enums.dart';

class SortingTypeMapper extends EnumMapper<SortingType> {
  SortingTypeMapper._();

  static SortingTypeMapper? _instance;
  static SortingTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SortingTypeMapper._());
    }
    return _instance!;
  }

  static SortingType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SortingType decode(dynamic value) {
    switch (value) {
      case 'song':
        return SortingType.song;
      case 'album':
        return SortingType.album;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SortingType self) {
    switch (self) {
      case SortingType.song:
        return 'song';
      case SortingType.album:
        return 'album';
    }
  }
}

extension SortingTypeMapperExtension on SortingType {
  String toValue() {
    SortingTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SortingType>(this) as String;
  }
}
