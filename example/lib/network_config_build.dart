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
          //param里面的公共参数，一般无用
          commonParams: {},
        ));
  }
}
