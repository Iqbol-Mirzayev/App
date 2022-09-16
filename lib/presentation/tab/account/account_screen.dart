import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../../utils/ui_needs/color.dart';
import '../../widgets/flat_appbar_text.dart';
import 'widgets/account_screen_item.dart';
import 'widgets/account_top_view.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    var user = context.watch<User?>();
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: const FlatAppBarText(
        title: "Account",
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            AccountTopView(user: user!),
            const SizedBox(height: 32),
            AccountScreenItem(
              text: "Account Information",
              onTap: () => Navigator.pushNamed(context, profilePage),
            ),
            AccountScreenItem(text: "Orders history", onTap: () {}),
            AccountScreenItem(
              text: "Security and Settings",
              onTap: () => Navigator.pushNamed(context, settingsPage),
            ),
            AccountScreenItem(
                text: "Help",
                onTap: () {
                  Navigator.pushNamed(context, chatPage);
                }),
          ],
        ),
      ),
    );
  }
}