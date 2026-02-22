// Core Framework
export 'kappa_app.dart';

// Architecture Base Classes
export 'core/architecture/use_case.dart';
export 'core/architecture/repository.dart';
export 'core/architecture/data_source.dart';
export 'core/architecture/hydrated_bloc.dart';
export 'core/architecture/kappa_middleware.dart';
export 'core/architecture/kappa_env.dart';
export 'core/error/failure.dart';
export 'core/error/kappa_bloc_observer.dart';
export 'core/event_bus/kappa_event_bus.dart';
export 'core/network/kappa_dio.dart';
export 'core/di/kappa_service_registry.dart';

// Module System
export 'modules/kappa_module.dart';

// UI System
export 'ui/components/kappa_button.dart';
export 'ui/components/kappa_text_field.dart';
export 'ui/components/kappa_card.dart';
export 'ui/components/kappa_list_tile.dart';
export 'ui/components/kappa_dialog.dart';
export 'ui/components/kappa_switch.dart';
export 'ui/components/kappa_slider.dart';
export 'ui/components/kappa_app_bar.dart';
export 'ui/components/kappa_loading_indicator.dart';
export 'ui/components/kappa_loading_overlay.dart';
export 'ui/components/kappa_bottom_nav_bar.dart';
export 'ui/toolkit/kappa_spacing.dart';
export 'ui/toolkit/kappa_responsive.dart';
export 'ui/toolkit/kappa_animation.dart';
export 'ui/toolkit/kappa_page_transition.dart';
export 'ui/toolkit/kappa_layout.dart';

// Re-export key dependencies for convenience
export 'package:go_router/go_router.dart';
export 'package:get_it/get_it.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:hydrated_bloc/hydrated_bloc.dart';
export 'package:fpdart/fpdart.dart';
export 'package:dio/dio.dart';
export 'package:responsive_framework/responsive_framework.dart';
