import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class EnvironmentUtil {
  static Future<bool> runningOnPhysicalDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      if (iosInfo.isPhysicalDevice) {
        return true;
      }
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.isPhysicalDevice != null && androidInfo.isPhysicalDevice!) {
        return true;
      }
    }
    return false;
  }
}
