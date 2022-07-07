import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  factory ProfileState.initial() = _Initial;
  factory ProfileState.loading() = _Loading;
  factory ProfileState.success() = _Success;
  factory ProfileState.error(String e) = _Error;
}
