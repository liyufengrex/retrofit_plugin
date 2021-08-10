import 'package:retrofit_plugin/retrofit_plugin.dart';

///网络请求拦截器
abstract class NetworkIntercept {
  onResponse(Request request, Response response);
}
