import 'package:base_template_project/ble/flutter_blue_plus_proxy.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../interfaces/advertisement_data_interface.dart';

class AdvertisementDataProxy implements AdvertisementDataInterface {
  late final String _localName;
  late final int? _txPowerLevel;
  late final bool _connectable;
  late final Map<int, List<int>> _manufacturerData;
  late final Map<String, List<int>> _serviceData;
  late final List<String> _serviceUuids;

  late final AdvertisementData? _advertisementData;

  AdvertisementDataProxy.mock(
      {required String localName,
      required int? txPowerLevel,
      required bool connectable,
      required Map<int, List<int>> manufacturerData,
      required Map<String, List<int>> serviceData,
      required List<String> serviceUuids}) {
    _localName = localName;
    _txPowerLevel = txPowerLevel;
    _connectable = connectable;
    _manufacturerData = manufacturerData;
    _serviceData = serviceData;
    _serviceUuids = serviceUuids;
    _advertisementData = null;
  }

  AdvertisementDataProxy.formAdvertisementData(AdvertisementData advertisementData) {
    _advertisementData = advertisementData;

    _localName = _advertisementData!.localName;
    _txPowerLevel = _advertisementData!.txPowerLevel;
    _connectable = _advertisementData!.connectable;
    _manufacturerData = _advertisementData!.manufacturerData;
    _serviceData = _advertisementData!.serviceData;
    _serviceUuids = _advertisementData!.serviceUuids;
  }

  String get localName {
    return _localName;
  }

  int? get txPowerLevel {
    return _txPowerLevel;
  }

  bool get connectable {
    return _connectable;
  }

  Map<int, List<int>> get manufacturerData {
    return _manufacturerData;
  }

  Map<String, List<int>> get serviceData {
    return _serviceData;
  }

  List<String> get serviceUuids {
    return _serviceUuids;
  }

  @override
  String toString() {
    if (FlutterBluePlusProxy.instance.onDevice) {
      return _advertisementData.toString();
    }
    return 'AdvertisementDataProxy{_localName: $_localName, _txPowerLevel: $_txPowerLevel, _connectable: $_connectable, _manufacturerData: $_manufacturerData, _serviceData: $_serviceData, _serviceUuids: $_serviceUuids}';
  }

  String asMockDef() {
    var servs = '';
    var servsData = '';
    for (var k in _serviceUuids) {
      servs = '$servs\'$k\', ';
      servsData = '$servsData\'$k\': [';
      var intList = _serviceData[k];
      if (intList != null) {
        for (var d in intList) {
          servsData = '$servsData$d, ';
        }
        if (servsData.isNotEmpty) {
          servsData = servsData.substring(0, servsData.length - 2).trim();
        }
      }
      servsData = '$servsData], ';
    }
    if (servs.isNotEmpty) {
      servs = servs.substring(0, servs.length - 2).trim();
    }
    if (servsData.isNotEmpty) {
      servsData = servsData.substring(0, servsData.length - 2).trim();
    }

    var manuData = '';
    for (var k in _manufacturerData.keys) {
      manuData = '$manuData$k: [';
      var intList = _manufacturerData[k];
      if (intList != null) {
        for (var d in intList) {
          manuData = '$manuData$d, ';
        }
        if (manuData.isNotEmpty) {
          manuData = manuData.substring(0, manuData.length - 2).trim();
        }
      }
      manuData = '$manuData], ';
    }
    if (manuData.isNotEmpty) {
      manuData = manuData.substring(0, manuData.length - 2).trim();
    }

    var out = 'AdvertisementDataProxy.mock(localName: \'$_localName\', txPowerLevel: $_txPowerLevel, connectable: $_connectable, manufacturerData: {$manuData}, serviceData: {$servsData}, serviceUuids: [$servs])';
    return out;
  }
}
