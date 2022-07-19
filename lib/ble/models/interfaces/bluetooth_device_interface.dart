import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../proxies/bluetooth_service_proxy.dart';

abstract class BluetoothDeviceInterface {
  Stream<bool> get isDiscoveringServices;
  Future<void> connect({Duration? timeout, bool autoConnect = true});
  Future disconnect();
  Future<List<BluetoothServiceProxy>> discoverServices();
  Stream<List<BluetoothServiceProxy>> get services;
  Stream<BluetoothDeviceState> get state;
  Stream<int> get mtu;
  Future<int> requestMtu(int desiredMtu);
  Future<bool> get canSendWriteWithoutResponse;
}
