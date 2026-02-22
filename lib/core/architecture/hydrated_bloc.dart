import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';

/// A base class for persistent BLoCs.
/// It automatically saves and restores the state from local storage.
abstract class BaseHydratedBloc<E, S extends Equatable> extends HydratedBloc<E, S> {
  BaseHydratedBloc(super.initialState);

  /// Implement [fromJson] to reconstruct the state from the stored map.
  @override
  S? fromJson(Map<String, dynamic> json);

  /// Implement [toJson] to convert the state into a map for storage.
  @override
  Map<String, dynamic>? toJson(S state);
}
