import 'package:demo_plugin_example/LocalStore.dart';
import 'package:demo_plugin_example/homeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:demo_plugin/demo_plugin.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print("handler");
  await Firebase.initializeApp();
  print(message.data.toString());
  // initializelocalNotification();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  // final NotificationAppLaunchDetails? notificationAppLaunchDetails =
  //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  // if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
  //   //  runApp(MyApp());
  //   // selectedNotificationPayload =
  //   //     notificationAppLaunchDetails!.payload.toString();
  //   selectedNotificationPayload = await LocalStore().getAppSharePopUp();
  //   myurl = selectedNotificationPayload;
  //   print(myurl);

  //    SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
  //   runApp(MyApp());
  // });
  // } else {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}
//}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var fcmtoken = "";

  static const broadcast_channel = MethodChannel("CUSTOMERGLU_EVENTS");

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();

    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      if (message != null) {
        if (message.data["type"] != null &&
            message.data["type"] == "CustomerGlu") print("initial");
      }
    });

    var messaging = FirebaseMessaging.instance;

    messaging.getToken().then((value) {
      print("fcm token" + value.toString());
      fcmtoken = value!;
      LocalStore().setAppSharePopUp(fcmtoken);
      //Firebase Token
    });

    //  initializelocalNotification();

    FirebaseMessaging.onMessage.listen((message) {
      print(message.data);
      DemoPlugin.displayCustomerGluNotification(message.data);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("gjhgj");
      // Navigator.of(Constant.navigatorKey.currentState!.overlay!.context).push(
      //     MaterialPageRoute(
      //         builder: (context) => MyWebView(url: message.data["nudge_url"])));
    });

    broadcast_channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "CUSTOMERGLU_DEEPLINK_EVENT":
          print("CUSTOMERGLU_DEEPLINK_EVENT");
          print(call.arguments);
          break;
        case "CUSTOMERGLU_ANALYTICS_EVENT":
          print("CUSTOMERGLU_ANALYTICS_EVENT");
          print(call.arguments);

          break;
      }
    });
    DemoPlugin.enableAnalyticsEvent(true);
    DemoPlugin.configureLoaderColour("#0B66EA");
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
      await DemoPlugin.doRegister(profile, true);
      // await DemoPlugin.enablePrecaching();

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

  // Future<void> openWallet() async {
  //   await DemoPlugin.openWallet();
  // }

  @override
  Widget build(BuildContext context) {
    // listenBroadcast();

    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(
          title: '',
        ));
  }
}
