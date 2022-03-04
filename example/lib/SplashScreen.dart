import 'dart:async';

import 'package:flutter/material.dart';

import 'homeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  String _versionName = 'V1.0';
  final splashDelay = 5;
  bool bacKground = false;
  String token = "";
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addObserver(this);
    setupInitial();
  }

  setupInitial() async {
    _loadWidget();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //  super.didChangeAppLifecycleState(state);
    bacKground = state == AppLifecycleState.paused;
    print(state);
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => const MyHomePage(
                  title: '',
                )),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: Center(
            child: Image.asset(
              'assets/images/customerglu.jpg',
              height: 150,
              width: 150,
            ),
          ),
        ));
  }
}
