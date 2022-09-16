import 'package:flutter/material.dart';
import 'package:shopping/utils/ui_needs/color.dart';
import 'package:shopping/utils/ui_needs/style.dart';


class ProfileInfoItem extends StatelessWidget {
  const ProfileInfoItem(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.onEditTap})
      : super(key: key);

  final String title;
  final String subTitle;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Colors.grey.shade400,
              offset: const Offset(3, 4),
              spreadRadius: 5,
            )
          ]),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: MyTextStyle.sfProRegular
                        .copyWith(color: MyColors.C_0001FC, fontSize: 16)),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  subTitle,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
          IconButton(
              onPressed: onEditTap,
              icon: const Icon(
                Icons.edit,
                color: MyColors.C_0001FC,
                size: 24,
              ))
        ],
      ),
    );
  }
}