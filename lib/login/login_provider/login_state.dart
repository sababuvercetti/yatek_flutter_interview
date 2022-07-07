import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  factory LoginState.initial() = _Initial;
  factory LoginState.loading() = _Loading;
  factory LoginState.success() = _Success;
  factory LoginState.error(String error) = _Error;
}
