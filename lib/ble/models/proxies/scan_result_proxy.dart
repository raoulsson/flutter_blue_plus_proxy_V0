import 'package:base_template_project/ble/models/interfaces/scan_result_interface.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../flutter_blue_plus_proxy.dart';
import 'advertisement_data_proxy.dart';
import 'bluetooth_device_proxy.dart';

class ScanResultProxy implements ScanResultInterface {
  late final BluetoothDeviceProxy _deviceProxy;
  late final AdvertisementDataProxy _advertisementDataProxy;
  late final int _rssi;

  late final ScanResult? _scanResult;

  ScanResultProxy.mock({required BluetoothDeviceProxy deviceProxy, required AdvertisementDataProxy advertisementDataProxy, required int rssi}) {
    _deviceProxy = deviceProxy;
    _advertisementDataProxy = advertisementDataProxy;
    _rssi = rssi;

    _scanResult = null;
  }

  ScanResultProxy.fromScanResult(ScanResult scanResult) {
    _scanResult = scanResult;

    _deviceProxy = BluetoothDeviceProxy.fromBluetoothDevice(_scanResult!.device);
    _advertisementDataProxy = AdvertisementDataProxy.formAdvertisementData(_scanResult!.advertisementData);
    _rssi = _scanResult!.rssi;
  }

  BluetoothDeviceProxy get device {
    return _deviceProxy;
  }

  AdvertisementDataProxy get advertisementData {
    return _advertisementDataProxy;
  }

  int get rssi {
    return _rssi;
  }

  @override
  bool operator ==(Object other) {
    if (FlutterBluePlusProxy.instance.onDevice) {
      return _scanResult == other;
    }
    return identical(this, other) || other is ScanResultProxy && runtimeType == other.runtimeType && _deviceProxy == other._deviceProxy;
  }

  @override
  int get hashCode {
    if (FlutterBluePlusProxy.instance.onDevice) {
      return _scanResult!.device.hashCode;
    }
    return _deviceProxy.hashCode;
  }

  @override
  String toString() {
    if (FlutterBluePlusProxy.instance.onDevice) {
      return _scanResult.toString();
    }
    return 'ScanResultProxy{_deviceProxy: $_deviceProxy, _advertisementDataProxy: $_advertisementDataProxy, _rssi: $_rssi}';
  }

  String asMockDef() {
    var out = 'ScanResultProxy.mock(deviceProxy: ${_deviceProxy.asMockDef()}, advertisementDataProxy: ${_advertisementDataProxy.asMockDef()}, rssi: $_rssi)';
    return out;
  }
}
