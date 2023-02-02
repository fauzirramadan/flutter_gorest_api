import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gorest_api/data/helper/either.dart';
import 'package:flutter_gorest_api/data/helper/failure.dart';
import 'package:flutter_gorest_api/data/repository/general_repo.dart';
import 'package:flutter_gorest_api/data/response/res_get_user.dart';
import 'package:flutter_gorest_api/utils/nav_utils.dart';
import 'package:flutter_gorest_api/utils/notif_utils.dart';

import '../data/model/user.dart';

class UserProvider extends ChangeNotifier {
  UserProvider(ResGetUser? dataUser) {
    init(dataUser);
  }

  final TextEditingController _nameC = TextEditingController();
  TextEditingController get nameC => _nameC;
  final TextEditingController _emailC = TextEditingController();
  TextEditingController get emailC => _emailC;
  final TextEditingController _genderC = TextEditingController();
  TextEditingController get genderC => _genderC;
  final TextEditingController _statusC = TextEditingController();
  TextEditingController get statusC => _statusC;

  final GeneralRepo _repo = GeneralRepo();
  bool isLoading = false;

  void init(ResGetUser? dataUser) {
    if (dataUser != null) {
      _nameC.text = dataUser.name ?? "";
      _emailC.text = dataUser.email ?? "";
      _genderC.text = dataUser.gender.toString().split("Gender.").last;
      _statusC.text = dataUser.status.toString().split("Status.").last;
    }
    notifyListeners();
  }

  Future<void> addOrUpdateUser({bool? isUpdate, int? id}) async {
    try {
      isLoading = true;
      notifyListeners();
      Either<Failure, User> res = await _repo.addOrUpdateUser(
          name: _nameC.text,
          email: _emailC.text,
          gender: _genderC.text,
          status: _statusC.text,
          id: id,
          isUpdate: isUpdate ?? false);
      res.when(error: (f) {
        isLoading = false;
        notifyListeners();
        log(f.message);
        NotifUtils.showSnackbar("Failed", backgroundColor: Colors.red);
      }, success: (data) {
        isLoading = false;
        notifyListeners();
        NotifUtils.showSnackbar(isUpdate == true
            ? "Success Update Data User"
            : "Success Create User");
        Nav.back();
      });
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log(e.toString());
      NotifUtils.showSnackbar("Failed", backgroundColor: Colors.red);
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      isLoading = true;
      notifyListeners();
      Response<dynamic>? res = await _repo.deleteUser(id);
      if (res?.statusCode == 204) {
        isLoading = false;
        notifyListeners();
        NotifUtils.showSnackbar("Success delete user");
        Nav.back();
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log(e.toString());
      NotifUtils.showSnackbar(e.toString(), backgroundColor: Colors.red);
    }
  }
}
