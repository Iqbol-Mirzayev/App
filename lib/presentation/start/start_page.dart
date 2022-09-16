import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.C_0001FC,
      appBar: const FlatAppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "MALIKA SHOP",
              style: MyTextStyle.sfProBold
                  .copyWith(fontSize: 28, color: MyColors.white),
            ),
            const SizedBox(height: 6),
            Text(
              "TECH MARKET",
              style: MyTextStyle.sfProBold
                  .copyWith(fontSize: 12, color: MyColors.white,letterSpacing: 4),
            ),
            const SizedBox(height: 70),
            Container(
              height: 250,
              width: 250,
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.C_0001FC,
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 15,
                        color: Colors.white.withOpacity(0.4),
                        blurRadius: 50,
                        offset: Offset(8, -5))
                  ]),
              child: SvgPicture.asset(MyIcons.startPageCenter),
            ),
            const SizedBox(height: 70),
            MyWhiteButton(onTap: (){
              Navigator.pushReplacementNamed(context, onBoardingPage);
            }, text: "Let's start")
          ],
        ),
      ),
    );
  }
}