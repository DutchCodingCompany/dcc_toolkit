part of 'user_cubit.dart';

@freezed
sealed class UserState with _$UserState {
  const factory UserState({User? user}) = _UserState;
}
