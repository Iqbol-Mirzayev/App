import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/utils/ui_needs/color.dart';
import 'package:shopping/utils/ui_needs/style.dart';

import '../../../../../utils/constants.dart';
import '../../../../../utils/my_utils.dart';
import '../../../../../view_models/admin_view_model.dart';
import '../../../../../view_models/auth_view_model.dart';
import '../../../../widgets/flat_appbar_back.dart';
import '../../../../widgets/my_custom_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: const FlatAppBarBack(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Security and Settings",
              style: MyTextStyle.sfProBold
                  .copyWith(fontSize: 20, color: MyColors.black),
            ),
            const Expanded(child: SizedBox()),
            MyCustomButton(onTap: signOutTap, text: "Sign Out"),
            const SizedBox(height: 20),
            MyCustomButton(onTap: deleteAccountTap, text: "Delete Account"),
            const SizedBox(height: 20),
            MyCustomButton(
                onTap: () {
                  adminAuthDialog(onTap: () async {
                    bool isAdmin = await context
                        .read<AdminsViewModel>()
                        .isAdmin(password: password);

                    if (isAdmin) {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, adminPage);
                    } else {
                      Navigator.pop(context);
                      MyUtils.getMyToast(message: "User is not admin");
                    }

                  }, onChanged: (v) {
                    setState(() {
                      password = v;
                    });
                  });
                },
                text: "Admin page"),
          ],
        ),
      ),
    );
  }

  void deleteAccountTap() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Are you sure you want to delete your account?"),
            actions: [
              OutlinedButton(
                onPressed: () {
                  context.read<AuthViewModel>().deleteAccount(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("Yes"),
              ),
              OutlinedButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: const Text("No"),
              )
            ],
          );
        });
  }

  void signOutTap() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure you want to Sign Out?"),
          actions: [
            OutlinedButton(
              onPressed: () {
                context.read<AuthViewModel>().signOut(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("Yes"),
            ),
            OutlinedButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: const Text("No"),
            )
          ],
        );
      },
    );
  }

  void adminAuthDialog({
    required ValueChanged<String> onChanged,
    required VoidCallback onTap,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Enter admin password",
                      hintStyle:
                          TextStyle(color: Colors.grey.shade400, fontSize: 14)),
                  onChanged: (v) {
                    onChanged.call(v);
                  },
                  textAlign: TextAlign.center,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(onPressed: onTap, child: const Text("Enter"))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}