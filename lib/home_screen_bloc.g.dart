// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HomeScreenBlocStateCWProxy {
  HomeScreenBlocState appRepositoryRefreshStatus(
      BlocStatus appRepositoryRefreshStatus);

  HomeScreenBlocState selectedTrack(Track? selectedTrack);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HomeScreenBlocState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HomeScreenBlocState(...).copyWith(id: 12, name: "My name")
  /// ````
  HomeScreenBlocState call({
    BlocStatus? appRepositoryRefreshStatus,
    Track? selectedTrack,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHomeScreenBlocState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHomeScreenBlocState.copyWith.fieldName(...)`
class _$HomeScreenBlocStateCWProxyImpl implements _$HomeScreenBlocStateCWProxy {
  const _$HomeScreenBlocStateCWProxyImpl(this._value);

  final HomeScreenBlocState _value;

  @override
  HomeScreenBlocState appRepositoryRefreshStatus(
          BlocStatus appRepositoryRefreshStatus) =>
      this(appRepositoryRefreshStatus: appRepositoryRefreshStatus);

  @override
  HomeScreenBlocState selectedTrack(Track? selectedTrack) =>
      this(selectedTrack: selectedTrack);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HomeScreenBlocState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HomeScreenBlocState(...).copyWith(id: 12, name: "My name")
  /// ````
  HomeScreenBlocState call({
    Object? appRepositoryRefreshStatus = const $CopyWithPlaceholder(),
    Object? selectedTrack = const $CopyWithPlaceholder(),
  }) {
    return HomeScreenBlocState(
      appRepositoryRefreshStatus:
          appRepositoryRefreshStatus == const $CopyWithPlaceholder() ||
                  appRepositoryRefreshStatus == null
              ? _value.appRepositoryRefreshStatus
              // ignore: cast_nullable_to_non_nullable
              : appRepositoryRefreshStatus as BlocStatus,
      selectedTrack: selectedTrack == const $CopyWithPlaceholder()
          ? _value.selectedTrack
          // ignore: cast_nullable_to_non_nullable
          : selectedTrack as Track?,
    );
  }
}

extension $HomeScreenBlocStateCopyWith on HomeScreenBlocState {
  /// Returns a callable class that can be used as follows: `instanceOfHomeScreenBlocState.copyWith(...)` or like so:`instanceOfHomeScreenBlocState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HomeScreenBlocStateCWProxy get copyWith =>
      _$HomeScreenBlocStateCWProxyImpl(this);
}
