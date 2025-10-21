package com.example.native_plugin

import android.content.Context
import android.os.Handler
import android.os.Looper
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlin.random.Random

/** NativePlugin */
class NativePlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  private lateinit var methodChannel : MethodChannel
  
  /// Event Channels for streaming data
  private lateinit var randomNumberEventChannel: EventChannel
  
  /// Context for accessing system services
  private lateinit var context: Context
  
  /// Stream handlers for each Event Channel
  private val randomNumberStreamHandler = RandomNumberStreamHandler()

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    
    // Method Channel
    methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "native_plugin")
    methodChannel.setMethodCallHandler(this)
    
    // Event Channels with individual stream handlers
    randomNumberEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "native_plugin/random_numbers")
    randomNumberEventChannel.setStreamHandler(randomNumberStreamHandler)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      "calculateSum" -> {
        val a = call.argument<Int>("a") ?: 0
        val b = call.argument<Int>("b") ?: 0
        result.success(a + b)
      }
      "getDeviceInfo" -> {
        val deviceInfo = mapOf(
          "brand" to android.os.Build.BRAND,
          "model" to android.os.Build.MODEL,
          "version" to android.os.Build.VERSION.RELEASE,
          "sdk" to android.os.Build.VERSION.SDK_INT,
          "manufacturer" to android.os.Build.MANUFACTURER
        )
        result.success(deviceInfo)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    methodChannel.setMethodCallHandler(null)
    randomNumberEventChannel.setStreamHandler(null)
    
    // Stop all monitoring
    stopAllMonitoring()
  }

  private fun stopAllMonitoring() {
    randomNumberStreamHandler.stopStream()
  }

  // Random Number Stream Handler
  inner class RandomNumberStreamHandler : EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null
    private var runnable: Runnable? = null
    private val handler = Handler(Looper.getMainLooper())

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
      eventSink = events
      startStream()
    }

    override fun onCancel(arguments: Any?) {
      eventSink = null
      stopStream()
    }

    private fun startStream() {
      runnable = object : Runnable {
        override fun run() {
          if (eventSink != null) {
            val randomNumber = Random.nextInt(1, 101) // 1-100
            eventSink?.success(randomNumber)
            handler.postDelayed(this, 1000) // Send every second
          }
        }
      }
      handler.post(runnable!!)
    }

    fun stopStream() {
      runnable?.let { handler.removeCallbacks(it) }
      runnable = null
    }
  }

}
