import 'package:demo_plugin/demo_plugin.dart';
import 'package:demo_plugin_example/LocalStore.dart';
import 'package:flutter/material.dart';

import 'cartScreen.dart';
import 'shopScreen.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TestScreen> {
  var eventproperties;
  var filter;
  String name = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stack(
          //   alignment: Alignment.center,
          //   children: [
          //     Positioned(
          //       top: 20.0,
          //       right: 0.0,
          //       child: Padding(
          //         padding: EdgeInsets.all(8.0),

          //       ),
          //     )
          //   ],
          // ),
          const SizedBox(height: 30),

          IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              boxIcon("Register", () => {registerUser()}),
              boxIcon(
                  "LoadCampaign Filter",
                  () => {
                        filter = {"type": "giftbox"},
                        DemoPlugin.loadCampaignsByFilter(filter)
                      }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              boxIcon("Wallet", () => {DemoPlugin.openWallet()}),
              boxIcon("Campaigns", () => {DemoPlugin.loadAllCampaigns()}),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            boxIcon(
                "Campaign By Id",
                () => {
                      DemoPlugin.loadCampaignById(
                          "0c114806-aeca-4e42-a475-10759b8a303e")
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => ShopScreen()))
                    }),
            boxIcon(
                "Send Events",
                () => {
                      eventproperties = {"dd": "hh"},
                      DemoPlugin.sendEventData(
                          "completePurchase", eventproperties)
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => CartScreen()))
                    }),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              boxIcon("setBannerImage",
                  () => {DemoPlugin.setDefaultBannerImage("")}),
              boxIcon("LoaderColour",
                  () => {DemoPlugin.configureLoaderColour("#F089b2")}),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              boxIcon("closeWebview",
                  () => {DemoPlugin.closeWebviewOnDeeplinkEvent(true)}),
              boxIcon("disableGluSdk", () => {DemoPlugin.disableGluSdk(true)}),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              boxIcon(
                  "enablePrecaching", () => {DemoPlugin.enablePrecaching()}),
              boxIcon(
                  "getReferralId", () => {DemoPlugin.getReferralId("true")}),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              boxIcon("enableAnalyticsEvent",
                  () => {DemoPlugin.enableAnalyticsEvent(true)}),
              boxIcon("updateProfile", () => {updateProfile()}),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              boxIcon(
                  "Safe Area",
                  () => {
                        DemoPlugin.configureSafeArea(
                            50, 30, "#FF0Ebc", "#FF0ENJ")
                      }),
            ],
          ),
        ],
      ),
    ));
  }
}

registerUser() async {
  String fcm = await LocalStore().getAppSharePopUp();
  var profile = {'userId': 'JohnWick2087', 'firebaseToken': fcm};
  DemoPlugin.isFcmApn("fcm");
  DemoPlugin.setApnFcmToken("", fcm);
  bool is_registered = await DemoPlugin.doRegister(profile, true);
  if (is_registered) {
    print("----------================-------------");
    print("Flutter res - ");
  }
}

updateProfile() async {
  String fcm = await LocalStore().getAppSharePopUp();
  var profile = {'userId': 'JohnWick2080', 'firebaseToken': fcm};
  DemoPlugin.isFcmApn("fcm");
  DemoPlugin.setApnFcmToken("", fcm);
  await DemoPlugin.updateProfile(profile);
}

Widget boxIcon(label, callback) {
  return GestureDetector(
    onTap: () => {callback()},
    child: Card(
      elevation: 3,
      child: Container(
        height: 50,
        width: 180,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
