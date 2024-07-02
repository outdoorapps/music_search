import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_search/internal_state/app_repository.dart';
import 'package:music_search/json_model/itunes_response.dart';
import 'package:music_search/utils/enums.dart';

part 'home_screen_bloc.g.dart';

class HomeScreenBloc extends Bloc<HomeScreenBlocEvent, HomeScreenBlocState> {
  HomeScreenBloc()
      : super(
            HomeScreenBlocState(appRepositoryRefreshStatus: BlocStatus.done)) {
    on<ChangeSelectedTrackEvent>((event, emit) {
      emit(state.copyWith(selectedTrack: event.selectedTrack));
    });

    on<RefreshAppRepositoryEvent>((event, emit) async {
      emit(state.copyWith(appRepositoryRefreshStatus: BlocStatus.running));
      await AppRepository.ensureInitialized();
      if (!isClosed) {
        emit(state.copyWith(appRepositoryRefreshStatus: BlocStatus.done));
      }
    });
  }
}

abstract class HomeScreenBlocEvent {}

class ChangeSelectedTrackEvent extends HomeScreenBlocEvent {
  Track? selectedTrack;

  ChangeSelectedTrackEvent(this.selectedTrack);
}

class RefreshAppRepositoryEvent extends HomeScreenBlocEvent {}

@CopyWith()
class HomeScreenBlocState {
  BlocStatus appRepositoryRefreshStatus;
  Track? selectedTrack;

  HomeScreenBlocState(
      {required this.appRepositoryRefreshStatus, this.selectedTrack});
}
