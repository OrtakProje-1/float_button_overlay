import 'dart:async';

import 'package:flutter/services.dart';

typedef String OnClickListener(String tag);

class FloatButtonOverlay {
  static const MethodChannel _channel =
      const MethodChannel('br.ndz.float_button_overlay');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static void get checkPermissions {
    _channel.invokeMethod('checkPermissions');
  }

  static Future<bool> openOverlay(
      {String iconPath,
      String packageName,
      String activityName,
      String notificationText,
      String notificationTitle}) async {
    final Map<String, dynamic> params = <String, String>{
      'packageName': packageName,
      'activityName': activityName,
      'iconPath': iconPath,
      'notificationTitle': notificationTitle,
      'notificationText': notificationText
    };
    return await _channel.invokeMethod('openOverlay', params);
  }

  static Future<String> get closeOverlay async {
    final String retorno = await _channel.invokeMethod('closeOverlay');
    print("PlatformChannel returns: $retorno");
    return retorno;
  }

  static Future<bool> registerCallback(OnClickListener callBackFunction) async {
    _channel.setMethodCallHandler((MethodCall call) {
      switch (call.method) {
        case "callback":
          callBackFunction;
          break;
      }
    });
    return true;
  }

  static Future<bool> openAppByPackage(String packageName) async {
    final Map<String, String> params = <String, String>{
      'packageName': packageName,
    };
    return await _channel.invokeMethod('openAppByPackage', params);
  }
}
