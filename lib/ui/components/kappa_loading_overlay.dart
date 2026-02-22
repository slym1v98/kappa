import 'package:flutter/material.dart';
import 'kappa_loading_indicator.dart';

/// Controller to manage global loading state.
/// Use [KappaLoading.show()] and [KappaLoading.hide()] to control the overlay.
class KappaLoading {
  static final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  static ValueNotifier<bool> get state => _isLoading;

  /// Show the global loading overlay.
  static void show() => _isLoading.value = true;

  /// Hide the global loading overlay.
  static void hide() => _isLoading.value = false;
}

/// A widget that overlays a loading indicator over its child based on global state.
class KappaLoadingOverlay extends StatelessWidget {
  final Widget child;

  const KappaLoadingOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          child,
          ValueListenableBuilder<bool>(
            valueListenable: KappaLoading.state,
            builder: (context, isLoading, _) {
              if (!isLoading) return const SizedBox.shrink();

              return AbsorbPointer(
                absorbing: true, // Prevent user interaction while loading
                child: Container(
                  color: Colors.black.withOpacity(0.35),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark 
                            ? Colors.grey[900] 
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          )
                        ]
                      ),
                      child: const KappaLoadingIndicator(radius: 18),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
