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
          intercept: _Intercept(),
        ));

    NetWorkConfigManager.addConfig(
        "second",
        NetWorkConfig(
          baseUrl: "https://www.apiopen.top/",
          headers: {
            "Authorization": "Bearer",
          },
          intercept: _Intercept(),
        ));
  }
}

class _Intercept extends NetworkIntercept {
  @override
  onResponse(Request request, Response response) {
    if (response.success) {
      print("log: ${request.toString()} - ${response.toString()}");
    } else {
      ///系统错误
      print("log-error: ${request.toString()} - ${response.toString()}");
    }
  }
}
