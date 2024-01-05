import 'package:cocktail_mix_app/pages/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'model/conf.dart';
import 'model/notifications.dart';
import 'pages/home_page.dart';
import 'pages/ndxa.dart';

int? initScreen;
late SharedPreferences preferences;
final remoteConfig = FirebaseRemoteConfig.instance;
late SharedPreferences prefs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await isx();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: SDaxa.currentPlatform);
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 3),
    minimumFetchInterval: const Duration(seconds: 3),
  ));
  await FB().activate();
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1); //if already shown -> 1 else 0
  runApp(const MyApp());
}

late SharedPreferences prefers;
final rateCallView = InAppReview.instance;
Future<void> prefGet() async {
  prefers = await SharedPreferences.getInstance();
}

Future<void> isx() async {
  await prefGet();
  bool rateStated = prefers.getBool('rateStated') ?? false;
  if (!rateStated) {
    if (await rateCallView.isAvailable()) {
      rateCallView.requestReview();
      await prefers.setBool('rateStated', true);
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: fsdadsxsad(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data! && aab != '') {
              return ShowBonusCocktailRecipe(
                receipt: aab,
              );
            } else {
              return const SplachScreen();
            }
          } else {
            return Container(
              color: Colors.black,
              child: CupertinoActivityIndicator(),
            );
          }
        },
      ),
      builder: InAppNotifications.init(),
    );
  }
}
