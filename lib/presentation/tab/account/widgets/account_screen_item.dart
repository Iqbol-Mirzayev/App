import 'package:flutter/material.dart';

import '../../../../utils/ui_needs/color.dart';
import '../../../../utils/ui_needs/style.dart';


class AccountScreenItem extends StatelessWidget {
  const AccountScreenItem({Key? key, required this.text, required this.onTap})
      : super(key: key);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: MyColors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                spreadRadius: 8,
                offset: const Offset(0, 0),
                color: Colors.grey.shade200,
              )
            ]),
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Text(
          text,
          style: MyTextStyle.sfProSemibold.copyWith(
            fontSize: 18,
            color: MyColors.black,
          ),
        ),
      ),
    );
  }
}