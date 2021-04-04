#import "PluginDemoPlugin.h"
#if __has_include(<plugin_demo/plugin_demo-Swift.h>)
#import <plugin_demo/plugin_demo-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "plugin_demo-Swift.h"
#endif

@implementation PluginDemoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPluginDemoPlugin registerWithRegistrar:registrar];
}
@end
