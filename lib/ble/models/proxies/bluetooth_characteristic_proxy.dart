import 'dart:async';
import 'dart:convert';

import 'package:base_template_project/ble/ble_testing.dart';
import 'package:base_template_project/ble/flutter_blue_plus_proxy.dart';
import 'package:base_template_project/ble/models/interfaces/bluetooth_characteristic_interface.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:rxdart/rxdart.dart';

import 'bluetooth_descriptor_proxy.dart';

class BluetoothCharacteristicProxy implements BluetoothCharacteristicInterface {
  late final Guid _uuid;
  late final DeviceIdentifier _deviceId;
  late final Guid _serviceUuid;
  late final Guid? _secondaryServiceUuid;
  late final CharacteristicProperties _properties;
  late final List<BluetoothDescriptorProxy> _descriptors;

  late final BluetoothCharacteristic? _bluetoothCharacteristic;

  BluetoothCharacteristicProxy.mock(
      {required Guid uuid,
      required DeviceIdentifier deviceId,
      required Guid serviceUuid,
      required Guid? secondaryServiceUuid,
      required CharacteristicProperties properties,
      required List<BluetoothDescriptorProxy> descriptors}) {
    _uuid = uuid;
    _deviceId = deviceId;
    _serviceUuid = serviceUuid;
    _secondaryServiceUuid = secondaryServiceUuid;
    _properties = properties;
    _descriptors = descriptors;

    _bluetoothCharacteristic = null;
  }

  BluetoothCharacteristicProxy.fromBluetoothCharacteristic(BluetoothCharacteristic bluetoothCharacteristic) {
    _bluetoothCharacteristic = bluetoothCharacteristic;

    _uuid = bluetoothCharacteristic.uuid;
    _deviceId = bluetoothCharacteristic.deviceId;
    _serviceUuid = bluetoothCharacteristic.serviceUuid;
    _secondaryServiceUuid = bluetoothCharacteristic.secondaryServiceUuid;
    _properties = bluetoothCharacteristic.properties;
    _descriptors = bluetoothCharacteristic.descriptors.map((descriptor) {
      return BluetoothDescriptorProxy.fromBluetoothDescriptor(descriptor);
    }).toList();
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

  Guid? get secondaryServiceUuid {
    return _secondaryServiceUuid;
  }

  CharacteristicProperties get properties {
    return _properties;
  }

  List<BluetoothDescriptorProxy> get descriptors {
    return _descriptors;
  }

  final BehaviorSubject<bool> _notifiyingSubject = BehaviorSubject.seeded(false);

  bool _isNotifiying = false;

  @override
  bool get isNotifying {
    if (FlutterBluePlusProxy.instance.onDevice) {
      return _bluetoothCharacteristic!.isNotifying;
    }
    return _isNotifiying;
  }

  // We need a stream to mock correct UI behaviour...
  Stream<bool> get isNotifyingStream {
    if (FlutterBluePlusProxy.instance.onDevice) {
      _notifiyingSubject.sink.add(_bluetoothCharacteristic!.isNotifying);
      return _notifiyingSubject.stream;
    }
    return _notifiyingSubject.stream;
  }

  final BehaviorSubject<List<int>> _value = BehaviorSubject.seeded([]);

  @override
  Stream<List<int>> get value {
    if (FlutterBluePlusProxy.instance.onDevice) {
      return _bluetoothCharacteristic!.value;
    }
    return Rx.merge([
      _value.stream,
      onValueChangedStream,
    ]);
  }

  @override
  List<int> get lastValue {
    if (FlutterBluePlusProxy.instance.onDevice) {
      return _bluetoothCharacteristic!.lastValue;
    }
    return _value.value;
  }

  // Just used to pump notifications through
  final BehaviorSubject<List<int>> _onCharacteristicChangedWannabe = BehaviorSubject();

  @override
  Stream<List<int>> get onValueChangedStream {
    if (FlutterBluePlusProxy.instance.onDevice) {
      return _bluetoothCharacteristic!.onValueChangedStream;
    }
    return _onCharacteristicChangedWannabe.stream;
  }

  /// Retrieves the value of the characteristic
  @override
  Future<List<int>> read() async {
    // When writing, read is called instantly, so we omit that message
    if (_writeValCache.isEmpty) {
      // FlutterBluePlusProxy.instance.sendSnackBarMessage('Reading from characteristic: ' + _uuid.toString().substring(_uuid.toString().length - 6));
      FlutterBluePlusProxy.instance
          .sendSnackBarMessage('Reading from characteristic: 0x${_uuid.toString().toUpperCase().substring(4, 8)}');
    }
    if (FlutterBluePlusProxy.instance.onDevice) {
      return _bluetoothCharacteristic!.read();
    }
    return await Future<List<int>>.delayed(const Duration(milliseconds: 300), (() {
      // method should return void
      if (_writeValCache.isEmpty) {
        _value.add(BleTesting.randomBytes());
      } else {
        // print('replying to write: $_writeValCache');
        _value.add(_writeValCache);
        _writeValCache = [];
      }
      return Future(() => []);
    }));
  }

  /// Writes the value of a characteristic.
  /// [CharacteristicWriteType.withoutResponse]: the write is not
  /// guaranteed and will return immediately with success.
  /// [CharacteristicWriteType.withResponse]: the method will return after the
  /// write operation has either passed or failed.
  @override
  // ignore: prefer_void_to_null
  Future<Null> write(List<int> value, {bool withoutResponse = false}) {
    FlutterBluePlusProxy.instance.sendSnackBarMessage('Writing to characteristic: 0x${_uuid.toString().toUpperCase().substring(4, 8)} value: $value');
    if (FlutterBluePlusProxy.instance.onDevice) {
      if (withoutResponse && !_properties.writeWithoutResponse) {
        withoutResponse = false;
      }
      return _bluetoothCharacteristic!.write(value, withoutResponse: withoutResponse);
    }
    // Store it, so we can mock read result
    _writeValCache = value;
    return Future(() => null);
  }

  var _writeValCache = <int>[];

  // ignore: prefer_void_to_null
  Future<Null> writeUTF8(value, {bool withoutResponse = false}) {
    List<int> bytes = utf8.encode(value.toString());
    return write(bytes, withoutResponse: withoutResponse);
  }

  /// Sets notifications or indications for the value of a specified characteristic
  @override
  Future<bool> setNotifyValue(bool notify) {
    if (FlutterBluePlusProxy.instance.onDevice) {
      if (_properties.notify == true) {
        if (notify) {
          FlutterBluePlusProxy.instance.sendSnackBarMessage(
              'Turning notifications ON (${_uuid.toString().substring(_uuid.toString().length - 6)})');
        } else {
          FlutterBluePlusProxy.instance.sendSnackBarMessage(
              'Turning notifications OFF (${_uuid.toString().substring(_uuid.toString().length - 6)})');
        }
      } else {
        FlutterBluePlusProxy.instance.sendSnackBarMessage(
            'Service (${_uuid.toString().substring(_uuid.toString().length - 6)}) does not support notifications');
      }
      return _bluetoothCharacteristic!.setNotifyValue(notify);
    }
    if (_properties.notify == false) {
      print('Warn: characteristics say there is no notification. However, for mock mode\'s sake, we mimic it...');
    }
    _isNotifiying = notify;
    _notifiyingSubject.sink.add(notify);
    return Future.delayed(const Duration(milliseconds: 50), (() {
      mockResumePauseNotificationEffect(_isNotifiying);
      return _isNotifiying;
    }));
  }

  @override
  String toString() {
    if (FlutterBluePlusProxy.instance.onDevice) {
      return _bluetoothCharacteristic.toString();
    }
    return 'BluetoothCharacteristicProxy{uuid: $_uuid, deviceId: $_deviceId, serviceUuid: $_serviceUuid, secondaryServiceUuid: $_secondaryServiceUuid, properties: $_properties, descriptors: $_descriptors';
  }

  String asMockDef() {
    var descriptorsAsMockDefs = '';
    for (var descs in _descriptors) {
      descriptorsAsMockDefs = '$descriptorsAsMockDefs${descs.asMockDef()}, ';
    }
    if (descriptorsAsMockDefs.length > 3) {
      descriptorsAsMockDefs = descriptorsAsMockDefs.substring(0, descriptorsAsMockDefs.length - 2).trim();
    }

    var propertiesFixed = _properties.toString();
    propertiesFixed =
        propertiesFixed.replaceAll('CharacteristicProperties{broadcast:', 'const CharacteristicProperties(broadcast:');
    propertiesFixed = propertiesFixed.replaceAll('}', ')');

    var out = 'BluetoothCharacteristicProxy.mock(uuid: Guid(\'$_uuid\'), deviceId: const DeviceIdentifier(\'$_deviceId\'), serviceUuid: Guid(\'$_serviceUuid\'), secondaryServiceUuid: ${_secondaryServiceUuid == null ? 'null' : 'Guid(\'$_secondaryServiceUuid\')'}, properties: $propertiesFixed, descriptors: [$descriptorsAsMockDefs])';
    return out;
  }

  /// Testing area

  // Sends 0, 1, 2, 0, 1, 2, ...https://stackoverflow.com/a/67791286/132396
  final Stream _periodicNotificationWannabe = Stream.periodic(const Duration(milliseconds: 400), (count) => count % 3);
  StreamSubscription? _notificationListener;

  void mockResumePauseNotificationEffect(bool doListen) {
    _notificationListener ??= _periodicNotificationWannabe.listen((c) {
      _onCharacteristicChangedWannabe.add(BleTesting.randomBytes());
    });
    if (doListen) {
      _notificationListener?.resume();
    } else {
      _notificationListener?.pause();
    }
  }
}
