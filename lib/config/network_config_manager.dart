import 'dart:collection';

import 'package:retrofit_plugin/retrofit_plugin.dart';

///网络请求公共配置， 以域名区分

abstract class NetWorkConfigManager {
  static HashMap<String, NetWorkConfig> _configs = HashMap();

  static void addDefault(NetWorkConfig config) {
    addConfig("default", config);
  }

  static void addConfig(String key, NetWorkConfig config) {
    _configs.putIfAbsent(key, () => config);
  }

  static NetWorkConfig getConfig({String domainKey}) {
    var config = _configs[domainKey];
    return config == null ? _configs["default"] : config;
  }
}

class NetWorkConfig {
  final String baseUrl;
  final Map<String, String> headers;
  final NetworkIntercept intercept;

  NetWorkConfig({
    this.baseUrl,
    this.headers,
    this.intercept,
  });
}
