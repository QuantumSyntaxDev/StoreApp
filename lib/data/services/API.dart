import 'package:dio/dio.dart';

class Api {
  static final dio = Dio(BaseOptions(baseUrl: 'https://api.example.com'));
  static Future<Map<String, dynamic>?> post_login(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final res = await dio.post(endpoint, data: data);
    if (res.statusCode == 200 || res.statusCode == 201) {
      return res.data;
    }
    return null;
  }

  //  регистрация
  static Future<Map<String, dynamic>?> post_reg(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final res = await dio.post(endpoint, data: data);
      if (res.statusCode == 200 || res.statusCode == 201) {
        return res.data;
      }
    } on DioException catch (e) {
      return null;
    }
    return null;
  }

  static Future<List<dynamic>?> get_catalog_screen(
    String endpoint,
    String token,
  ) async {
    final res = await dio.get(
      endpoint,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    if (res.statusCode == 200) {
      return res.data;
    }
    return null;
  }
}
