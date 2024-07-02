import 'package:dart_mappable/dart_mappable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:music_search/utils/debug.dart';
import 'package:music_search/utils/enums.dart';

part 'persistent_bloc.mapper.dart';

enum PersistentType<T> {
  sortingType<SortingType>(),
}

class PersistentBloc extends HydratedBloc<PersistentEvent, PersistentState> {
  static const SortingType defaultSortingType = SortingType.song;

  PersistentBloc() : super(PersistentState()) {
    on<UpdatePersistentStateEvent>((event, emit) {
      switch (event.type) {
        case PersistentType.sortingType:
          p('${event.value}');
          emit(state.copyWith(sortingType: event.value));
          break;
      }
    });
  }

  @override
  PersistentState? fromJson(Map<String, dynamic> json) =>
      PersistentStateMapper.fromMap(json);

  @override
  Map<String, dynamic>? toJson(PersistentState state) => state.toMap();
}

abstract class PersistentEvent {}

class UpdatePersistentStateEvent<T> extends PersistentEvent {
  PersistentType<T> type;
  T value;

  UpdatePersistentStateEvent({required this.type, required this.value}) {
    assert(
        T != dynamic && T != Object,
        'Type for PersistentType<T> and should not be generic, '
        'but type $T is passed, this may happen if UserSettings<T> and value'
        'are not of the same type.');
  }
}

@MappableClass()
class PersistentState with PersistentStateMappable {
  SortingType sortingType;

  //todo search history
  PersistentState({this.sortingType = PersistentBloc.defaultSortingType});
}
