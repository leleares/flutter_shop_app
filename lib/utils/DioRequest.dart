import 'package:dio/dio.dart';
import 'package:flutter_shop_app/constants/index.dart';
import 'package:flutter_shop_app/stores/TokenManager.dart';

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
          // headers 中注入 token
          String token = tokenManager.getToken();
          if (token.isNotEmpty) {
            options.headers = {"Authorization": "Bearer $token"};
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            handler.next(response);
          } else {
            handler.reject(
              DioException(
                requestOptions: response.requestOptions,
                message: response.data["msg"],
              ),
            );
          }
        },
        onError: (error, handler) {
          // handler.reject(error);
          handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              message: error.response?.data["msg"] ?? "",
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    return _handleResponse(_dio.get(url, queryParameters: params));
  }

  Future<dynamic> post(String url, {Map<String, dynamic>? data}) {
    return _handleResponse(_dio.post(url, data: data));
  }

  // 进一步处理返回结果，为了业务不再 resp.data，将 data 从中解构出来，并整合了业务状态码判断 resp 是否异常。
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> taskResp = await task;
      final Map<String, dynamic> taskData =
          taskResp.data as Map<String, dynamic>;
      if (taskData["code"] == GlobalConstants.SUCCESS_CODE) {
        // 证明后端响应没有问题
        return taskData["result"];
      }

      throw DioException(
        requestOptions: taskResp.requestOptions,
        message: taskResp.data["msg"],
      );
    } catch (e) {
      rethrow;
    }
  }
}

// 单例对象
final dioRequest = Diorequest();
