import 'dart:collection';

///网络请求公共配置， 以域名区分

abstract class NetWorkConfigManager {
  static HashMap<String, NetWorkConfig> _configs = HashMap();

  static void addConfig(String key, NetWorkConfig config) {
    _configs.putIfAbsent(key, () => config);
  }

  static NetWorkConfig getConfig({String domainKey}) {
    var config = _configs[domainKey];
    return config == null ? _configs.values.first : config;
  }
}

class NetWorkConfig {
  final String baseUrl;
  final Map<String, String> headers;
  final Map<String, dynamic> commonParams;

  NetWorkConfig({
    this.baseUrl,
    this.headers,
    this.commonParams,
  });
}
