import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'powermanager_platform_interface.dart';

/// An implementation of [PowermanagerPlatform] that uses method channels.
class MethodChannelPowermanager extends PowermanagerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('powermanager');

  @override
  Future<bool?> on() async {
    return await methodChannel.invokeMethod<bool?>('on');
  }

  @override
  Future<bool?> off() async {
    return await methodChannel.invokeMethod<bool?>('off');
  }
}
