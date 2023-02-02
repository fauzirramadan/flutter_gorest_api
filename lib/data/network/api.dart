import 'package:dio/dio.dart';

class Api {
  static final authorization = Options(headers: {
    "Authorization":
        "Bearer 65bce06e8de5bf2ecd5b76cbab7676b9aca47f78e77c1c25c91f8b76acf5a607"
  });

  static const String baseUrl = "https://gorest.co.in/public/v2";
  static const String getUserApi = "$baseUrl/users";
}
