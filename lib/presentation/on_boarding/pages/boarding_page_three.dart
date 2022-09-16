import 'package:flutter/material.dart';

class BoardingPageThree extends StatelessWidget {
  const BoardingPageThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(MyIcons.boardingPageThree),
          const SizedBox(
            height: 100,
          ),
          Text(
            "Sales all the time",
            style: MyTextStyle.sfProSemibold
                .copyWith(fontSize: 20, color: MyColors.white),
          ),
        ],
      ),
    );
  }
}
