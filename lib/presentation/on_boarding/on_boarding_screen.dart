import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController controller = PageController();
  int activePage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.C_0001FC,
      appBar: const FlatAppBar(),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              children: const [
                BoardingPageOne(),
                BoardingPageTwo(),
                BoardingPageThree(),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getRoundedWidget(activePage == 0),
              const SizedBox(width: 5),
              getRoundedWidget(activePage == 1),
              const SizedBox(width: 5),
              getRoundedWidget(activePage == 2),
            ],
          ),
          TextButton(
            onPressed: () {
              if (activePage < 2) {
                setState(() {
                  activePage++;
                });
                controller.jumpToPage(activePage);
              } else {
                Navigator.pushReplacementNamed(context, mainPage);
              }
            },
            child: Text(
              "Next",
              style: MyTextStyle.sfProSemibold
                  .copyWith(fontSize: 16, color: MyColors.white),
            ),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget getRoundedWidget(bool isActive) {
    if (isActive) {
      return Container(
        height: 8,
        width: 8,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: MyColors.white),
      );
    } else {
      return Container(
        height: 6,
        width: 6,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: MyColors.white.withOpacity(0.32)),
      );
    }
  }
}