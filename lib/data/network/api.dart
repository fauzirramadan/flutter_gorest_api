import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  static final authorization =
      Options(headers: {"Authorization": "Bearer ${dotenv.env['Api_Key']}"});

  static const String baseUrl = "https://gorest.co.in/public/v2";
  static const String getUserApi = "$baseUrl/users";
  static String deleteUserApi(int id) => "$getUserApi/$id";
}
