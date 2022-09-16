import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/ui_needs/color.dart';
import '../../utils/ui_needs/style.dart';


class FlatAppBarText extends StatelessWidget implements PreferredSize {
  const FlatAppBarText({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyColors.white,
      elevation: 0,
      title: Text(
        title,
        style:
            MyTextStyle.sfProBold.copyWith(fontSize: 28, color: MyColors.black),
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: MyColors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);

  @override
  Widget get child => throw UnimplementedError();
}