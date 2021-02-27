import 'package:dio/dio.dart';
import 'dart:convert';

class Https {
  static dynamic get(String url, Map<String, dynamic> params) async {
    try {
      Response response = await Dio().get(url, queryParameters: params);
      print(response.toString());
      Map<String, dynamic> data = jsonDecode(response.toString());
      return data;
    } catch (e) {
      print(e);
      return {};
    }
  }
}
