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

  static Future<void> disableGluSdk(bool value) async {
    return await _channel.invokeMethod('disableGluSdk', value);
  }

  static Future<void> isFcmApn(String value) async {
    return await _channel.invokeMethod('isFcmApn', value);
  }

  static Future<void> enablePrecaching() async {
    return await _channel.invokeMethod('enablePrecaching');
  }

  static Future<void> configureSafeArea(int topHeight, int bottomHeight,
      String topSafeAreaColor, String bottomSafeAreaColor) async {
    return await _channel.invokeMethod('configureSafeArea', <String, dynamic>{
      'topHeight': topHeight,
      'bottomHeight': bottomHeight,
      'topSafeAreaColor': topSafeAreaColor,
      'bottomSafeAreaColor': bottomSafeAreaColor
    });
  }

  static Future<void> setApnFcmToken(String apntoken, String fcmtoken) async {
    return await _channel.invokeMethod('setApnFcmToken', <String, dynamic>{
      'apntoken': apntoken,
      'fcmtoken': fcmtoken
    });
  }

  /* Api Methods  */
  static Future<bool> doRegister(
      Map<String, dynamic> profile, bool loadCampaigns) async {
    print("res--------------- " + profile.toString());
    String res = await _channel.invokeMethod('doRegister',
        <String, dynamic>{'profile': profile, "loadCampaigns": loadCampaigns});
    print("res1 " + res);
    if (res == "true") {
      return true;
    }

    return false;
  }

  static Future<String> getReferralId(var dynamicLink) async {
    String res = await _channel.invokeMethod('getReferralId', dynamicLink);
    return res;
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
  static Future<void> displayCustomerGluNotification(
      Map<String, dynamic> message) async {
    return await _channel.invokeMethod('displayCustomerGluNotification',
        <String, dynamic>{"message": message});
  }

    static Future<void> displayBackgroundNotification(
      Map<String, dynamic> message) async {
    return await _channel.invokeMethod('displayBackgroundNotification',
        <String, dynamic>{"message": message});
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

  static Future<void> enableAnalyticsEvent(bool value) async {
    return await _channel.invokeMethod('enableAnalyticsEvent', value);
  }

  static Future<void> clearGluData() async {
    return await _channel.invokeMethod('clearGluData');
  }

  static Future<void> loadCampaignsByType(String type) async {
    return await _channel.invokeMethod('loadCampaignsByType', type);
  }

  static Future<void> loadCampaignByStatus(String status) async {
    return await _channel.invokeMethod('loadCampaignByStatus', status);
  }
}
