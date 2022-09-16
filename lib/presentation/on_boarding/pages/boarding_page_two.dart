import 'package:flutter/material.dart';

class BoardingPageTwo extends StatelessWidget {
  const BoardingPageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(MyIcons.boardingPageTwo),
          Text(
            "A lot of gadgets",
            style: MyTextStyle.sfProSemibold
                .copyWith(fontSize: 20, color: MyColors.white),
          ),
        ],
      ),
    );
  }
}
