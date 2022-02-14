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

  static Future<void> setDefaultBannerImage() async {
    return await _channel.invokeMethod('setDefaultBannerImage');
  }

  static Future<void> configureLoaderColour(String color) async {
    return await _channel.invokeMethod('configureLoaderColour', color);
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
  static Future<void> doRegister(Map<String, dynamic> profile) async {
    return await _channel.invokeMethod('doRegister', {'profile': profile});
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
  static Future<void> displayCustomerGluNotification() async {
    return await _channel.invokeMethod('displayCustomerGluNotification');
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
