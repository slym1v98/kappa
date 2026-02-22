import 'package:fkappa/kappa.dart';
import 'package:equatable/equatable.dart';

// --- State ---
class SettingsState extends Equatable {
  final bool isDarkMode;
  const SettingsState({this.isDarkMode = false});

  @override
  List<Object?> get props => [isDarkMode];

  // Convert to JSON for Persistence (Hydrated BLoC)
  Map<String, dynamic> toMap() => {'isDarkMode': isDarkMode};

  // Restore from JSON (Hydrated BLoC)
  factory SettingsState.fromMap(Map<String, dynamic> map) {
    return SettingsState(isDarkMode: map['isDarkMode'] ?? false);
  }
}

// --- BLoC ---
class SettingsBloc extends BaseHydratedBloc<bool, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<bool>((event, emit) => emit(SettingsState(isDarkMode: event)));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) => SettingsState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(SettingsState state) => state.toMap();
}
