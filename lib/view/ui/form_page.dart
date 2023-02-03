import 'package:flutter/material.dart';
import 'package:flutter_gorest_api/data/response/res_get_user.dart';
import 'package:flutter_gorest_api/provider/user_provider.dart';
import 'package:flutter_gorest_api/view/widgets/loading_view.dart';
import 'package:flutter_gorest_api/view/widgets/primary_button.dart';
import 'package:flutter_gorest_api/view/widgets/textfield.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class FormPage extends StatelessWidget {
  final bool? isUpdate;
  final ResGetUser? dataUser;
  FormPage({super.key, this.isUpdate, this.dataUser});

  UserProvider? prov;
  final GlobalKey<FormState> _keyForm = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(dataUser),
      child: Form(
        key: _keyForm,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 4,
                right: 20,
                left: 20),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                padding: const EdgeInsets.all(25),
                child: Consumer<UserProvider>(builder: (context, prov, _) {
                  this.prov = prov;
                  return prov.isLoading
                      ? const LoadingCircular()
                      : Column(
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
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Must be fill";
                                }
                                if (!val.contains("@")) {
                                  return "Email not valid";
                                }
                                return null;
                              },
                              hintText: "Email",
                              controller: prov.emailC,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              hintText: "Gender",
                              controller: prov.genderC,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Must be fill";
                                }
                                if (!val.contains(
                                        Gender.MALE.name.toLowerCase()) &&
                                    !val.contains(
                                        Gender.FEMALE.name.toLowerCase())) {
                                  return "Only male or female";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              hintText: "Status",
                              controller: prov.statusC,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Must be fill";
                                }
                                if (!val.contains(
                                        Status.ACTIVE.name.toLowerCase()) &&
                                    !val.contains(
                                        Status.INACTIVE.name.toLowerCase())) {
                                  return "Only active or inactive";
                                }
                                return null;
                              },
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
                        onPressed: () {
                          final bool isValid =
                              _keyForm.currentState!.validate();
                          if (isValid) {
                            prov?.addOrUpdateUser(
                                isUpdate: true, id: dataUser?.id);
                          }
                        })
                    : const SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                PrimaryButton(
                  onPressed: () {
                    final bool isValid = _keyForm.currentState!.validate();
                    if (isUpdate == true) {
                      prov?.deleteUser(dataUser?.id ?? 0);
                    } else {
                      if (isValid) {
                        prov?.addOrUpdateUser();
                      }
                    }
                  },
                  title: isUpdate == true ? "DELETE USER" : "ADD USER",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
