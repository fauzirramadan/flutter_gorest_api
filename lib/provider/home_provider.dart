import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gorest_api/data/helper/either.dart';
import 'package:flutter_gorest_api/data/helper/failure.dart';
import 'package:flutter_gorest_api/data/repository/general_repo.dart';
import 'package:flutter_gorest_api/data/response/res_get_user.dart';
import 'package:flutter_gorest_api/utils/notif_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    init();
  }

  bool isLoading = false;
  bool isLoadMore = false;
  int page = 1;
  final GeneralRepo _repo = GeneralRepo();
  List<ResGetUser> listUser = [];

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;
  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  final RefreshController _refreshController = RefreshController();
  RefreshController get refreshController => _refreshController;

  void init() async {
    await getUser();
    _scrollController.addListener(() {
      if (scrollController.hasClients) {
        if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent) {
          loadMore();
        }
      }
    });
  }

  Future<void> getUser({String? name}) async {
    try {
      isLoading = true;
      notifyListeners();
      Either<Failure, List<ResGetUser>> res =
          await _repo.fetchListUser(page, name: name);
      res.when(error: (f) {
        isLoading = false;
        notifyListeners();
        log(f.message);
        NotifUtils.showSnackbar(f.message, backgroundColor: Colors.red);
      }, success: (data) {
        isLoading = false;
        notifyListeners();
        if (name != null) {
          listUser = data
              .where((element) =>
                  element.name!.toLowerCase().contains(name.toLowerCase()))
              .toList();
        } else {
          listUser = data;
        }
      });
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log(e.toString());
      NotifUtils.showSnackbar(e.toString(), backgroundColor: Colors.red);
    }
  }

  Future<void> loadMore() async {
    try {
      isLoadMore = true;
      notifyListeners();
      Either<Failure, List<ResGetUser>> res =
          await _repo.fetchListUser(page + 1);
      res.when(error: (f) {
        isLoadMore = false;
        notifyListeners();
        log(f.message);
        NotifUtils.showSnackbar(f.message, backgroundColor: Colors.red);
      }, success: (data) {
        isLoadMore = false;
        page++;
        listUser.addAll(data);
        notifyListeners();
      });
    } catch (e) {
      isLoadMore = false;
      notifyListeners();
      log(e.toString());
      NotifUtils.showSnackbar(e.toString(), backgroundColor: Colors.red);
    }
  }
}
