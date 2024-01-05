import 'package:cocktail_mix_app/main.dart';
import 'package:cocktail_mix_app/pages/home_page.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.4, 1],
                        colors: [Color(0xFF010101), Color(0xFF5418FF)])),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                scale: 0.4,
                                image: AssetImage('assets/glass_icon.png'),
                                fit: BoxFit.none),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text('Welcome to CocktailMix!',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 32)),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                bottom: 24,
                              ),
                              child: Text(
                                  'Get inspired, discover new ingredient combinations, and become a true cocktail master with CocktailMix!',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Color(0xFF8F8F8F),
                                      fontFamily: 'Roboto',
                                      fontSize: 16)),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const HomePage(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 60,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF5418FF),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const Text('Get started',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16)),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 42),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Terms of use  |  Privacy Policy',
                                    style: TextStyle(
                                        color: Color(0xFF9696A1),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
