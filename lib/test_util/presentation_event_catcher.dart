import 'package:bloc_presentation/bloc_presentation.dart';

/// Catch events from a [BlocPresentationMixin] and add them to a list.
C catchEventIn<C extends BlocPresentationMixin<S, E>, S, E>(C cubit, List<E> events) {
  cubit.presentation.listen(events.add);

  return cubit;
}
