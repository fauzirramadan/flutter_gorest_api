import 'package:flutter/material.dart';
import 'package:flutter_gorest_api/data/response/res_get_user.dart';
import 'package:flutter_gorest_api/provider/user_provider.dart';
import 'package:flutter_gorest_api/view/widgets/primary_button.dart';
import 'package:flutter_gorest_api/view/widgets/textfield.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class FormPage extends StatelessWidget {
  final bool? isUpdate;
  final ResGetUser? dataUser;
  FormPage({super.key, this.isUpdate, this.dataUser});

  UserProvider? prov;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(dataUser),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 4, right: 20, left: 20),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
              padding: const EdgeInsets.all(25),
              child: Consumer<UserProvider>(builder: (context, prov, _) {
                this.prov = prov;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      controller: prov.nameC,
                      hintText: "Name",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: "Email",
                      controller: prov.emailC,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: "Gender",
                      controller: prov.genderC,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: "Status",
                      controller: prov.statusC,
                    )
                  ],
                );
              }),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: isUpdate == true ? 140 : 80,
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              isUpdate == true
                  ? PrimaryButton(
                      title: "SAVE",
                      onPressed: () => prov?.addOrUpdateUser(
                          isUpdate: true, id: dataUser?.id),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              PrimaryButton(
                onPressed: () => isUpdate == true
                    ? prov?.deleteUser(dataUser?.id ?? 0)
                    : prov?.addOrUpdateUser(),
                title: isUpdate == true ? "DELETE USER" : "ADD USER",
              )
            ],
          ),
        ),
      ),
    );
  }
}
