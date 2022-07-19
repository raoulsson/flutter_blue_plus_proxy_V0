import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:base_template_project/ble/ble_mock_data.dart';
import 'package:base_template_project/ble/models/proxies/bluetooth_service_proxy.dart';
import 'package:base_template_project/ble/models/proxies/scan_result_proxy.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:log_4_dart_2/log_4_dart_2.dart';
import 'package:rxdart/rxdart.dart';

import '../utils/misc/generic_stream_transformer.dart';
import 'ble_testing.dart';
import 'flutter_blue_plus_interface.dart';
import 'models/proxies/bluetooth_device_proxy.dart';

class ScanResultCaster extends TypeCaster<ScanResult, ScanResultProxy> {
  @override
  ScanResultProxy call(ScanResult element) {
    var scanResultProxy = ScanResultProxy.fromScanResult(element);
    FlutterBluePlusProxy.mockScanResultsCache[element.device.id] = scanResultProxy;
    if (FlutterBluePlusProxy.instance.printDataAsMockDefs) {
      print(scanResultProxy.asMockDef());
    }
    return scanResultProxy;
  }
}

class ScanResultListCaster extends TypeCaster<List<ScanResult>, List<ScanResultProxy>> {
  @override
  List<ScanResultProxy> call(List<ScanResult> element) {
    return element.map((ScanResult r) {
      var scanResultProxy = ScanResultProxy.fromScanResult(r);
      FlutterBluePlusProxy.mockScanResultsCache[r.device.id] = scanResultProxy;
      if (FlutterBluePlusProxy.instance.printDataAsMockDefs) {
        print(scanResultProxy.asMockDef());
      }
      return scanResultProxy;
    }).toList();
  }
}

class FlutterBluePlusProxy with Log4Dart implements FlutterBluePlusInterface {
  static Map<DeviceIdentifier, BluetoothDeviceProxy> mockDeviceCache = {};
  static Map<DeviceIdentifier, ScanResultProxy> mockScanResultsCache = {};

  static FlutterBluePlusProxy? _instance;
  static FlutterBluePlus? _flutterBluePlusInstance;
  late final bool _onDevice;
  late final bool _printDataAsMockDefs;

  final BehaviorSubject<bool> _isScanning = BehaviorSubject.seeded(false);
  final StreamController<ScanResultProxy> _methodStreamController = StreamController.broadcast(); // ignore: close_sinks
  Stream<ScanResultProxy> get _methodStream => _methodStreamController.stream; // Used internally to dispatch methods from platform.
  final BehaviorSubject<List<ScanResultProxy>> _scanResults = BehaviorSubject.seeded([]);
  final PublishSubject _stopScanPill = PublishSubject();

  FlutterBluePlusProxy._(bool onDevice, bool printDataAsMockDefs) {
    _onDevice = onDevice;
    _printDataAsMockDefs = printDataAsMockDefs;
    Logger.info('Running with BLE hardware: $_onDevice');
    if (onDevice) {
      _flutterBluePlusInstance = FlutterBluePlus.instance;
    }
  }

  factory FlutterBluePlusProxy() {
    assert(_instance != null, 'FlutterBluePlusProxy.init(...) not yet called');
    return _instance!;
  }

  static FlutterBluePlusProxy get instance {
    assert(_instance != null, 'FlutterBluePlusProxy.init(...) not yet called');
    return _instance!;
  }

  static Future<bool> init({bool onDevice = true, bool printDataAsMockDefs = false}) async {
    assert(_instance == null, 'FlutterBluePlusProxy.init(...) already called');
    _instance = FlutterBluePlusProxy._(onDevice, printDataAsMockDefs);
    return true;
  }

  bool get onDevice {
    return _onDevice;
  }

  bool get printDataAsMockDefs {
    if (_onDevice) {
      return _printDataAsMockDefs;
    }
    return false;
  }

  @override
  Future<List<BluetoothDeviceProxy>> get bondedDevices async {
    sendSnackBarMessage('Looking for bondedDevices (Android only)');
    if (_onDevice) {
      List<BluetoothDevice> bluetoothDeviceList = await FlutterBluePlus.instance.bondedDevices;
      List<BluetoothDeviceProxy> bluetoothDeviceProxyList = [];
      for (var btd in bluetoothDeviceList) {
        bluetoothDeviceProxyList.add(BluetoothDeviceProxy.fromBluetoothDevice(btd));
      }
      return Future(() => UnmodifiableListView(bluetoothDeviceProxyList));
    }
    throw UnimplementedError('to be tested on android in the future');
  }

  // This comes from the actual device, so we mock the state here
  final Map<DeviceIdentifier, BluetoothDeviceProxy> _connectedDevices = {};
  // When device is disconnected, the scan result reappears in the respective list
  final Map<DeviceIdentifier, ScanResultProxy> _scanResultCache = <DeviceIdentifier, ScanResultProxy>{};

  void addConnectedDevice(BluetoothDeviceProxy device) {
    mockDeviceCache[device.id] = device;
    if (FlutterBluePlusProxy.instance.printDataAsMockDefs) {
      print(device.asMockDef());
    }
    _connectedDevices[device.id] = device;
    final List<ScanResultProxy> list = _scanResults.value;
    list.remove(_scanResultCache[device.id]);
    _scanResults.sink.add(list);
  }

  void removeConnectedDevice(BluetoothDeviceProxy device) {
    sendSnackBarMessage('Removing device: ${device.name}');
    _connectedDevices.remove(device.id);
    final List<ScanResultProxy> list = _scanResults.value;
    ScanResultProxy x = _scanResultCache[device.id]!;
    list.insert(0, x);
    _scanResults.sink.add(list);
  }

  bool _deviceConnected(BluetoothDeviceProxy device) {
    return _connectedDevices.containsKey(device.id);
  }

  @override
  Future<List<BluetoothDeviceProxy>> get connectedDevices async {
    if (_onDevice) {
      List<BluetoothDevice> bluetoothDeviceList = await FlutterBluePlus.instance.connectedDevices;
      List<BluetoothDeviceProxy> bluetoothDeviceProxyList = [];
      for (var btd in bluetoothDeviceList) {
        bluetoothDeviceProxyList.add(BluetoothDeviceProxy.fromBluetoothDevice(btd));
      }
      return Future(() => UnmodifiableListView(bluetoothDeviceProxyList));
    }
    return Future(() => UnmodifiableListView(_connectedDevices.values));
  }

  /// Checks whether the device supports Bluetooth
  @override
  Future<bool> get isAvailable {
    if (_onDevice) {
      return FlutterBluePlus.instance.isAvailable;
    }
    return Future(() => true);
  }

  /// Checks if Bluetooth functionality is turned on
  @override
  Future<bool> get isOn {
    if (_onDevice) {
      return FlutterBluePlus.instance.isOn;
    }
    return Future(() => true);
  }

  @override
  Stream<bool> get isScanning {
    if (_onDevice) {
      return FlutterBluePlus.instance.isScanning;
    }
    return _isScanning.stream;
  }

  @override
  Stream<List<ScanResultProxy>> get scanResults {
    if (_onDevice) {
      Stream<List<ScanResult>> scanResultListStream = _flutterBluePlusInstance!.scanResults;
      var myTransformer = GenericStreamTransformer<List<ScanResult>, List<ScanResultProxy>>.broadcast(ScanResultListCaster());
      var scanResultListProxyStream = scanResultListStream.transform(myTransformer);

      return scanResultListProxyStream;
    }
    return _scanResults.stream;
  }

  @override
  void setLogLevel(LogLevel level) async {
    if (_onDevice) {
      _flutterBluePlusInstance!.setLogLevel(level);
      return;
    }
    print('setLogLevel: not done;');
    return;
  }

  @override
  Future startScan(
      {ScanMode scanMode = ScanMode.lowLatency,
      List<Guid> withServices = const [],
      List<Guid> withDevices = const [],
      Duration? timeout,
      bool allowDuplicates = false}) async {
    sendSnackBarMessage('Scanning for BLE devices...');
    if (_onDevice) {
      return FlutterBluePlus.instance.startScan(
        scanMode: scanMode,
        withServices: withServices,
        withDevices: withDevices,
        timeout: timeout,
        allowDuplicates: allowDuplicates,
      );
    }
    scan(
      scanMode: scanMode,
      withServices: withServices,
      withDevices: withDevices,
      timeout: timeout,
      allowDuplicates: allowDuplicates,
    ).drain();
    return null;
  }

  Stream<ScanResultProxy> scan({
    ScanMode scanMode = ScanMode.lowLatency,
    List<Guid> withServices = const [],
    List<Guid> withDevices = const [],
    Duration? timeout,
    bool allowDuplicates = false,
  }) async* {
    if (_onDevice) {
      Stream<ScanResult> scanResultStream = _flutterBluePlusInstance!
          .scan(scanMode: scanMode, withServices: withServices, withDevices: withDevices, timeout: timeout, allowDuplicates: allowDuplicates);
      var myTransformer = GenericStreamTransformer<ScanResult, ScanResultProxy>(ScanResultCaster());
      var scanResultProxyStream = scanResultStream.transform(myTransformer);

      yield* scanResultProxyStream;
      return;
    }
    if (_isScanning.value == true) {
      throw Exception('Another scan is already in progress.');
    }

    _isScanning.add(true);

    final killStreams = <Stream>[];
    killStreams.add(_stopScanPill);
    if (timeout != null) {
      killStreams.add(Rx.timer(null, timeout));
    }

    // Clear scan results list
    _scanResults.add(<ScanResultProxy>[]);

    try {
      logDebug('Starting BLE scan...');
      mockStartScanEffect(BleTesting.howManyScanResults);
    } catch (e) {
      logWarn('Error starting scan');
      _stopScanPill.add(null);
      _isScanning.add(false);
      rethrow;
    }

    yield* _methodStream.takeUntil(Rx.merge(killStreams)).doOnDone(stopScan).map((ScanResultProxy result) {
      logDebug('Got scan result: $result');
      final list = _scanResults.value;
      int index = list.indexOf(result);
      if (index != -1) {
        list[index] = result;
      } else {
        list.add(result);
      }
      _scanResults.sink.add(list);
      return result;
    });
  }

  final BehaviorSubject<BluetoothState> _state = BehaviorSubject.seeded(BluetoothState.off);

  @override
  Stream<BluetoothState> get state async* {
    if (_onDevice) {
      yield* _flutterBluePlusInstance!.state;
    }
    _state.sink.add(BluetoothState.on);
    yield* _state.stream;
  }

  @override
  Future stopScan() async {
    logDebug('Stopped BLE scan...');
    sendSnackBarMessage('Stopped BLE scan...');
    if (_onDevice) {
      return _flutterBluePlusInstance!.stopScan();
    }
    await Future.delayed(const Duration(milliseconds: 100));
    _stopScanPill.add(null);
    _isScanning.add(false);
  }

  @override
  Future<bool> turnOff() {
    if (_onDevice) {
      return _flutterBluePlusInstance!.turnOff();
    }
    return Future(() => true);
  }

  @override
  Future<bool> turnOn() {
    if (_onDevice) {
      return _flutterBluePlusInstance!.turnOn();
    }
    return Future(() => true);
  }

  // Test related Area below...

  /// https://stackoverflow.com/a/72142721/132396
  void mockStartScanEffect(int howMany) {
    logDebug('Mimicking $howMany scan results...');
    var manyScanResults = BleTesting().getRandomSrps(howMany);

    manyScanResults.insert(1, BleMockData.scanResultR26);

    for (var i = 0; i < manyScanResults.length; i++) {
      // Omit those which are already connected at the moment
      if (!_deviceConnected(manyScanResults[i].device)) {
        Future.delayed(Duration(milliseconds: BleTesting.microWiggle(round: i, fixedOffset: 300, maxWiggle: 300)), () {
          _scanResultCache[manyScanResults[i].device.id] = manyScanResults[i];
          _methodStreamController.sink.add(manyScanResults[i]);
        });
      }
    }
  }

  // Send info to UI
  final BehaviorSubject<String> _snackBarMessageSubject = BehaviorSubject();

  Stream<String> get snackbarMessages {
    return _snackBarMessageSubject.stream;
  }

  void sendSnackBarMessage(String msg) {
    _snackBarMessageSubject.sink.add(msg);
  }

  /// When running with real devices, call this method after connecting to some devices and loading their respective services.
  /// It will print that data to copy paste away for testing.
  ///
  /// Produces something like:
  ///```dart
  ///static var scanResultR01 = ScanResultProxy.mock(deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('2...
  ///static var allScanResults = <ScanResultProxy>[scanResultR01, scanResultR02, scanResultR03, scanResultR04, scanResult...
  ///static var deviceD09 = BluetoothDeviceProxy.mock(id: const DeviceIdentifier('D3062E01-8024-95FF-18D8-8392B1B98034'),...
  ///static var serviceD08s01 = BluetoothServiceProxy.mock(uuid: Guid('d0611e78-bbb4-4591-a5f8-487910ae4366'), deviceId: ...
  ///static var servicesOfDeviceD02 = [serviceD02s01, serviceD02s02, serviceD02s03];
  ///static var allDevices = <BluetoothDeviceProxy>[deviceD01, deviceD02, deviceD03, deviceD04, deviceD05, deviceD06, devi...
  ///static var allServices = <BluetoothServiceProxy>[serviceD01s01, serviceD02s01, serviceD02s02, serviceD02s03, serviceD...
  ///static var allServicesByDeviceId = <DeviceIdentifier, List<BluetoothServiceProxy>>{const DeviceIdentifier('15DDACA3-A...
  ///```
  /// see [BleMockData]
  ///
  List<String> collectMockData({bool doPrint = false}) {
    final outList = <String>[];

    var allServiceResults = '<ScanResultProxy>[';

    var countSRP = 1;
    print('asdf ${mockScanResultsCache.length}');
    for (ScanResultProxy r in mockScanResultsCache.values) {
      outList
          .add('\tstatic var scanResultR${countSRP.toString().padLeft(mockScanResultsCache.length.toString().length, '0')} = ${r.asMockDef()};\n\n');
      allServiceResults = '${allServiceResults}scanResultR${countSRP.toString().padLeft(mockScanResultsCache.length.toString().length, '0')}, ';
      countSRP++;
    }
    if (allServiceResults.isNotEmpty) {
      allServiceResults = allServiceResults.substring(0, allServiceResults.length - 2);
    }
    allServiceResults = '$allServiceResults];';

    outList.add('');
    outList.add('\tstatic var allScanResults = $allServiceResults');
    outList.add('');

    var allDevices = '<BluetoothDeviceProxy>[';
    var allServices = '<BluetoothServiceProxy>[';
    var allServicesByDeviceId = '<DeviceIdentifier, List<BluetoothServiceProxy>>{';

    var countBDP = 1;
    var bdpPadSize = mockDeviceCache.length.toString().length;
    var bspPadSize = 0;
    // TODO: Replace with functional style
    for (List<BluetoothServiceProxy> lst in BluetoothDeviceProxy.mockBluetoothServiceCache.values) {
      if (lst.length > bspPadSize.toString().length) {
        bspPadSize = lst.length.toString().length;
      }
    }

    for (BluetoothDeviceProxy r in mockDeviceCache.values) {
      outList.add('\tstatic var deviceD${countBDP.toString().padLeft(bdpPadSize, '0')} = ${r.asMockDef()};\n\n');
      allDevices = '${allDevices}deviceD${countBDP.toString().padLeft(bdpPadSize, '0')}, ';
      allServicesByDeviceId = '${allServicesByDeviceId}const DeviceIdentifier(\'${r.id}\'): ';
      var servicesOfDevice = '';
      List<BluetoothServiceProxy>? serviceList = BluetoothDeviceProxy.mockBluetoothServiceCache[r.id];
      if (serviceList != null) {
        var countBSP = 1;
        for (var bsp in serviceList.toSet()) {
          outList.add('\tstatic var serviceD${countBDP.toString().padLeft(bdpPadSize, '0')}s${countBSP.toString().padLeft(max(bdpPadSize, bspPadSize), '0')} = ${bsp.asMockDef()};\n\n');
          allServices = '${allServices}serviceD${countBDP.toString().padLeft(bdpPadSize, '0')}s${countBSP.toString().padLeft(max(bdpPadSize, bspPadSize), '0')}, ';
          servicesOfDevice = '${servicesOfDevice}serviceD${countBDP.toString().padLeft(bdpPadSize, '0')}s${countBSP.toString().padLeft(max(bdpPadSize, bspPadSize), '0')}, ';
          countBSP++;
        }
        servicesOfDevice = servicesOfDevice.substring(0, servicesOfDevice.length - 2);
      }
      allServicesByDeviceId = '$allServicesByDeviceId[$servicesOfDevice], ';
      servicesOfDevice = '[$servicesOfDevice];';
      outList.add('');
      outList.add('\tstatic var servicesOfDeviceD${countBDP.toString().padLeft(bdpPadSize, '0')} = $servicesOfDevice');
      outList.add('');
      countBDP++;
    }

    if (!allDevices.endsWith('[')) {
      allDevices = allDevices.substring(0, allDevices.length - 2);
    }
    allDevices = '$allDevices];';

    if (!allServices.endsWith('[')) {
      allServices = allServices.substring(0, allServices.length - 2);
    }
    allServices = '$allServices];';

    outList.add('\tstatic var allDevices = $allDevices');

    outList.add('');
    outList.add('\tstatic var allServices = $allServices');

    if (!allServicesByDeviceId.endsWith('{')) {
      allServicesByDeviceId = allServicesByDeviceId.substring(0, allServicesByDeviceId.length - 2);
    }
    outList.add('');
    outList.add('\tstatic var allServicesByDeviceId = $allServicesByDeviceId};');

    if (doPrint) {
      for (var line in outList) {
        print(line);
      }
    }
    return outList;
  }
}
