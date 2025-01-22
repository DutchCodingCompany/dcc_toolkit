import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A widget that wraps your UI in a [BlocPresentationListener] and a [BlocConsumer] to be able to handle all events simultaniously
///
/// Example:
/// ```dart
/// class SomePage extends BlocfulWidget<SomeCubit, SomeState, SomeEvent> {
///   const SomePage({super.key})
///       : super(onCreateBloc: SomeCubit());

///   @override
///   void onPresentationEvent(BuildContext context, SomeEvent event) {
///     SomeFunction();
///   }

///   @override
///   Widget builder(BuildContext context, SomeCubit bloc, SomeState state) {
///     return SomeWidget();
///   }
/// }
/// ```
abstract class BlocfulWidget<BLOC extends BlocPresentationMixin<STATE, EVENT>,
    STATE, EVENT> extends StatelessWidget {
  /// Creates a [BlocfulWidget]
  const BlocfulWidget({this.onCreateBloc, super.key});

  /// Wraps the widget with a [BlocProvider] with the given [BLOC] when this is not null
  final BLOC Function(BuildContext)? onCreateBloc;

  @override
  Widget build(BuildContext context) {
    return onCreateBloc != null
        ? BlocProvider<BLOC>(
            create: onCreateBloc!,
            child: BlocPresentationListener<BLOC, EVENT>(
              listener: onPresentationEvent,
              child: BlocConsumer<BLOC, STATE>(
                listener: (context, state) =>
                    listener(context, context.read<BLOC>(), state),
                builder: (context, state) =>
                    builder(context, context.read<BLOC>(), state),
              ),
            ),
          )
        : BlocPresentationListener<BLOC, EVENT>(
            listener: onPresentationEvent,
            child: BlocConsumer<BLOC, STATE>(
              listener: (context, state) =>
                  listener(context, context.read<BLOC>(), state),
              builder: (context, state) =>
                  builder(context, context.read<BLOC>(), state),
            ),
          );
  }

  /// A function that defines what UI behaviour should be triggered when an [EVENT] has taken place
  void onPresentationEvent(BuildContext context, EVENT event) {}

  /// Builder function for the builder function of the [BlocConsumer]
  Widget builder(BuildContext context, BLOC bloc, STATE state);

  /// Listener function for the listener function of the [BlocConsumer]
  void listener(BuildContext context, BLOC bloc, STATE state) {}
}
