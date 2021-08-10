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
  onRequest(Request request) {
    print("log: ${request.toString()}");
  }

  @override
  onResponse(Response response) {
    print("log: ${response.toString()}");
  }

  @override
  onError(String errorMsg) {
    print("log-error: $errorMsg");
  }
}
