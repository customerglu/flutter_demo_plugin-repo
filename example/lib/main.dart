import 'package:demo_plugin_example/homeScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:demo_plugin/demo_plugin.dart';
import 'package:demo_plugin/banner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  static const broadcast_channel = MethodChannel("broadcast_channel");
  static const event_channel = EventChannel("broadcast_streamer");

  @override
  void initState() {
    super.initState();
    onStreamRecieved();
  }

  static const EventChannel _eventChannel = EventChannel("CustomerGlu");
  late StreamSubscription _mystream;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      var profile = {'userId': 'JohnWick'};
      await DemoPlugin.getInstance();
      await DemoPlugin.doRegister(profile);
      // await DemoPlugin.enablePrecaching();
      await DemoPlugin.configureLoaderColour("#FFH08H");


      //   await DemoPlugin.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
    });




  }
  Future<void> openWallet() async {
    await DemoPlugin.openWallet();
  }

  @override
  Widget build(BuildContext context) {
    // listenBroadcast();

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: '',)
    );
  }

  void listenBroadcast() {
    broadcast_channel.setMethodCallHandler((call) async {
      if (call.method == "broadcast_message") {
        print("==============+++++++++==========");
        print(call.arguments);
      }
    });
  }

  void onStreamRecieved() {
    _mystream = event_channel.receiveBroadcastStream().listen((event) {
      print("s+++++++++++++++++++++++_---------------");
      print(event);
    });
  }
}
