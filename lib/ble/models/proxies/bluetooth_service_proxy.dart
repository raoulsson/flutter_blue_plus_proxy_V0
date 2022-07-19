import 'package:base_template_project/ble/flutter_blue_plus_proxy.dart';
import 'package:base_template_project/ble/models/interfaces/bluetooth_service_interface.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'bluetooth_characteristic_proxy.dart';

class BluetoothServiceProxy implements BluetoothServiceInterface {
  late final Guid _uuid;
  late final DeviceIdentifier _deviceId;
  late final bool _isPrimary;
  late final List<BluetoothCharacteristicProxy> _characteristics;
  late final List<BluetoothServiceProxy> _includedServices;

  late final BluetoothService? _bluetoothService;

  BluetoothServiceProxy.mock(
      {required Guid uuid,
      required DeviceIdentifier deviceId,
      required bool isPrimary,
      required List<BluetoothCharacteristicProxy> characteristics,
      required List<BluetoothServiceProxy> includedServices}) {
    _uuid = uuid;
    _deviceId = deviceId;
    _isPrimary = isPrimary;
    _characteristics = characteristics;
    _includedServices = includedServices;

    _bluetoothService = null;
  }

  BluetoothServiceProxy.fromBluetoothService(BluetoothService bluetoothService) {
    _bluetoothService = bluetoothService;

    _uuid = bluetoothService.uuid;
    _deviceId = bluetoothService.deviceId;
    _isPrimary = bluetoothService.isPrimary;

    _characteristics = bluetoothService.characteristics.map((characteristic) {
      return BluetoothCharacteristicProxy.fromBluetoothCharacteristic(characteristic);
    }).toList();
    _includedServices = bluetoothService.includedServices.map((includedService) {
      return BluetoothServiceProxy.fromBluetoothService(includedService);
    }).toList();
  }

  Guid get uuid {
    return _uuid;
  }

  DeviceIdentifier get deviceId {
    return _deviceId;
  }

  bool get isPrimary {
    return _isPrimary;
  }

  List<BluetoothCharacteristicProxy> get characteristics {
    return _characteristics;
  }

  List<BluetoothServiceProxy> get includedServices {
    return _includedServices;
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is BluetoothServiceProxy && runtimeType == other.runtimeType && _uuid == other._uuid;

  @override
  int get hashCode => _uuid.hashCode;

  @override
  String toString() {
    if (FlutterBluePlusProxy.instance.onDevice) {
      return _bluetoothService.toString();
    }
    return 'BluetoothServiceProxy{_uuid: $_uuid, _deviceId: $_deviceId, _isPrimary: $_isPrimary, _characteristics: $_characteristics, _includedServices: $_includedServices}';
  }

  String asMockDef() {
    var bleCharAsMockDefs = '';
    for (var chars in _characteristics) {
      bleCharAsMockDefs = '$bleCharAsMockDefs${chars.asMockDef()}, ';
    }
    if (bleCharAsMockDefs.length > 3) {
      bleCharAsMockDefs = bleCharAsMockDefs.substring(0, bleCharAsMockDefs.length - 2).trim();
    }

    var inclSerMsg = '';
    if (_includedServices.isNotEmpty) {
      inclSerMsg = '/*omitted ${_includedServices.length} service/s*/';
    }
    var out = "BluetoothServiceProxy.mock(uuid: Guid('$_uuid'), deviceId: const DeviceIdentifier('$_deviceId'), isPrimary: $_isPrimary, characteristics: [$bleCharAsMockDefs], includedServices: [$inclSerMsg])";
    return out;
  }
}
