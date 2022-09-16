import 'package:flutter/material.dart';


class BoardingPageOne extends StatelessWidget {
  const BoardingPageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         const SizedBox(height: 150,),
          Image.asset(
            MyIcons.boardingPageOne,
          ),
          const SizedBox(height: 120,),
          Text(
            "The best tech market",
            style: MyTextStyle.sfProSemibold
                .copyWith(fontSize: 20, color: MyColors.white),
          ),
        ],
      ),
    );
  }
}