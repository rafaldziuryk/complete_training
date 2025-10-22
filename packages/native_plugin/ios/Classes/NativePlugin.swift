import Flutter
import UIKit
import Foundation

public class NativePlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
  /// Method Channel
  private var methodChannel: FlutterMethodChannel?
  
  /// Event Channels
  private var randomNumberEventChannel: FlutterEventChannel?
  
  /// Event sinks for streaming data
  private var randomNumberEventSink: FlutterEventSink?
  
  /// Timers for periodic updates
  private var randomNumberTimer: Timer?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let instance = NativePlugin()
    
    // Method Channel
    let methodChannel = FlutterMethodChannel(name: "native_plugin", binaryMessenger: registrar.messenger())
    registrar.addMethodCallDelegate(instance, channel: methodChannel)
    instance.methodChannel = methodChannel
    
    // Event Channels
    instance.randomNumberEventChannel = FlutterEventChannel(name: "native_plugin/random_numbers", binaryMessenger: registrar.messenger())
    instance.randomNumberEventChannel?.setStreamHandler(instance)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
      
    case "calculateSum":
      let args = call.arguments as? [String: Any]
      let a = args?["a"] as? Int ?? 0
      let b = args?["b"] as? Int ?? 0
      result(a + b)
      
    case "getDeviceInfo":
      let deviceInfo: [String: Any] = [
        "brand": "Apple",
        "model": UIDevice.current.model,
        "version": UIDevice.current.systemVersion,
        "sdk": UIDevice.current.systemVersion,
        "manufacturer": "Apple",
        "name": UIDevice.current.name,
        "identifier": UIDevice.current.identifierForVendor?.uuidString ?? "unknown"
      ]
      result(deviceInfo)
      
    default:
      result(FlutterMethodNotImplemented)
    }
  }
  
  // MARK: - FlutterStreamHandler
  
  public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    if let channelName = arguments as? String {
      switch channelName {
      case "random_numbers":
        randomNumberEventSink = events
        startRandomNumberStream()
      default:
        break
      }
    }
    return nil
  }
  
  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    if let channelName = arguments as? String {
      switch channelName {
      case "random_numbers":
        randomNumberEventSink = nil
        stopRandomNumberStream()
      default:
        break
      }
    }
    return nil
  }
  
  // MARK: - Random Number Stream
  
  private func startRandomNumberStream() {
    randomNumberTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
      guard let self = self else { return }
      if let eventSink = self.randomNumberEventSink {
        let randomNumber = Int.random(in: 1...100)
        eventSink(randomNumber)
      }
    }
  }
  
  private func stopRandomNumberStream() {
    randomNumberTimer?.invalidate()
    randomNumberTimer = nil
  }
}
