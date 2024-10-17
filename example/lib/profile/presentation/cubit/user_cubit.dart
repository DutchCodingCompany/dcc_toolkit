import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:example/profile/data/model/user.dart';
import 'package:example/profile/data/user_repository.dart';
import 'package:example/profile/presentation/cubit/user_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_cubit.freezed.dart';
part 'user_state.dart';

@injectable
class UserCubit extends Cubit<UserState>
    with BlocPresentationMixin<UserState, UserEvent> {
  UserCubit(this._userRepo) : super(const UserState(user: null));

  final UserRepository _userRepo;

  Future<void> getRandomUser() async {
    final result = await _userRepo.getRandomUser();
    result.when(
      error: (error) {
        emitPresentation(const UserFetchFailed());
      },
      success: (success) {
        emit(state.copyWith(user: success.results.first));
        emitPresentation(const UserLoaded());
      },
    );
  }

  Future<void> getRandomUserFails() async {
    final result = await _userRepo.getRandomUserFails();
    result.when(
      error: (error) {
        emitPresentation(const UserFetchFailed());
      },
      success: (success) {
        emit(state.copyWith(user: success.results.first));
        emitPresentation(const UserLoaded());
      },
    );
  }
}
