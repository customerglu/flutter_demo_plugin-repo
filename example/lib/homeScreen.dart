import 'package:demo_plugin/demo_plugin.dart';
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

  @override
  void initState()  {
    super.initState();
    var profile = {'userId': 'JohnWick'};
     DemoPlugin.getInstance();
     DemoPlugin.setDefaultBannerImage("https://assets.customerglu.com/demo/quiz/banner-image/Quiz_1.png");
     DemoPlugin.doRegister(profile);
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
            boxIcon("assets/images/purse.png", "Wallet", () => {DemoPlugin.openWallet()}),
            boxIcon("assets/images/quiz.png", "Campaigns", () => {DemoPlugin.loadAllCampaigns()}),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            boxIcon(
                "assets/images/shop.png",
                "Shop",
                () => {
                      DemoPlugin.loadCampaignById("3d7d9d7d-da0a-4d69-9c6e-6f9c24b19ba9")
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => ShopScreen()))
                    }),
            boxIcon(
                "assets/images/trolley.png",
                "Cart",
                () => {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CartScreen()))
                    }),
          ],
        )
      ],
    ));
  }
}

Widget boxIcon(image, label, callback) {
  return GestureDetector(
    onTap: () => {callback()},
    child: Card(
      elevation: 10,
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
