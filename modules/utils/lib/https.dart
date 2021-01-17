import 'package:dio/dio.dart';

class Https {
  static void get(String url, Map<String, dynamic> params) async {
    try {
      Response response = await Dio().get(url, queryParameters: params);
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
