import 'dart:convert';
import 'dart:math';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'models/proxies/advertisement_data_proxy.dart';
import 'models/proxies/bluetooth_characteristic_proxy.dart';
import 'models/proxies/bluetooth_device_proxy.dart';
import 'models/proxies/bluetooth_service_proxy.dart';
import 'models/proxies/scan_result_proxy.dart';

String _randomString(int length) {
  const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  Random rnd = Random();
  return String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
}

class BleTesting {
  static int howManyScanResults = 7;

  static final Random _random = Random();

  static int microWiggle({required int round, int fixedOffset = 300, int maxWiggle = 500}) {
    var offsetMS = round * fixedOffset;
    var offsetNew = offsetMS - maxWiggle ~/ 2;
    var wiggle = _random.nextInt(maxWiggle);
    var totalWiggle = (offsetNew + wiggle).abs(); // could be below zero, e.g. when offsetSeconds is 0 and wiggle below 0
    return totalWiggle;
  }

  static List<int> randomBytes() {
    List<int> bytes = utf8.encode(_random.nextInt(2500).toString());
    return bytes;
  }

  ScanResultProxy getRandomSrp({String name = 'random'}) {
    return _buildSrp(name, _randomString(6));
  }

  List<ScanResultProxy> getRandomSrps(int howMany) {
    List<ScanResultProxy> list = [];
    for (int i = 0; i < howMany; i++) {
      list.add(getRandomSrp());
    }
    return list;
  }

  ScanResultProxy _buildSrp(String name, String r) {
    return ScanResultProxy.mock(
        deviceProxy: BluetoothDeviceProxy.mock(id: DeviceIdentifier('$name-aaaa-aaa-aaa-$r'), name: '$name-$r', type: BluetoothDeviceType.le),
        advertisementDataProxy:
            AdvertisementDataProxy.mock(localName: '', txPowerLevel: 12, connectable: true, manufacturerData: {}, serviceData: {}, serviceUuids: []),
        rssi: -80);
  }

  static var quatsch = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(
          id: DeviceIdentifier('quatsch-aaaa-aaa-aaa-${_randomString(6)}'), name: 'Quatsch ${_randomString(6)}', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: 12, connectable: true, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -80);
  static var start = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(
          id: DeviceIdentifier('start-aaaa-aaa-aaa-${_randomString(6)}'), name: 'StartScan ${_randomString(6)}', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: 12, connectable: true, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -80);
  static var s1 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(
          id: DeviceIdentifier('285F2D6B-B0D9-5748-EFF7-${_randomString(6)}'), name: 'Apple TV ${_randomString(6)}', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: 12, connectable: true, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -80);
  static var s2 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(
          id: DeviceIdentifier('15DDACA3-A0FC-72BE-A5CA-${_randomString(6)}'), name: 'Gemma Controller ${_randomString(6)}', type: BluetoothDeviceType.le),
      advertisementDataProxy: AdvertisementDataProxy.mock(
          localName: 'Gemma Controller', txPowerLevel: 3, connectable: true, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -79);
  static var s3 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(
          id: DeviceIdentifier('51D7A246-3BE6-02F7-0DE8-${_randomString(6)}'), name: _randomString(6), type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: null, connectable: false, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -89);
  static var s4 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(
          id: DeviceIdentifier('53D52CBD-900A-99EA-3050-${_randomString(6)}'), name: '[TV] madness65i ${_randomString(6)}', type: BluetoothDeviceType.le),
      advertisementDataProxy: AdvertisementDataProxy.mock(localName: '[TV] madness65i', txPowerLevel: null, connectable: false, manufacturerData: {
        117: [66, 4, 1, 128, 96, 156, 140, 110, 226, 176, 173, 158, 140, 110, 226, 176, 172, 1, 153, 207, 0, 0, 0, 0]
      }, serviceData: {}, serviceUuids: []),
      rssi: -76);
  static var s5 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(
          id: DeviceIdentifier('525A2250-36D7-91D8-DBB7-${_randomString(6)}'), name: 'zorp1 (2) ${_randomString(6)}', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: null, connectable: true, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -34);
  static var s6 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(
          id: DeviceIdentifier('3449116A-66DE-A0A7-9DCD-${_randomString(6)}'), name: _randomString(6), type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: null, connectable: false, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -85);
  static var s7 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(
          id: DeviceIdentifier('D9A667B9-A68C-90AC-39AB-${_randomString(6)}'), name: _randomString(6), type: BluetoothDeviceType.le),
      advertisementDataProxy: AdvertisementDataProxy.mock(localName: '', txPowerLevel: null, connectable: false, manufacturerData: {
        224: [0, 149, 202, 142, 102, 1]
      }, serviceData: {
        'FE9F': [2, 112, 67, 55, 110, 84, 77, 82, 99, 116, 87, 89, 0, 0, 1, 128, 138, 129, 191, 212]
      }, serviceUuids: [
        'FE9F'
      ]),
      rssi: -77);
  static var s8 = ScanResultProxy.mock(
      deviceProxy:
          BluetoothDeviceProxy.mock(id: const DeviceIdentifier('2307D77D-1B9C-AA58-80CD-4A72E8E9B344'), name: 'Apple TV', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: 12, connectable: true, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -84);
  static var s9 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('5630F9A5-AD72-F500-DFC2-9103A3D6319D'), name: '', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: null, connectable: false, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -34);
  static var s10 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(
          id: const DeviceIdentifier('03E6DB15-C3EC-C339-DEEE-DEAF46A90C67'), name: 'LE-Bose Revolve SoundLink', type: BluetoothDeviceType.le),
      advertisementDataProxy: AdvertisementDataProxy.mock(localName: 'LE-Bose Revolve SoundLink', txPowerLevel: 10, connectable: true, manufacturerData: {
        784: [64, 16, 1, 48]
      }, serviceData: {}, serviceUuids: [
        'FEBE'
      ]),
      rssi: -76);

// var mockScanResults = [s6, s7, s8];
  static var mockScanResults = [s1, s2, s3, s4, s5];
// final List<ScanResultProxy> mockScanResults = [s1, s2, s3, s4, s5, s6, s7, s8, s9, s10];

  static var device1 = BluetoothDeviceProxy.mock(
      id: const DeviceIdentifier('03E6DB15-C3EC-C339-DEEE-DEAF46A90C67'), name: 'LE-Bose Revolve SoundLink', type: BluetoothDeviceType.le);
  static var device2 =
      BluetoothDeviceProxy.mock(id: const DeviceIdentifier('285F2D6B-B0D9-5748-EFF7-6A21AB4461A8'), name: 'Apple TV', type: BluetoothDeviceType.le);

  // flutter: BluetoothServiceProxy{_uuid: 667d724e-4540-4123-984f-9ad6082212bb, _deviceId: 15DDACA3-A0FC-72BE-A5CA-D90152DBCE27, _isPrimary: true, _characteristics: [BluetoothCharacteristicProxy{uuid: 14cdad1f-1b15-41ee-9f51-d5caaf940d01, deviceId: 15DDACA3-A0FC-72BE-A5CA-D90152DBCE27, serviceUuid: 667d724e-4540-4123-984f-9ad6082212bb, secondaryServiceUuid: null, properties: CharacteristicProperties{broadcast: false, read: true, writeWithoutResponse: false, write: true, notify: false, indicate: false, authenticatedSignedWrites: false, extendedProperties: false, notifyEncryptionRequired: false, indicateEncryptionRequired: false}, descriptors: [], bluetoothCharacteristic: null, value: [-1]], _includedServices: []}
  static var service1 = BluetoothServiceProxy.mock(
    uuid: Guid('667d724e-4540-4123-984f-9ad6082212bb'),
    deviceId: const DeviceIdentifier('15DDACA3-A0FC-72BE-A5CA-D90152DBCE27'),
    isPrimary: true,
    characteristics: [
      BluetoothCharacteristicProxy.mock(
          uuid: Guid('14cdad1f-1b15-41ee-9f51-d5caaf940d01'),
          deviceId: const DeviceIdentifier('15DDACA3-A0FC-72BE-A5CA-D90152DBCE27'),
          serviceUuid: Guid('667d724e-4540-4123-984f-9ad6082212bb'),
          secondaryServiceUuid: null,
          properties: const CharacteristicProperties(
              broadcast: false,
              read: true,
              writeWithoutResponse: false,
              write: true,
              notify: false,
              indicate: false,
              authenticatedSignedWrites: false,
              extendedProperties: false,
              notifyEncryptionRequired: false,
              indicateEncryptionRequired: false),
          descriptors: [])
    ],
    includedServices: [],
  );
}
