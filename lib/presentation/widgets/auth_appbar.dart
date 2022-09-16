import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/ui_needs/color.dart';
import '../../utils/ui_needs/style.dart';

class AuthAppBar extends StatelessWidget implements PreferredSize {
  const AuthAppBar({Key? key, required this.text}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyColors.C_0001FC,
      elevation: 0,
      centerTitle: true,
      title: Text(text,style:MyTextStyle.sfProSemibold
          .copyWith(fontSize: 20, color: MyColors.white),),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: MyColors.C_0001FC,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);

  @override
  Widget get child => throw UnimplementedError();
}