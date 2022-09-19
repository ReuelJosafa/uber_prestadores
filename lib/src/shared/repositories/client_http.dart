import 'package:dio/dio.dart';

class ClientHttp {
  final dio = Dio();

  Future<Map<String, dynamic>> get(String url) async {
    final response = await dio.get(url);
    return response.data;
  }
}
