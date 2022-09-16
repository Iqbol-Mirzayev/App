import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/utils/my_utils.dart';
import 'package:shopping/view_models/auth_view_model.dart';
import 'package:shopping/view_models/file_view_model.dart';     
import '../../../../../utils/ui_needs/color.dart';
import '../../../../../utils/ui_needs/style.dart';
import '../../../../widgets/flat_appbar_back.dart';
import 'widgets/profile_info_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  PlatformFile? pickedFile;

  Future<void> selectFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      pickedFile = result.files.first;
      context.read<FileViewModel>().uploadUserImage(
            pickedFile!,
            context,
          );
    } else {
      MyUtils.getMyToast(message: "File not picked");
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<User?>();
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: const FlatAppBarBack(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  "Account Information",
                  style: MyTextStyle.sfProBold
                      .copyWith(fontSize: 20, color: MyColors.black),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ClipOval(
              child: (user!.photoURL != null)
                  ? Image.network(
                      user.photoURL!,
                      width: 124,
                      height: 124,
                      fit: BoxFit.cover,
                    )
                  : const Icon(
                      Icons.person,
                      size: 124,
                      color: Colors.grey,
                    ),
            ),
            TextButton(
                onPressed: () {
                  selectFile();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Update profile image",
                      style: MyTextStyle.sfProRegular
                          .copyWith(color: MyColors.C_0001FC, fontSize: 16),
                    ),
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.edit,
                      color: MyColors.C_0001FC,
                    )
                  ],
                )),
            const SizedBox(height: 50),
            ProfileInfoItem(
              title: "Email",
              subTitle: user.email ?? "",
              onEditTap: () {
                updateFieldDialog(
                  inputValue: (v) {
                    context.read<AuthViewModel>().updateEmail(
                          context: context,
                          email: v,
                        );
                  },
                  initialText: user.email ?? "",
                );
              },
            ),
            ProfileInfoItem(
              title: "User Name",
              subTitle: user.displayName ?? "",
              onEditTap: () {
                updateFieldDialog(
                  inputValue: (v) {
                    context.read<AuthViewModel>().updateDisplayName(
                          context: context,
                          displayName: v,
                        );
                  },
                  initialText: user.displayName ?? "",
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
            height: 120,
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
                      child: Text("Cancel",
                          style: MyTextStyle.sfProRegular.copyWith(
                              color: MyColors.C_0001FC, fontSize: 16)),
                    ),
                    TextButton(
                        onPressed: () {
                          if (controller.text.isNotEmpty) {
                            inputValue.call(controller.text);
                          }
                          Navigator.pop(context);
                        },
                        child: Text("Save",
                            style: MyTextStyle.sfProRegular.copyWith(
                                color: MyColors.C_0001FC, fontSize: 16)))
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