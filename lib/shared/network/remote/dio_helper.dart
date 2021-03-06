import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        //baseUrl: 'https://student.valuxapps.com/api/',
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
      ),
    );
  }

  static Future<Response> getData({
    String? url,
    Map<String, dynamic>? query,
    String? lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

    return await dio!.get(
      url!,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    String? url,
    Map<String, dynamic>? query,
    required dynamic data,
    String? lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

    return await dio!.post(
      url!,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    String? url,
    Map<String, dynamic>? query,
    required dynamic data,
    String? lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

    return await dio!.put(
      url!,
      queryParameters: query,
      data: data,
    );
  }
}
