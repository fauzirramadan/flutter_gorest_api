import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gorest_api/data/helper/either.dart';
import 'package:flutter_gorest_api/data/helper/failure.dart';
import 'package:flutter_gorest_api/data/model/user.dart';
import 'package:flutter_gorest_api/data/network/api.dart';
import 'package:flutter_gorest_api/data/network/dio_helper.dart';
import 'package:flutter_gorest_api/data/response/res_get_user.dart';
import 'package:flutter_gorest_api/utils/notif_utils.dart';

class GeneralRepo {
  Future<Either<Failure, List<ResGetUser>>> fetchListUser(int page,
      {String? name}) async {
    try {
      Response res = await dio.get(Api.getUserApi,
          options: Api.authorization,
          queryParameters: {"per_page": 15, "page": page, "name": name});
      return Either.success(resGetUserFromJson(jsonEncode(res.data)));
    } catch (e, st) {
      if (kDebugMode) {
        log(st.toString());
      }
      return Either.error(Failure(e.toString()));
    }
  }

  Future<Either<Failure, User>> addOrUpdateUser(
      {String? name,
      String? email,
      String? gender,
      String? status,
      int? id,
      bool isUpdate = false}) async {
    try {
      Response res = !isUpdate
          ? await dio.post(Api.getUserApi, options: Api.authorization, data: {
              "name": name,
              "email": email,
              "gender": gender,
              "status": status
            })
          : await dio.put(Api.deleteUserApi(id ?? 0),
              options: Api.authorization,
              data: {
                  "name": name,
                  "email": email,
                  "gender": gender,
                  "status": status
                });

      return Either.success(userFromJson(jsonEncode(res.data)));
    } catch (e, st) {
      if (kDebugMode) {
        log(st.toString());
      }
      return Either.error(Failure(e.toString()));
    }
  }

  Future<Response?> deleteUser(int id) async {
    try {
      Response res =
          await dio.delete(Api.deleteUserApi(id), options: Api.authorization);
      return res;
    } catch (e, st) {
      if (kDebugMode) {
        log(st.toString());
      } else {
        log(e.toString());
      }
    }
    return null;
  }
}
