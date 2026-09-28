import 'package:dcc_toolkit/ui/blocful_widget.dart';
import 'package:example/profile/presentation/cubit/user_cubit.dart';
import 'package:example/profile/presentation/cubit/user_event.dart';
import 'package:material_ui/material_ui.dart';

class const UserPage({
  required final UserCubit Function(BuildContext)? onCreateCubit,
  super.key,
}) extends BlocfulWidget<UserCubit, UserState, UserEvent> {
  this : super(onCreateBloc: onCreateCubit);

  @override
  void onPresentationEvent(BuildContext context, UserEvent event) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(event.reason)));
  }

  @override
  Widget builder(BuildContext context, UserCubit bloc, UserState state) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.user?.email ?? ''),
              Text(state.user?.phone ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}
