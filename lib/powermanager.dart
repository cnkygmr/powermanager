
import 'powermanager_platform_interface.dart';

class Powermanager {
  Future<bool?> on() {
    return PowermanagerPlatform.instance.on();
  }
  Future<bool?> off() {
    return PowermanagerPlatform.instance.off();
  }
}
