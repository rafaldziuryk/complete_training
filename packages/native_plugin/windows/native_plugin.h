#ifndef FLUTTER_PLUGIN_NATIVE_PLUGIN_H_
#define FLUTTER_PLUGIN_NATIVE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace native_plugin {

class NativePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  NativePlugin();

  virtual ~NativePlugin();

  // Disallow copy and assign.
  NativePlugin(const NativePlugin&) = delete;
  NativePlugin& operator=(const NativePlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace native_plugin

#endif  // FLUTTER_PLUGIN_NATIVE_PLUGIN_H_
