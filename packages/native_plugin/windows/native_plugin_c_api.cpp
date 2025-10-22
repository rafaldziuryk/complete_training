#include "include/native_plugin/native_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "native_plugin.h"

void NativePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  native_plugin::NativePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
