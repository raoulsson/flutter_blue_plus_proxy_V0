import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AssetUtil {
  static Future<bool> assetFileExists(AssetBundle assetBundle, String assetFileName) async {
    try {
      await assetBundle.load(assetFileName);
      return true;
    } catch (e) {
      return false;
    }
  }

  static AssetBundle getAssetBundle(BuildContext? context) {
    if (context != null) {
      return DefaultAssetBundle.of(context);
    }
    return rootBundle;
  }
}
