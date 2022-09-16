import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping/utils/ui_needs/color.dart';
import 'package:shopping/utils/ui_needs/icon.dart';
import 'package:shopping/utils/ui_needs/style.dart';


class AccountTopView extends StatelessWidget {
  const AccountTopView({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          ClipOval(
            child: user.photoURL != null
                ? Image.network(
                    user.photoURL!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  )
                : SvgPicture.asset(
                    MyIcons.defaultPerson,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (user.displayName != null) ? user.displayName! : user.email!,
                style: MyTextStyle.sfProBold
                    .copyWith(fontSize: 20, color: MyColors.black),
              ),
              const SizedBox(height: 8),
              Text(
                (user.displayName != null) ? user.displayName! : user.email!,
                style: MyTextStyle.sfProRegular
                    .copyWith(fontSize: 16, color: MyColors.C_0001FC),
              ),
            ],
          )
        ],
      ),
    );
  }
}