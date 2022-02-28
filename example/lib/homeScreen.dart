import 'package:demo_plugin/demo_plugin.dart';
import 'package:demo_plugin_example/LocalStore.dart';
import 'package:flutter/material.dart';

import 'cartScreen.dart';
import 'shopScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var eventproperties;
  String name = "";
  @override
  void initState() {
    super.initState();
    DemoPlugin.getInstance();
    DemoPlugin.setDefaultBannerImage(
        "https://assets.customerglu.com/demo/quiz/banner-image/Quiz_1.png");
    registerUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.8,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.black),
            ),
            Image.asset("assets/images/customerglu.jpg")
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            boxIcon("assets/images/purse.png", "Wallet",
                () => {DemoPlugin.openWallet()}),
            boxIcon("assets/images/quiz.png", "Campaigns",
                () => {DemoPlugin.loadAllCampaigns()}),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            boxIcon(
                "assets/images/onlineshopping.png",
                "Shop",
                () => {
                      DemoPlugin.loadCampaignById(
                          "410e804b-0642-4f6d-88ff-14b2e9570c38")
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => ShopScreen()))
                    }),
            boxIcon(
                "assets/images/trolley.png",
                "Cart",
                () => {
                      eventproperties = {"dd": "hh"},
                      DemoPlugin.sendEventData(
                          "completePurchase1", eventproperties)
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => CartScreen()))
                    }),
          ],
        )
      ],
    ));
  }

  registerUser() async {
    String fcm = await LocalStore().getAppSharePopUp();
    var profile = {'userId': 'JohnWick200', 'firebaseToken': fcm};

    bool is_registered = await DemoPlugin.doRegister(profile, true);
    if (is_registered) {
      print("----------================-------------");
      print("Flutter res - ");
    }
  }
}

Widget boxIcon(image, label, callback) {
  return GestureDetector(
    onTap: () => {callback()},
    child: Card(
      elevation: 3,
      child: Container(
        height: 150,
        width: 150,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  image,
                  height: 80,
                  width: 80,
                ),
                Text(
                  label,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
