import 'dart:async';

import 'package:flutter/services.dart';

class DemoPlugin {
  static const MethodChannel _channel = MethodChannel('demo_plugin');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /* Configuration Methods  */

  static Future<void> getInstance() async {
    return await _channel.invokeMethod('getInstance');
  }

  static Future<void> setDefaultBannerImage(var image_url) async {
    print(image_url);
    return await _channel.invokeMethod('setDefaultBannerImage', image_url);
  }

  static Future<void> configureLoaderColour(String color) async {
    return await _channel.invokeMethod(
        'configureLoaderColour', color.toString());
  }

  static Future<void> closeWebviewOnDeeplinkEvent(bool value) async {
    return await _channel.invokeMethod('closeWebviewOnDeeplinkEvent', value);
  }

  static Future<void> disableGluSdk() async {
    return await _channel.invokeMethod('disableGluSdk');
  }

  static Future<void> isFcmApn(String value) async {
    return await _channel.invokeMethod('isFcmApn', value);
  }

  static Future<void> enablePrecaching() async {
    return await _channel.invokeMethod('enablePrecaching');
  }

  static Future<void> configureSafeArea(Map<String, dynamic> values) async {
    return await _channel.invokeMethod('configureSafeArea', {'values': values});
  }

  /* Api Methods  */
  static Future<bool> doRegister(
      Map<String, dynamic> profile, bool loadCampaigns) async {
    print("res---------------");
    String res = await _channel.invokeMethod('doRegister',
        <String, dynamic>{'profile': profile, "loadCampaigns": loadCampaigns});
    print("res1 " + res);
    if (res == "true") {
      return true;
    }

    return false;
  }

  static Future<void> updateProfile(Map<String, dynamic> profile) async {
    return await _channel.invokeMethod('updateProfile', {'profile': profile});
  }

  static Future<void> sendEventData(
      String eventName, Map<String, dynamic> eventproperties) async {
    return await _channel.invokeMethod('sendEventData', <String, dynamic>{
      'eventName': eventName,
      'eventData': eventproperties
    });
  }

/* Handle Notifications Methods  */
  static Future<void> displayCustomerGluNotification(String message) async {
    return await _channel.invokeMethod(
        'displayCustomerGluNotification', message);
  }

  static Future<void> getReferralId(var dynamicLink) async {
    return await _channel.invokeMethod('getReferralId', dynamicLink);
  }

  /* Load Campaigns Methods  */

  static Future<void> openWallet() async {
    return await _channel.invokeMethod('openWallet');
  }

  static Future<void> loadAllCampaigns() async {
    return await _channel.invokeMethod('loadAllCampaigns');
  }

  static Future<void> loadCampaignById(String campaignId) async {
    return await _channel.invokeMethod('loadCampaignById', campaignId);
  }

  static Future<void> loadCampaignsByFilter(
      Map<String, dynamic> filterData) async {
    return await _channel
        .invokeMethod('loadCampaignsByFilter', {'filters': filterData});
  }
}
