import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'models/proxies/bluetooth_device_proxy.dart';
import 'models/proxies/scan_result_proxy.dart';

abstract class FlutterBluePlusInterface {
  Future<bool> get isAvailable;
  Future<bool> get isOn;
  Future<bool> turnOn();
  Future<bool> turnOff();
  Stream<bool> get isScanning;
  Stream<List<ScanResultProxy>> get scanResults;
  Stream<BluetoothState> get state;
  Future<List<BluetoothDeviceProxy>> get connectedDevices;
  Future<List<BluetoothDeviceProxy>> get bondedDevices; // {
  Future startScan({
    ScanMode scanMode = ScanMode.lowLatency,
    List<Guid> withServices = const [],
    List<Guid> withDevices = const [],
    Duration? timeout,
    bool allowDuplicates = false,
  });
  Future stopScan();
  void setLogLevel(LogLevel level);
}
