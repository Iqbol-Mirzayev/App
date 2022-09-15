import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/utils/constants.dart';
import 'package:shopping/utils/my_utils.dart';
import 'package:shopping/view_models/auth_view_model.dart';

import 'widgets/profile_info_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String password = "";

  @override
  Widget build(BuildContext context) {
    var user = context.watch<User?>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
        actions: [
          IconButton(
              onPressed: () {
                //Navigator.pushNamed(context, adminPage);
                adminAuthDialog(onTap: () {
                  if (password == adminPassword) {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, adminPage);
                  } else {
                    MyUtils.showSnackBar(context, "Password xato!");
                    Navigator.pop(context);
                  }
                }, onChanged: (v) {
                  setState(() {
                    password = v;
                  });
                });
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ProfileInfoItem(
              title: "Email",
              subTitle: user?.email ?? "",
              onEditTap: () {
                updateFieldDialog(
                  inputValue: (v) {
                    context.read<AuthViewModel>().updateEmail(
                          context: context,
                          email: v,
                        );
                  },
                  initialText: user?.email ?? "",
                );
              },
            ),
            ProfileInfoItem(
              title: "User Name",
              subTitle: user?.displayName ?? "",
              onEditTap: () {
                updateFieldDialog(
                  inputValue: (v) {
                    context.read<AuthViewModel>().updateDisplayName(
                          context: context,
                          displayName: v,
                        );
                  },
                  initialText: user?.displayName ?? "",
                );
              },
            ),
            ProfileInfoItem(
              title: "Password",
              subTitle: "******",
              onEditTap: () {
                updateFieldDialog(
                  inputValue: (v) {
                    context.read<AuthViewModel>().updatePassword(
                          context: context,
                          password: v,
                        );
                  },
                  initialText: "******",
                );
              },
            ),
            const Expanded(child: SizedBox()),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: signOutTap,
                    style: TextButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text(
                      "Sign Out",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextButton(
                    onPressed: deleteAccountTap,
                    style: TextButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text(
                      "Delete Account",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void updateFieldDialog(
      {required ValueChanged<String> inputValue, required String initialText}) {
    final TextEditingController controller = TextEditingController();
    controller.text = initialText;
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
                  textAlign: TextAlign.center,
                  controller: controller,
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
                    TextButton(
                        onPressed: () {
                          if (controller.text.isNotEmpty) {
                            inputValue.call(controller.text);
                          }
                          Navigator.pop(context);
                        },
                        child: const Text("Save"))
                  ],
                )
              ],
            ),
          ),
        );
      },
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
                    TextButton(onPressed: onTap, child: const Text("Login"))
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