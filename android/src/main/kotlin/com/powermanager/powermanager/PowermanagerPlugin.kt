package com.powermanager.powermanager

import android.content.Context
import android.os.PowerManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** PowermanagerPlugin */
class PowermanagerPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var applicationContext: Context
  private lateinit var channel : MethodChannel
  private lateinit var powerManager: PowerManager
  private lateinit var lock: PowerManager.WakeLock

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    applicationContext = flutterPluginBinding.getApplicationContext();
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "powermanager")
    channel.setMethodCallHandler(this)
    powerManager = applicationContext.getSystemService(Context.POWER_SERVICE) as PowerManager
    if(powerManager.isWakeLockLevelSupported(PowerManager.PROXIMITY_SCREEN_OFF_WAKE_LOCK)) {
      lock = powerManager.newWakeLock(PowerManager.PROXIMITY_SCREEN_OFF_WAKE_LOCK,"PROXIMITYSCREENOFFWAKELOCK")
      lock.setReferenceCounted(false)
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "on") {
      if(powerManager.isWakeLockLevelSupported(PowerManager.PROXIMITY_SCREEN_OFF_WAKE_LOCK)) {
        if(lock.isHeld) {
          lock.release(1)
        }
        lock.acquire()
        result.success(true)
      } else {
        result.error("notSupported", "PowerManager PROXIMITY_SCREEN_OFF_WAKE_LOCK is notSupported", null)
      }
    } else {
      result.notImplemented()
    }
    if (call.method == "off") {
      if(powerManager.isWakeLockLevelSupported(PowerManager.PROXIMITY_SCREEN_OFF_WAKE_LOCK)) {
        if(lock.isHeld) {
          lock.release(1)
          result.success(true)
        }
      } else {
        result.error("notSupported", "PowerManager PROXIMITY_SCREEN_OFF_WAKE_LOCK is notSupported", null)
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    if(::lock.isInitialized) {
      if(lock.isHeld) {
        lock.release(1)
      }
    }
    channel.setMethodCallHandler(null)
  }
}
