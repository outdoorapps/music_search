// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'persistent_bloc.dart';

class PersistentStateMapper extends ClassMapperBase<PersistentState> {
  PersistentStateMapper._();

  static PersistentStateMapper? _instance;
  static PersistentStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PersistentStateMapper._());
      SortingTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PersistentState';

  static SortingType _$sortingType(PersistentState v) => v.sortingType;
  static const Field<PersistentState, SortingType> _f$sortingType = Field(
      'sortingType', _$sortingType,
      opt: true, def: PersistentBloc.defaultSortingType);

  @override
  final MappableFields<PersistentState> fields = const {
    #sortingType: _f$sortingType,
  };

  static PersistentState _instantiate(DecodingData data) {
    return PersistentState(sortingType: data.dec(_f$sortingType));
  }

  @override
  final Function instantiate = _instantiate;

  static PersistentState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PersistentState>(map);
  }

  static PersistentState fromJson(String json) {
    return ensureInitialized().decodeJson<PersistentState>(json);
  }
}

mixin PersistentStateMappable {
  String toJson() {
    return PersistentStateMapper.ensureInitialized()
        .encodeJson<PersistentState>(this as PersistentState);
  }

  Map<String, dynamic> toMap() {
    return PersistentStateMapper.ensureInitialized()
        .encodeMap<PersistentState>(this as PersistentState);
  }

  PersistentStateCopyWith<PersistentState, PersistentState, PersistentState>
      get copyWith => _PersistentStateCopyWithImpl(
          this as PersistentState, $identity, $identity);
  @override
  String toString() {
    return PersistentStateMapper.ensureInitialized()
        .stringifyValue(this as PersistentState);
  }

  @override
  bool operator ==(Object other) {
    return PersistentStateMapper.ensureInitialized()
        .equalsValue(this as PersistentState, other);
  }

  @override
  int get hashCode {
    return PersistentStateMapper.ensureInitialized()
        .hashValue(this as PersistentState);
  }
}

extension PersistentStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PersistentState, $Out> {
  PersistentStateCopyWith<$R, PersistentState, $Out> get $asPersistentState =>
      $base.as((v, t, t2) => _PersistentStateCopyWithImpl(v, t, t2));
}

abstract class PersistentStateCopyWith<$R, $In extends PersistentState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({SortingType? sortingType});
  PersistentStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PersistentStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PersistentState, $Out>
    implements PersistentStateCopyWith<$R, PersistentState, $Out> {
  _PersistentStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PersistentState> $mapper =
      PersistentStateMapper.ensureInitialized();
  @override
  $R call({SortingType? sortingType}) => $apply(
      FieldCopyWithData({if (sortingType != null) #sortingType: sortingType}));
  @override
  PersistentState $make(CopyWithData data) => PersistentState(
      sortingType: data.get(#sortingType, or: $value.sortingType));

  @override
  PersistentStateCopyWith<$R2, PersistentState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PersistentStateCopyWithImpl($value, $cast, t);
}
