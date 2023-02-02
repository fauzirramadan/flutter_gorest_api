import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gorest_api/data/helper/either.dart';
import 'package:flutter_gorest_api/data/helper/failure.dart';
import 'package:flutter_gorest_api/data/repository/general_repo.dart';
import 'package:flutter_gorest_api/utils/nav_utils.dart';
import 'package:flutter_gorest_api/utils/notif_utils.dart';

import '../data/model/user.dart';

class UserProvider extends ChangeNotifier {
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

  Future<void> addOrUpdateUser({bool? isUpdate}) async {
    try {
      isLoading = true;
      notifyListeners();
      Either<Failure, User> res = await _repo.addOrUpdateUser(
          name: _nameC.text,
          email: _emailC.text,
          gender: _genderC.text,
          status: _statusC.text,
          isUpdate: isUpdate ?? false);
      res.when(error: (f) {
        isLoading = false;
        notifyListeners();
        log(f.message);
        NotifUtils.showSnackbar(f.message, backgroundColor: Colors.red);
      }, success: (data) {
        isLoading = false;
        notifyListeners();
        NotifUtils.showSnackbar("Success Create User");
        Nav.back();
      });
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log(e.toString());
      NotifUtils.showSnackbar(e.toString(), backgroundColor: Colors.red);
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
