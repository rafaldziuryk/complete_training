//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <native_plugin/native_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) native_plugin_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "NativePlugin");
  native_plugin_register_with_registrar(native_plugin_registrar);
}
