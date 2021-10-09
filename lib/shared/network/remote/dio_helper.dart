import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postData({
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    required String url,
    String lang = 'en',
    String? token,
  }) async {
    return dio.post(
      url,
      data: data,
      queryParameters: query,
      options: Options(
        headers: {
          'lang': lang,
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    String? token,
    Map<String, dynamic>? query,
  }) {
    return dio.get(
      url,
      options: Options(
        headers: {
          'lang':'en',
          'Content-Type':'application/json',
          'Authorization':token??'',
        },
      ),
      queryParameters: query,
    );
  }

  static Future<Response> putData({
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    required String url,
    String lang = 'en',
    String? token,
  }) async {
    return dio.put(
      url,
      data: data,
      queryParameters: query,
      options: Options(
        headers: {
          'lang': lang,
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
      ),
    );
  }
}
