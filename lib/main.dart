import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:terrescience/utils/Constant.dart';
import 'package:terrescience/video_show.dart';
import 'package:terrescience/web_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child);
      },
      title: 'TerreScience',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  /*Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: MyWebView(
                title: "TerreScience",
                selectedUrl: "https://terrescience.com",
              ),
      title: Text(
        "",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: Image.asset("images/appLogo.png"),
      backgroundColor: Colors.black,
      photoSize: 100.0,
      loaderColor: Colors.white,
    );
  }*/
  Future<void> initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      goToNextPage();
    });
  }

  Future<void> goToNextPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(Constants.IS_VIDEO_SHOW) == "1") {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => MyWebView(
            title: "TerreScience",
            selectedUrl: "https://terrescience.com",
          ),
        ));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) =>
              VideoPlayerScreen() /*MyWebView(
          title: "TerreScience",
          selectedUrl: "https://terrescience.com",
        )*/
          ,
        ));
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo here
            Image.asset(
              'images/appLogo.png',
              height: 80,
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset(
              'images/titleversion.png',
              height: 250,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
