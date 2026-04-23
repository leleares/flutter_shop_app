import 'package:dio/dio.dart';
import 'package:flutter_shop_app/constants/index.dart';

class Diorequest {
  final Dio _dio = Dio();

  Diorequest() {
    // 配置基础地址拦截器
    _dio.options.baseUrl = GlobalConstants.BASE_URL;
    _dio.options.connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    _dio.options.sendTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    _dio.options.receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.next(options);
        },
        onResponse: (response, handler) {
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            handler.next(response);
          } else {
            handler.reject(
              DioException(requestOptions: response.requestOptions),
            );
          }
        },
        onError: (error, handler) {
          handler.reject(error);
        },
      ),
    );
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    return _handleResponse(_dio.get(url, queryParameters: params));
  }

  // 进一步处理返回结果，为了业务不再 resp.data，将 data 从中解构出来，并整合了业务状态码判断 resp 是否异常。
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    Response<dynamic> taskResp = await task;
    final Map<String, dynamic> taskData = taskResp.data as Map<String, dynamic>;
    if (taskData["code"] == GlobalConstants.SUCCESS_CODE) {
      // 证明后端响应没有问题
      return taskData["result"];
    } else {
      // 异常，抛出异常
      throw Exception(taskData["result"] ?? "数据请求异常");
    }
  }
}

// 单例对象
final dioRequest = Diorequest();
