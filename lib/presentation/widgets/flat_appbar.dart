import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/ui_needs/color.dart';

class FlatAppBar extends StatelessWidget implements PreferredSize {
  const FlatAppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyColors.C_0001FC,
      elevation: 0,
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