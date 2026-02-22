import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// Monitors all BLoCs globally for state changes and errors.
class KappaBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      print('Kappa BLoC Transition: ${bloc.runtimeType} -> ${transition.nextState}');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) {
      print('Kappa BLoC Error in ${bloc.runtimeType}: $error');
    }
    
    // Automatically report to Sentry in production
    if (!kDebugMode) {
      Sentry.captureException(error, stackTrace: stackTrace);
    }
  }
}
