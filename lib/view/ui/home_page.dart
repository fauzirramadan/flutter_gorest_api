import 'package:flutter/material.dart';
import 'package:flutter_gorest_api/data/response/res_get_user.dart';
import 'package:flutter_gorest_api/provider/home_provider.dart';
import 'package:flutter_gorest_api/utils/nav_utils.dart';
import 'package:flutter_gorest_api/view/ui/form_page.dart';
import 'package:flutter_gorest_api/view/widgets/loading_view.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../widgets/textfield.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (
        context,
      ) =>
          HomeProvider(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Nav.to(FormPage()),
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Consumer<HomeProvider>(builder: (context, prov, _) {
              return prov.isLoading
                  ? const LoadingCircular()
                  : Column(
                      children: [
                        CustomTextField(
                          controller: prov.searchController,
                          hintText: "Search User",
                          suffixIcon: const Icon(Icons.search),
                          onSubmitted: (val) => prov.getUser(name: val),
                          onChanged: (val) {
                            if (val.isEmpty) {
                              prov.getUser();
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        prov.listUser.isEmpty
                            ? const SizedBox()
                            : const Text(
                                "PULL TO REFRESH",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        prov.listUser.isEmpty
                            ? Padding(
                                padding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).size.height / 4),
                                child: const Center(
                                  child: Text("NO DATA :("),
                                ),
                              )
                            : Expanded(
                                child: SmartRefresher(
                                  header: const WaterDropMaterialHeader(),
                                  controller: prov.refreshController,
                                  onRefresh: () async {
                                    await prov.getUser();
                                    prov.refreshController.refreshCompleted();
                                  },
                                  child: ListView.builder(
                                      controller: prov.scrollController,
                                      itemCount: prov.listUser.length,
                                      itemBuilder: (context, index) {
                                        final dataUser = prov.listUser[index];
                                        return GestureDetector(
                                            onTap: () => Nav.to(FormPage(
                                                  isUpdate: true,
                                                  dataUser: dataUser,
                                                )),
                                            child: myBox(dataUser));
                                      }),
                                ),
                              ),
                        prov.isLoadMore
                            ? const LoadingCircular()
                            : const SizedBox()
                      ],
                    );
            }),
          ),
        ),
      ),
    );
  }

  Container myBox(ResGetUser dataUser) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("ID : ${dataUser.id}"),
          const SizedBox(
            height: 8,
          ),
          Text("Name : ${dataUser.name}"),
          const SizedBox(
            height: 8,
          ),
          Text("Email : ${dataUser.email}"),
          const SizedBox(
            height: 8,
          ),
          Text("Gender : ${dataUser.gender.toString().split("Gender.").last}"),
          const SizedBox(
            height: 8,
          ),
          Text("Status : ${dataUser.status.toString().split("Status.").last}")
        ],
      ),
    );
  }
}
