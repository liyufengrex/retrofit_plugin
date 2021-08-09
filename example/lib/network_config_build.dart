import 'package:retrofit_plugin/retrofit_plugin.dart';

abstract class NetWorkConfigBuild {
  static void init() {
    NetWorkConfigManager.addConfig(
        "default",
        NetWorkConfig(
          baseUrl: "http://api.wpbom.com/",
          //公共头部
          headers: {
            "Authorization": "Bearer",
          },
        ));
  }
}
