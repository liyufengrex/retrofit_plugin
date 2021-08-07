# retrofit_plugin

原生层 retrofit 请求能力封装

## 使用

+ 网络层配置初始化（在壳初始化后直接调用）

```
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
```
每个 domainKey 对应独立的 `netWorkConfig` 配置，每个配置会生成独立的 `retrofit` 请求实例。

+ 创建请求

示例：

```
class TestRequest extends RequestBaseLoader<String> {
  ///请求方式 Method.Get || Method.Post
  @override
  Method get method => Method.Get;

  ///接口具体路径
  @override
  String get path => "api/trans.php";

  //请求参数外层是否套 params common，默认为true
  @override
  bool get isDataEncapsulated => false;

  ///接口传参
  @override
  Map<String, dynamic> get data => {
        "msg": "你好",
      };

  @override
  Map<String, String> get header => {};

  @override
  Future<String> execute() {
    return request().then((value) {
      return value.toString();
    });
  }
}
```
+ 使用请求

```
 TestRequest().execute().then((value) {
      setState(() {
        _data = value;
      });
    });
```

通过重写 domainKey 指定 baseUrl (baseUrl 绑定在 `networkConfig` 上)

```
@override
String get domainKey => "default";
```

#### 网络超时配置

默认网络超时配置为 10s，可通过如下方式进行配置：
（ res 目录下 values 目录内，attrs 文件 ）

```
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <integer name="timeOut">10</integer>
</resources>
```

#### android 清单文件，application标签需添加属性：

`android:networkSecurityConfig="@xml/network_security_config"`

