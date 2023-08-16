import Flutter
import UIKit

public class PowermanagerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "powermanager", binaryMessenger: registrar.messenger())
    let instance = PowermanagerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if (call.method == "on") {
      UIDevice.current.isProximityMonitoringEnabled = true
      result(true)
    }
    if (call.method == "off") {
      UIDevice.current.isProximityMonitoringEnabled = false
      result(true)
    }
  }
}
