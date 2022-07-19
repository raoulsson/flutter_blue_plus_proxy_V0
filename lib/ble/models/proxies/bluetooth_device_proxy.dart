import 'dart:async';

import 'package:base_template_project/ble/ble_mock_data.dart';
import 'package:base_template_project/ble/flutter_blue_plus_proxy.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:rxdart/rxdart.dart';

import '../../../utils/misc/generic_stream_transformer.dart';
import '../../ble_testing.dart';
import '../interfaces/bluetooth_device_interface.dart';
import 'bluetooth_service_proxy.dart';

class ServiceListCaster extends TypeCaster<List<BluetoothService>, List<BluetoothServiceProxy>> {
  @override
  List<BluetoothServiceProxy> call(List<BluetoothService> element) {
    return element.map((BluetoothService r) {
      var bluetoothServiceProxy = BluetoothServiceProxy.fromBluetoothService(r);
      var serviceList = BluetoothDeviceProxy.mockBluetoothServiceCache[r.deviceId];
      serviceList ??= [];
      if (!serviceList.contains(bluetoothServiceProxy)) {
        // print('>>>' + bluetoothServiceProxy.toString());
        serviceList.add(bluetoothServiceProxy);
      }
      BluetoothDeviceProxy.mockBluetoothServiceCache[r.deviceId] = serviceList;

      if (FlutterBluePlusProxy.instance.printDataAsMockDefs) {
        print(bluetoothServiceProxy.asMockDef());
      }
      return bluetoothServiceProxy;
    }).toList();
  }
}

class BluetoothDeviceProxy implements BluetoothDeviceInterface {
  static Map<DeviceIdentifier, List<BluetoothServiceProxy>> mockBluetoothServiceCache = {};

  late final DeviceIdentifier _id;
  late final String _name;
  late final BluetoothDeviceType _type;

  late final BluetoothDevice? _bluetoothDevice;

  BluetoothDeviceProxy.mock({required DeviceIdentifier id, required String name, required BluetoothDeviceType type}) {
    _id = id;
    _name = name;
    _type = type;

    _bluetoothDevice = null;
  }

  BluetoothDeviceProxy.fromBluetoothDevice(BluetoothDevice bluetoothDevice) {
    _bluetoothDevice = bluetoothDevice;

    _id = _bluetoothDevice!.id;
    _name = _bluetoothDevice!.name;
    _type = _bluetoothDevice!.type;
  }

  DeviceIdentifier get id {
    return _id;
  }

  String get name {
    return _name;
  }

  BluetoothDeviceType get type {
    return _type;
  }

  @override
  Future<void> connect({
    Duration? timeout,
    bool autoConnect = true,
  }) async {
    FlutterBluePlusProxy.instance.sendSnackBarMessage('Connecting to device: $toNameOrUUID');
    if (FlutterBluePlusProxy.instance.onDevice) {
      FlutterBluePlusProxy.instance.addConnectedDevice(this); // for getting mock data
      return _bluetoothDevice!.connect(timeout: timeout, autoConnect: autoConnect);
    }
    _stateController.add(BluetoothDeviceState.connecting);
    // Simulate time from connecting to connected
    Future.delayed(const Duration(milliseconds: 1200), () {
      FlutterBluePlusProxy.instance.addConnectedDevice(this);
      _stateController.add(BluetoothDeviceState.connected);
    });
    return Future(() => null);
  }

  @override
  Future disconnect() async {
    FlutterBluePlusProxy.instance.sendSnackBarMessage('Disconnecting from device: $_name');
    if (FlutterBluePlusProxy.instance.onDevice) {
      return _bluetoothDevice!.disconnect();
    }
    _stateController.add(BluetoothDeviceState.disconnecting);
    // Simulate time from connecting to connected
    Future.delayed(const Duration(milliseconds: 1200), () {
      FlutterBluePlusProxy.instance.removeConnectedDevice(this);
      _stateController.add(BluetoothDeviceState.disconnected);
    });
    return Future(() => null);
  }

  @override
  // TODO: implement canSendWriteWithoutResponse
  Future<bool> get canSendWriteWithoutResponse {
    if (FlutterBluePlusProxy.instance.onDevice) {
      return _bluetoothDevice!.canSendWriteWithoutResponse;
    } else {
      throw UnimplementedError('also not implemented in flutter_blue_plus');
    }
  }

  @override
  Future<List<BluetoothServiceProxy>> discoverServices() async {
    FlutterBluePlusProxy.instance.sendSnackBarMessage('Looking for services on device: $_name');
    _doListenToServices = true;
    _listenToServiceResultOnce();

    if (FlutterBluePlusProxy.instance.onDevice) {
      List<BluetoothService> discoveredServices = await _bluetoothDevice!.discoverServices();

      List<BluetoothServiceProxy> discoveredServicesProxyList =
          discoveredServices.map((bluetoothService) => BluetoothServiceProxy.fromBluetoothService(bluetoothService)).toList();

      return Future(() => discoveredServicesProxyList);
    }
    // Method should actually return void, as services are fetched via services stream
    mockDiscoverServicesEffect();
    return Future(() => []);
  }

  final BehaviorSubject<bool> _isDiscoveringServices = BehaviorSubject.seeded(false);

  @override
  Stream<bool> get isDiscoveringServices {
    if (FlutterBluePlusProxy.instance.onDevice) {
      return _bluetoothDevice!.isDiscoveringServices;
    }
    return _isDiscoveringServices.stream;
  }

  final BehaviorSubject<int> _mtuController = BehaviorSubject.seeded(0);

  @override
  Stream<int> get mtu async* {
    if (FlutterBluePlusProxy.instance.onDevice) {
      yield* _bluetoothDevice!.mtu;
      return;
    }
    yield* _mtuController.stream;
  }

  @override
  Future<int> requestMtu(int desiredMtu) async {
    FlutterBluePlusProxy.instance.sendSnackBarMessage('Requesting MTU (Android only)');
    if (FlutterBluePlusProxy.instance.onDevice) {
      return _bluetoothDevice!.requestMtu(desiredMtu);
    }
    _mtuController.add(0);
    Future.delayed(const Duration(milliseconds: 400), () {
      _mtuController.add(108);
    });
    return Future(() => desiredMtu);
  }

  final BehaviorSubject<List<BluetoothServiceProxy>> _services = BehaviorSubject.seeded([]);

  /// Returns a list of Bluetooth GATT services offered by the remote device
  /// This function requires that discoverServices has been completed for this device
  @override
  Stream<List<BluetoothServiceProxy>> get services async* {
    if (FlutterBluePlusProxy.instance.onDevice) {
      Stream<List<BluetoothService>> servicesListStream = _bluetoothDevice!.services;
      var myTransformer = GenericStreamTransformer<List<BluetoothService>, List<BluetoothServiceProxy>>(ServiceListCaster());

      var servicesProxyListStream = servicesListStream.transform(myTransformer);

      yield* servicesProxyListStream;
      return;
    }
    yield* _services.stream;
  }

  final BehaviorSubject<BluetoothDeviceState> _stateController = BehaviorSubject.seeded(BluetoothDeviceState.disconnected);

  /// The current connection state of the device
  @override
  Stream<BluetoothDeviceState> get state async* {
    if (FlutterBluePlusProxy.instance.onDevice) {
      yield* _bluetoothDevice!.state;
      return;
    }
    yield* _stateController.stream;
  }

  bool _doListenToServices = false;
  StreamSubscription? _servicesListener;

  void _listenToServiceResultOnce() {
    _servicesListener ??= services.listen((s) {
      if (s.isNotEmpty) {
        _doListenToServices = false;
        Future.delayed(
          const Duration(milliseconds: 1000),
          (() {
            if (s.length == 1) {
              FlutterBluePlusProxy.instance.sendSnackBarMessage('Found ${s.length} service');
            } else if (s.length > 1) {
              FlutterBluePlusProxy.instance.sendSnackBarMessage('Found ${s.length} services');
            }
          }),
        );
      }
    });
    if (_doListenToServices) {
      _servicesListener?.resume();
    } else {
      _servicesListener?.pause();
    }
  }

  String get toNameOrUUID {
    if (_name.isNotEmpty) {
      return _name;
    }
    return _id.toString().toUpperCase().substring(4, 8);
  }

  @override
  bool operator ==(Object other) {
    if (FlutterBluePlusProxy.instance.onDevice) {
      return _bluetoothDevice == other;
    }
    return identical(this, other) || other is BluetoothDeviceProxy && runtimeType == other.runtimeType && id == other.id;
  }

  @override
  int get hashCode {
    if (FlutterBluePlusProxy.instance.onDevice) {
      return _bluetoothDevice.hashCode;
    }
    return _id.hashCode;
  }

  @override
  String toString() {
    if (FlutterBluePlusProxy.instance.onDevice) {
      return _bluetoothDevice.toString();
    }
    return 'BluetoothDeviceProxy{_id: $_id, _name: $_name, _type: $_type, isDiscoveringServices: ${_isDiscoveringServices.value}, _services: ${_services.value}';
  }

  String asMockDef() {
    var out = 'BluetoothDeviceProxy.mock(id: const DeviceIdentifier(\'$_id\'), name: \'$_name\', type: $_type)';
    return out;
  }

  /// Testing area

  void mockDiscoverServicesEffect() {
    Future.delayed(Duration(milliseconds: BleTesting.microWiggle(round: 1, fixedOffset: 300, maxWiggle: 100)), () {
      List<BluetoothServiceProxy>? serviceList = BleMockData.allServicesByDeviceId[_id];
      print(serviceList);
      if (serviceList != null) {
        _services.sink.add(serviceList);
      }
    });
  }
}
