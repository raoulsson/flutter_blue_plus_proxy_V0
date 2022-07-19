import 'dart:convert';

import 'package:base_template_project/ble/models/interfaces/bluetooth_descriptor_interface.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:rxdart/rxdart.dart';

import '../../flutter_blue_plus_proxy.dart';

class BluetoothDescriptorProxy implements BluetoothDescriptorInterface {
  late final Guid _uuid;
  late final DeviceIdentifier _deviceId;
  late final Guid _serviceUuid;
  late final Guid _characteristicUuid;

  late final BluetoothDescriptor? _bluetoothDescriptor;

  BluetoothDescriptorProxy.mock({required Guid uuid, required DeviceIdentifier deviceId, required Guid serviceUuid, required Guid characteristicUuid}) {
    _uuid = uuid;
    _deviceId = deviceId;
    _serviceUuid = serviceUuid;
    _characteristicUuid = characteristicUuid;

    _bluetoothDescriptor = null;
  }

  BluetoothDescriptorProxy.fromBluetoothDescriptor(BluetoothDescriptor bluetoothDescriptor) {
    _bluetoothDescriptor = bluetoothDescriptor;

    _uuid = bluetoothDescriptor.uuid;
    _deviceId = bluetoothDescriptor.deviceId;
    _serviceUuid = bluetoothDescriptor.serviceUuid;
    _characteristicUuid = bluetoothDescriptor.characteristicUuid;
  }

  Guid get uuid {
    return _uuid;
  }

  DeviceIdentifier get deviceId {
    return _deviceId;
  }

  Guid get serviceUuid {
    return _serviceUuid;
  }

  Guid get characteristicUuid {
    return _characteristicUuid;
  }

  final BehaviorSubject<List<int>> _value = BehaviorSubject.seeded([]);

  @override
  Stream<List<int>> get value {
    if (FlutterBluePlusProxy.instance.onDevice) {
      return _bluetoothDescriptor!.value;
    }
    return _value.stream;
  }

  @override
  List<int> get lastValue {
    if (FlutterBluePlusProxy.instance.onDevice) {
      return _bluetoothDescriptor!.lastValue;
    }
    return _value.value;
  }

  @override
  Future<List<int>> read() {
    if (FlutterBluePlusProxy.instance.onDevice) {
      return _bluetoothDescriptor!.read();
    }
    throw UnimplementedError('will imp, as soon as i come across the device and all...');
  }

  @override
  // ignore: prefer_void_to_null
  Future<Null> write(List<int> value) {
    if (FlutterBluePlusProxy.instance.onDevice) {
      return _bluetoothDescriptor!.write(value);
    }
    throw UnimplementedError('will imp, as soon as i come across the device and all...');
  }

  // ignore: prefer_void_to_null
  Future<Null> writeUTF8(value) {
    List<int> bytes = utf8.encode(value.toString());
    return write(bytes);
  }

  @override
  String toString() {
    if (FlutterBluePlusProxy.instance.onDevice) {
      return _bluetoothDescriptor.toString();
    }
    return 'BluetoothDescriptorProxy{_uuid: $_uuid, _deviceId: $_deviceId, _serviceUuid: $_serviceUuid, _characteristicUuid: $_characteristicUuid, value: ${_value.value}';
  }

  String asMockDef() {
    var out = 'BluetoothDescriptorProxy.mock(uuid: Guid(\'$_uuid\'), deviceId: const DeviceIdentifier(\'$_deviceId\'), serviceUuid: Guid(\'$_serviceUuid\'), characteristicUuid: Guid(\'$_characteristicUuid\'))';
    return out;
  }
}
