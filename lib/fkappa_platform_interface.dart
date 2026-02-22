import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'fkappa_method_channel.dart';

abstract class FKappaPlatform extends PlatformInterface {
  /// Constructs a FKappaPlatform.
  FKappaPlatform() : super(token: _token);

  static final Object _token = Object();

  static FKappaPlatform _instance = MethodChannelFKappa();

  /// The default instance of [FKappaPlatform] to use.
  ///
  /// Defaults to [MethodChannelFKappa].
  static FKappaPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FKappaPlatform] when
  /// they register themselves.
  static set instance(FKappaPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
