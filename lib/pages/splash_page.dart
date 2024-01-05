import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cocktail_mix_app/main.dart';
import 'package:cocktail_mix_app/pages/home_page.dart';
import 'package:cocktail_mix_app/pages/onboarding_page.dart';

import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  //   Future.delayed(
  //     const Duration(seconds: 2),
  //     () {
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(
  //           builder: (_) => const MyHomePage(
  //                 title: 'Food',
  //               )));
  //     },
  //   );
  // }

  // @override
  // void dispose() {
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //       overlays: SystemUiOverlay.values);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 1000,
      splashIconSize: double.infinity,
      splash: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.black),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.scale(
                scale: 2.0,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/main_icon.png'))),
                ),
              ),
            ],
          ),
        ),
      ),
      nextScreen: initScreen == 0 || initScreen == null
          ? const OnBoardingScreen()
          : const HomePage(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}
