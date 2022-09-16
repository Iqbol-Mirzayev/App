import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _init() async {
    await StorageRepository.getInstance();
    String authState = StorageRepository.getString("auth_state");
    Future.delayed(const Duration(seconds: 3), () {
      if (authState.isEmpty) {
        Navigator.pushReplacementNamed(context, startPage);
      } else {
        Navigator.pushReplacementNamed(context, mainPage);
      }
    });
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: const WhiteFlatAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(MyIcons.basketLottie),
        ],
      ),
    );
  }
}