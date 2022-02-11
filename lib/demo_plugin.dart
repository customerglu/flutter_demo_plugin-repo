import 'dart:async';

import 'package:flutter/services.dart';

class DemoPlugin {
  static const MethodChannel _channel = MethodChannel('demo_plugin');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> doRegister(Map<String, dynamic> profile) async {
    return await _channel.invokeMethod('doRegister', {'profile': profile});
  }

  static Future<void> enablePrecaching() async {
    return await _channel.invokeMethod('enablePrecaching');
  }

  static Future<void> showNudges() async {
    return await _channel.invokeMethod('showNudges');
  }
}
