#import "RetrofitPlugin.h"
#if __has_include(<retrofit_plugin/retrofit_plugin-Swift.h>)
#import <retrofit_plugin/retrofit_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "retrofit_plugin-Swift.h"
#endif

@implementation RetrofitPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftRetrofitPlugin registerWithRegistrar:registrar];
}
@end
