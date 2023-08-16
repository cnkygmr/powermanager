import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'powermanager_method_channel.dart';

abstract class PowermanagerPlatform extends PlatformInterface {
  /// Constructs a PowermanagerPlatform.
  PowermanagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static PowermanagerPlatform _instance = MethodChannelPowermanager();

  /// The default instance of [PowermanagerPlatform] to use.
  ///
  /// Defaults to [MethodChannelPowermanager].
  static PowermanagerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PowermanagerPlatform] when
  /// they register themselves.
  static set instance(PowermanagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> on() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> off() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
