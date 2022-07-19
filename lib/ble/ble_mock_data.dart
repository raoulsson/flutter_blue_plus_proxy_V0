import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'models/proxies/advertisement_data_proxy.dart';
import 'models/proxies/bluetooth_characteristic_proxy.dart';
import 'models/proxies/bluetooth_descriptor_proxy.dart';
import 'models/proxies/bluetooth_device_proxy.dart';
import 'models/proxies/bluetooth_service_proxy.dart';
import 'models/proxies/scan_result_proxy.dart';

class BleMockData {
  static var scanResultR01 = ScanResultProxy.mock(
      deviceProxy:
          BluetoothDeviceProxy.mock(id: const DeviceIdentifier('285F2D6B-B0D9-5748-EFF7-6A21AB4461A8'), name: 'Apple TV', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: 12, connectable: true, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -94);

  static var scanResultR02 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('64DFDBB6-0AD6-21A3-0768-D78DA8574C47'), name: '', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: null, connectable: true, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -43);

  static var scanResultR03 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('14E0F147-F18B-4391-EA6B-64BBE0A8BCE2'), name: '', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: 8, connectable: true, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -86);

  static var scanResultR04 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(
          id: const DeviceIdentifier('03E6DB15-C3EC-C339-DEEE-DEAF46A90C67'), name: 'LE-Bose Revolve SoundLink', type: BluetoothDeviceType.le),
      advertisementDataProxy: AdvertisementDataProxy.mock(localName: 'LE-Bose Revolve SoundLink', txPowerLevel: 10, connectable: true, manufacturerData: {
        784: [64, 16, 1, 48]
      }, serviceData: {
        'FEBE': []
      }, serviceUuids: [
        'FEBE'
      ]),
      rssi: -66);

  static var scanResultR05 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('51D7A246-3BE6-02F7-0DE8-87622267DA69'), name: '', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: null, connectable: false, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -92);

  static var scanResultR06 = ScanResultProxy.mock(
      deviceProxy:
          BluetoothDeviceProxy.mock(id: const DeviceIdentifier('53D52CBD-900A-99EA-3050-83F08AD76AC8'), name: '[TV] madness65i', type: BluetoothDeviceType.le),
      advertisementDataProxy: AdvertisementDataProxy.mock(localName: '[TV] madness65i', txPowerLevel: null, connectable: true, manufacturerData: {
        117: [66, 4, 1, 32, 126, 24, 7, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      }, serviceData: {}, serviceUuids: []),
      rssi: -75);

  static var scanResultR07 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('937C762B-FCDC-78E5-EFCC-85DFC677EAA8'), name: '', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: null, connectable: false, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -43);

  static var scanResultR08 = ScanResultProxy.mock(
      deviceProxy:
          BluetoothDeviceProxy.mock(id: const DeviceIdentifier('C61A1540-3855-EF76-FEB6-8CE580C9D284'), name: 'zorp1 (2)', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: null, connectable: true, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -40);

  static var scanResultR09 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('AD66E916-956B-3EE4-302C-3DC7FFDCEB6C'), name: '', type: BluetoothDeviceType.le),
      advertisementDataProxy: AdvertisementDataProxy.mock(localName: '', txPowerLevel: null, connectable: true, manufacturerData: {
        1422: [49, 87, 77, 72, 72, 65, 54, 50, 90, 77, 50, 48, 50, 52]
      }, serviceData: {
        'FEB8': [32, 1]
      }, serviceUuids: [
        'FEB8'
      ]),
      rssi: -77);

  static var scanResultR10 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('9AC82A0C-17FF-9448-80D6-6D2A81480195'), name: '', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: 7, connectable: true, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -96);

  static var scanResultR11 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('DC7CEA84-E004-E127-6997-35685EC0A5D4'), name: '', type: BluetoothDeviceType.le),
      advertisementDataProxy: AdvertisementDataProxy.mock(localName: '', txPowerLevel: null, connectable: false, manufacturerData: {
        224: [68, 74, 202, 87, 6, 120]
      }, serviceData: {
        'FE9F': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      }, serviceUuids: [
        'FE9F'
      ]),
      rssi: -92);

  static var scanResultR12 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('D660EA55-E63A-07CB-7A31-249C189D6DF8'), name: 'Mabuti', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: 12, connectable: true, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -60);

  static var scanResultR13 = ScanResultProxy.mock(
      deviceProxy:
          BluetoothDeviceProxy.mock(id: const DeviceIdentifier('2307D77D-1B9C-AA58-80CD-4A72E8E9B344'), name: 'Apple TV', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: 12, connectable: true, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -91);

  static var scanResultR14 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('D520AD85-6C12-9E92-5E5C-C15946A183C6'), name: '', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: null, connectable: false, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -77);

  static var scanResultR15 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('B7A45E3D-2CE7-A053-380F-3EE01E3DF76C'), name: '', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: 7, connectable: true, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -74);

  static var scanResultR16 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('1DEEC1A1-AE11-5C14-723C-EA40C6740FC3'), name: '', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: 8, connectable: true, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -78);

  static var scanResultR17 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('D42AEB5F-329A-64F1-1F2E-35A1BCDA4E97'), name: '', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: 6, connectable: true, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -89);

  static var scanResultR18 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('793EFBC9-4DFD-570F-9AC9-B0BB92631012'), name: '', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: null, connectable: false, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -96);

  static var scanResultR19 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('D3994F5C-FA85-7A9A-D08F-7743284E89E4'), name: '', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: null, connectable: false, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -75);

  static var scanResultR20 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('40881674-EB04-3A66-AF8B-4BA24CDA4376'), name: '', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: null, connectable: false, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -89);

  static var scanResultR21 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('8AFC240C-E978-970B-B55E-ABB7B939A742'), name: '', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: null, connectable: false, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -44);

  static var scanResultR22 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('AD155695-3B95-A95A-7B05-56B576B34D85'), name: '', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: null, connectable: false, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -95);

  static var scanResultR23 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('64260D14-3DEC-1448-6FE5-F47EB5AC648B'), name: '', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: null, connectable: false, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -84);

  static var scanResultR24 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('96EB6E38-408F-6007-D725-998243A3A09F'), name: '', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: null, connectable: false, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -45);

  static var scanResultR25 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('8964F807-D795-F68D-1A60-A49C60E2BFFF'), name: '', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: null, connectable: false, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -77);

  static var scanResultR26 = ScanResultProxy.mock(
      deviceProxy:
          BluetoothDeviceProxy.mock(id: const DeviceIdentifier('15DDACA3-A0FC-72BE-A5CA-D90152DBCE27'), name: 'Gemma Controller', type: BluetoothDeviceType.le),
      advertisementDataProxy: AdvertisementDataProxy.mock(
          localName: 'Gemma Controller', txPowerLevel: 3, connectable: true, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -79);

  static var scanResultR27 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('A197BA44-173A-DF09-E529-B6A0C62C05D3'), name: '', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: null, connectable: false, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -88);

  static var scanResultR28 = ScanResultProxy.mock(
      deviceProxy: BluetoothDeviceProxy.mock(id: const DeviceIdentifier('0124248B-6F85-4A29-7E63-244BD58798F2'), name: '', type: BluetoothDeviceType.le),
      advertisementDataProxy:
          AdvertisementDataProxy.mock(localName: '', txPowerLevel: 7, connectable: true, manufacturerData: {}, serviceData: {}, serviceUuids: []),
      rssi: -96);

  static var allScanResults = <ScanResultProxy>[
    scanResultR01,
    scanResultR02,
    scanResultR03,
    scanResultR04,
    scanResultR05,
    scanResultR06,
    scanResultR07,
    scanResultR08,
    scanResultR09,
    scanResultR10,
    scanResultR11,
    scanResultR12,
    scanResultR13,
    scanResultR14,
    scanResultR15,
    scanResultR16,
    scanResultR17,
    scanResultR18,
    scanResultR19,
    scanResultR20,
    scanResultR21,
    scanResultR22,
    scanResultR23,
    scanResultR24,
    scanResultR25,
    scanResultR26,
    scanResultR27,
    scanResultR28
  ];

  static var deviceD01 = BluetoothDeviceProxy.mock(
      id: const DeviceIdentifier('03E6DB15-C3EC-C339-DEEE-DEAF46A90C67'), name: 'LE-Bose Revolve SoundLink', type: BluetoothDeviceType.le);

  static var serviceD01s01 = BluetoothServiceProxy.mock(
      uuid: Guid('0000febe-0000-1000-8000-00805f9b34fb'),
      deviceId: const DeviceIdentifier('03E6DB15-C3EC-C339-DEEE-DEAF46A90C67'),
      isPrimary: true,
      characteristics: [
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('9ec813b4-256b-4090-93a8-a4f0e9107733'),
            deviceId: const DeviceIdentifier('03E6DB15-C3EC-C339-DEEE-DEAF46A90C67'),
            serviceUuid: Guid('0000febe-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: true,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002902-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('03E6DB15-C3EC-C339-DEEE-DEAF46A90C67'),
                  serviceUuid: Guid('0000febe-0000-1000-8000-00805f9b34fb'),
                  characteristicUuid: Guid('9ec813b4-256b-4090-93a8-a4f0e9107733'))
            ]),
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('d417c028-9818-4354-99d1-2ac09d074591'),
            deviceId: const DeviceIdentifier('03E6DB15-C3EC-C339-DEEE-DEAF46A90C67'),
            serviceUuid: Guid('0000febe-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: true,
                write: true,
                notify: true,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002902-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('03E6DB15-C3EC-C339-DEEE-DEAF46A90C67'),
                  serviceUuid: Guid('0000febe-0000-1000-8000-00805f9b34fb'),
                  characteristicUuid: Guid('d417c028-9818-4354-99d1-2ac09d074591'))
            ]),
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('234bfbd5-e3b3-4536-a3fe-723620d4b78d'),
            deviceId: const DeviceIdentifier('03E6DB15-C3EC-C339-DEEE-DEAF46A90C67'),
            serviceUuid: Guid('0000febe-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: false,
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
      includedServices: []);

  static var serviceD01s02 = BluetoothServiceProxy.mock(
      uuid: Guid('0000180a-0000-1000-8000-00805f9b34fb'),
      deviceId: const DeviceIdentifier('03E6DB15-C3EC-C339-DEEE-DEAF46A90C67'),
      isPrimary: true,
      characteristics: [
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('00002a29-0000-1000-8000-00805f9b34fb'),
            deviceId: const DeviceIdentifier('03E6DB15-C3EC-C339-DEEE-DEAF46A90C67'),
            serviceUuid: Guid('0000180a-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: false,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: []),
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('00002a24-0000-1000-8000-00805f9b34fb'),
            deviceId: const DeviceIdentifier('03E6DB15-C3EC-C339-DEEE-DEAF46A90C67'),
            serviceUuid: Guid('0000180a-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: false,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: []),
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('00002a25-0000-1000-8000-00805f9b34fb'),
            deviceId: const DeviceIdentifier('03E6DB15-C3EC-C339-DEEE-DEAF46A90C67'),
            serviceUuid: Guid('0000180a-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: false,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: []),
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('00002a27-0000-1000-8000-00805f9b34fb'),
            deviceId: const DeviceIdentifier('03E6DB15-C3EC-C339-DEEE-DEAF46A90C67'),
            serviceUuid: Guid('0000180a-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: false,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: []),
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('00002a26-0000-1000-8000-00805f9b34fb'),
            deviceId: const DeviceIdentifier('03E6DB15-C3EC-C339-DEEE-DEAF46A90C67'),
            serviceUuid: Guid('0000180a-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: false,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: []),
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('00002a28-0000-1000-8000-00805f9b34fb'),
            deviceId: const DeviceIdentifier('03E6DB15-C3EC-C339-DEEE-DEAF46A90C67'),
            serviceUuid: Guid('0000180a-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: false,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: []),
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('00002a23-0000-1000-8000-00805f9b34fb'),
            deviceId: const DeviceIdentifier('03E6DB15-C3EC-C339-DEEE-DEAF46A90C67'),
            serviceUuid: Guid('0000180a-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: false,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: []),
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('00002a50-0000-1000-8000-00805f9b34fb'),
            deviceId: const DeviceIdentifier('03E6DB15-C3EC-C339-DEEE-DEAF46A90C67'),
            serviceUuid: Guid('0000180a-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: false,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [])
      ],
      includedServices: []);

  static var servicesOfDeviceD01 = [serviceD01s01, serviceD01s02];

  static var deviceD02 =
      BluetoothDeviceProxy.mock(id: const DeviceIdentifier('15DDACA3-A0FC-72BE-A5CA-D90152DBCE27'), name: 'Gemma Controller', type: BluetoothDeviceType.le);

  static var serviceD02s01 = BluetoothServiceProxy.mock(
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
            descriptors: []),
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('14cdad1f-1b15-41ee-9f51-d5caaf940d02'),
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
            descriptors: []),
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('14cdad1f-1b15-41ee-9f51-d5caaf940d03'),
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
      includedServices: []);

  static var servicesOfDeviceD02 = [serviceD02s01];

  static var deviceD03 = BluetoothDeviceProxy.mock(id: const DeviceIdentifier('B7A45E3D-2CE7-A053-380F-3EE01E3DF76C'), name: '', type: BluetoothDeviceType.le);

  static var serviceD03s01 = BluetoothServiceProxy.mock(
      uuid: Guid('d0611e78-bbb4-4591-a5f8-487910ae4366'),
      deviceId: const DeviceIdentifier('B7A45E3D-2CE7-A053-380F-3EE01E3DF76C'),
      isPrimary: true,
      characteristics: [
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('8667556c-9a37-4c91-84ed-54ee27d90049'),
            deviceId: const DeviceIdentifier('B7A45E3D-2CE7-A053-380F-3EE01E3DF76C'),
            serviceUuid: Guid('d0611e78-bbb4-4591-a5f8-487910ae4366'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: false,
                writeWithoutResponse: false,
                write: true,
                notify: true,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: true,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002900-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('B7A45E3D-2CE7-A053-380F-3EE01E3DF76C'),
                  serviceUuid: Guid('d0611e78-bbb4-4591-a5f8-487910ae4366'),
                  characteristicUuid: Guid('8667556c-9a37-4c91-84ed-54ee27d90049')),
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002902-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('B7A45E3D-2CE7-A053-380F-3EE01E3DF76C'),
                  serviceUuid: Guid('d0611e78-bbb4-4591-a5f8-487910ae4366'),
                  characteristicUuid: Guid('8667556c-9a37-4c91-84ed-54ee27d90049'))
            ])
      ],
      includedServices: []);

  static var serviceD03s02 = BluetoothServiceProxy.mock(
      uuid: Guid('9fa480e0-4967-4542-9390-d343dc5d04ae'),
      deviceId: const DeviceIdentifier('B7A45E3D-2CE7-A053-380F-3EE01E3DF76C'),
      isPrimary: true,
      characteristics: [
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('af0badb1-5b99-43cd-917a-a77bc549e3cc'),
            deviceId: const DeviceIdentifier('B7A45E3D-2CE7-A053-380F-3EE01E3DF76C'),
            serviceUuid: Guid('9fa480e0-4967-4542-9390-d343dc5d04ae'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: false,
                writeWithoutResponse: false,
                write: true,
                notify: true,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: true,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002900-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('B7A45E3D-2CE7-A053-380F-3EE01E3DF76C'),
                  serviceUuid: Guid('9fa480e0-4967-4542-9390-d343dc5d04ae'),
                  characteristicUuid: Guid('af0badb1-5b99-43cd-917a-a77bc549e3cc')),
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002902-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('B7A45E3D-2CE7-A053-380F-3EE01E3DF76C'),
                  serviceUuid: Guid('9fa480e0-4967-4542-9390-d343dc5d04ae'),
                  characteristicUuid: Guid('af0badb1-5b99-43cd-917a-a77bc549e3cc'))
            ])
      ],
      includedServices: []);

  static var serviceD03s03 = BluetoothServiceProxy.mock(
      uuid: Guid('0000180f-0000-1000-8000-00805f9b34fb'),
      deviceId: const DeviceIdentifier('B7A45E3D-2CE7-A053-380F-3EE01E3DF76C'),
      isPrimary: true,
      characteristics: [
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('00002a19-0000-1000-8000-00805f9b34fb'),
            deviceId: const DeviceIdentifier('B7A45E3D-2CE7-A053-380F-3EE01E3DF76C'),
            serviceUuid: Guid('0000180f-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: true,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002902-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('B7A45E3D-2CE7-A053-380F-3EE01E3DF76C'),
                  serviceUuid: Guid('0000180f-0000-1000-8000-00805f9b34fb'),
                  characteristicUuid: Guid('00002a19-0000-1000-8000-00805f9b34fb'))
            ])
      ],
      includedServices: []);

  static var serviceD03s04 = BluetoothServiceProxy.mock(
      uuid: Guid('00001805-0000-1000-8000-00805f9b34fb'),
      deviceId: const DeviceIdentifier('B7A45E3D-2CE7-A053-380F-3EE01E3DF76C'),
      isPrimary: true,
      characteristics: [
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('00002a2b-0000-1000-8000-00805f9b34fb'),
            deviceId: const DeviceIdentifier('B7A45E3D-2CE7-A053-380F-3EE01E3DF76C'),
            serviceUuid: Guid('00001805-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: true,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002902-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('B7A45E3D-2CE7-A053-380F-3EE01E3DF76C'),
                  serviceUuid: Guid('00001805-0000-1000-8000-00805f9b34fb'),
                  characteristicUuid: Guid('00002a2b-0000-1000-8000-00805f9b34fb'))
            ]),
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('00002a0f-0000-1000-8000-00805f9b34fb'),
            deviceId: const DeviceIdentifier('B7A45E3D-2CE7-A053-380F-3EE01E3DF76C'),
            serviceUuid: Guid('00001805-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: false,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [])
      ],
      includedServices: []);

  static var serviceD03s05 = BluetoothServiceProxy.mock(
      uuid: Guid('0000180a-0000-1000-8000-00805f9b34fb'),
      deviceId: const DeviceIdentifier('B7A45E3D-2CE7-A053-380F-3EE01E3DF76C'),
      isPrimary: true,
      characteristics: [
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('00002a29-0000-1000-8000-00805f9b34fb'),
            deviceId: const DeviceIdentifier('B7A45E3D-2CE7-A053-380F-3EE01E3DF76C'),
            serviceUuid: Guid('0000180a-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: false,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: []),
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('00002a24-0000-1000-8000-00805f9b34fb'),
            deviceId: const DeviceIdentifier('B7A45E3D-2CE7-A053-380F-3EE01E3DF76C'),
            serviceUuid: Guid('0000180a-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: false,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [])
      ],
      includedServices: []);

  static var servicesOfDeviceD03 = [serviceD03s01, serviceD03s02, serviceD03s03, serviceD03s04, serviceD03s05];

  static var deviceD04 = BluetoothDeviceProxy.mock(id: const DeviceIdentifier('64DFDBB6-0AD6-21A3-0768-D78DA8574C47'), name: '', type: BluetoothDeviceType.le);

  static var servicesOfDeviceD04 = [];

  static var deviceD05 =
      BluetoothDeviceProxy.mock(id: const DeviceIdentifier('285F2D6B-B0D9-5748-EFF7-6A21AB4461A8'), name: 'Apple TV', type: BluetoothDeviceType.le);

  static var serviceD05s01 = BluetoothServiceProxy.mock(
      uuid: Guid('d0611e78-bbb4-4591-a5f8-487910ae4366'),
      deviceId: const DeviceIdentifier('285F2D6B-B0D9-5748-EFF7-6A21AB4461A8'),
      isPrimary: true,
      characteristics: [
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('8667556c-9a37-4c91-84ed-54ee27d90049'),
            deviceId: const DeviceIdentifier('285F2D6B-B0D9-5748-EFF7-6A21AB4461A8'),
            serviceUuid: Guid('d0611e78-bbb4-4591-a5f8-487910ae4366'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: false,
                writeWithoutResponse: false,
                write: true,
                notify: true,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: true,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002900-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('285F2D6B-B0D9-5748-EFF7-6A21AB4461A8'),
                  serviceUuid: Guid('d0611e78-bbb4-4591-a5f8-487910ae4366'),
                  characteristicUuid: Guid('8667556c-9a37-4c91-84ed-54ee27d90049')),
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002902-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('285F2D6B-B0D9-5748-EFF7-6A21AB4461A8'),
                  serviceUuid: Guid('d0611e78-bbb4-4591-a5f8-487910ae4366'),
                  characteristicUuid: Guid('8667556c-9a37-4c91-84ed-54ee27d90049'))
            ])
      ],
      includedServices: []);

  static var serviceD05s02 = BluetoothServiceProxy.mock(
      uuid: Guid('9fa480e0-4967-4542-9390-d343dc5d04ae'),
      deviceId: const DeviceIdentifier('285F2D6B-B0D9-5748-EFF7-6A21AB4461A8'),
      isPrimary: true,
      characteristics: [
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('af0badb1-5b99-43cd-917a-a77bc549e3cc'),
            deviceId: const DeviceIdentifier('285F2D6B-B0D9-5748-EFF7-6A21AB4461A8'),
            serviceUuid: Guid('9fa480e0-4967-4542-9390-d343dc5d04ae'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: false,
                writeWithoutResponse: false,
                write: true,
                notify: true,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: true,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002900-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('285F2D6B-B0D9-5748-EFF7-6A21AB4461A8'),
                  serviceUuid: Guid('9fa480e0-4967-4542-9390-d343dc5d04ae'),
                  characteristicUuid: Guid('af0badb1-5b99-43cd-917a-a77bc549e3cc')),
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002902-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('285F2D6B-B0D9-5748-EFF7-6A21AB4461A8'),
                  serviceUuid: Guid('9fa480e0-4967-4542-9390-d343dc5d04ae'),
                  characteristicUuid: Guid('af0badb1-5b99-43cd-917a-a77bc549e3cc'))
            ])
      ],
      includedServices: []);

  static var servicesOfDeviceD05 = [serviceD05s01, serviceD05s02];

  static var deviceD06 = BluetoothDeviceProxy.mock(id: const DeviceIdentifier('1DEEC1A1-AE11-5C14-723C-EA40C6740FC3'), name: '', type: BluetoothDeviceType.le);

  static var serviceD06s01 = BluetoothServiceProxy.mock(
      uuid: Guid('d0611e78-bbb4-4591-a5f8-487910ae4366'),
      deviceId: const DeviceIdentifier('1DEEC1A1-AE11-5C14-723C-EA40C6740FC3'),
      isPrimary: true,
      characteristics: [
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('8667556c-9a37-4c91-84ed-54ee27d90049'),
            deviceId: const DeviceIdentifier('1DEEC1A1-AE11-5C14-723C-EA40C6740FC3'),
            serviceUuid: Guid('d0611e78-bbb4-4591-a5f8-487910ae4366'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: false,
                writeWithoutResponse: false,
                write: true,
                notify: true,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: true,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002900-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('1DEEC1A1-AE11-5C14-723C-EA40C6740FC3'),
                  serviceUuid: Guid('d0611e78-bbb4-4591-a5f8-487910ae4366'),
                  characteristicUuid: Guid('8667556c-9a37-4c91-84ed-54ee27d90049')),
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002902-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('1DEEC1A1-AE11-5C14-723C-EA40C6740FC3'),
                  serviceUuid: Guid('d0611e78-bbb4-4591-a5f8-487910ae4366'),
                  characteristicUuid: Guid('8667556c-9a37-4c91-84ed-54ee27d90049'))
            ])
      ],
      includedServices: []);

  static var serviceD06s02 = BluetoothServiceProxy.mock(
      uuid: Guid('9fa480e0-4967-4542-9390-d343dc5d04ae'),
      deviceId: const DeviceIdentifier('1DEEC1A1-AE11-5C14-723C-EA40C6740FC3'),
      isPrimary: true,
      characteristics: [
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('af0badb1-5b99-43cd-917a-a77bc549e3cc'),
            deviceId: const DeviceIdentifier('1DEEC1A1-AE11-5C14-723C-EA40C6740FC3'),
            serviceUuid: Guid('9fa480e0-4967-4542-9390-d343dc5d04ae'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: false,
                writeWithoutResponse: false,
                write: true,
                notify: true,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: true,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002900-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('1DEEC1A1-AE11-5C14-723C-EA40C6740FC3'),
                  serviceUuid: Guid('9fa480e0-4967-4542-9390-d343dc5d04ae'),
                  characteristicUuid: Guid('af0badb1-5b99-43cd-917a-a77bc549e3cc')),
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002902-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('1DEEC1A1-AE11-5C14-723C-EA40C6740FC3'),
                  serviceUuid: Guid('9fa480e0-4967-4542-9390-d343dc5d04ae'),
                  characteristicUuid: Guid('af0badb1-5b99-43cd-917a-a77bc549e3cc'))
            ])
      ],
      includedServices: []);

  static var serviceD06s03 = BluetoothServiceProxy.mock(
      uuid: Guid('0000180f-0000-1000-8000-00805f9b34fb'),
      deviceId: const DeviceIdentifier('1DEEC1A1-AE11-5C14-723C-EA40C6740FC3'),
      isPrimary: true,
      characteristics: [
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('00002a19-0000-1000-8000-00805f9b34fb'),
            deviceId: const DeviceIdentifier('1DEEC1A1-AE11-5C14-723C-EA40C6740FC3'),
            serviceUuid: Guid('0000180f-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: true,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002902-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('1DEEC1A1-AE11-5C14-723C-EA40C6740FC3'),
                  serviceUuid: Guid('0000180f-0000-1000-8000-00805f9b34fb'),
                  characteristicUuid: Guid('00002a19-0000-1000-8000-00805f9b34fb'))
            ])
      ],
      includedServices: []);

  static var serviceD06s04 = BluetoothServiceProxy.mock(
      uuid: Guid('00001805-0000-1000-8000-00805f9b34fb'),
      deviceId: const DeviceIdentifier('1DEEC1A1-AE11-5C14-723C-EA40C6740FC3'),
      isPrimary: true,
      characteristics: [
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('00002a2b-0000-1000-8000-00805f9b34fb'),
            deviceId: const DeviceIdentifier('1DEEC1A1-AE11-5C14-723C-EA40C6740FC3'),
            serviceUuid: Guid('00001805-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: true,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002902-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('1DEEC1A1-AE11-5C14-723C-EA40C6740FC3'),
                  serviceUuid: Guid('00001805-0000-1000-8000-00805f9b34fb'),
                  characteristicUuid: Guid('00002a2b-0000-1000-8000-00805f9b34fb'))
            ]),
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('00002a0f-0000-1000-8000-00805f9b34fb'),
            deviceId: const DeviceIdentifier('1DEEC1A1-AE11-5C14-723C-EA40C6740FC3'),
            serviceUuid: Guid('00001805-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: false,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [])
      ],
      includedServices: []);

  static var serviceD06s05 = BluetoothServiceProxy.mock(
      uuid: Guid('0000180a-0000-1000-8000-00805f9b34fb'),
      deviceId: const DeviceIdentifier('1DEEC1A1-AE11-5C14-723C-EA40C6740FC3'),
      isPrimary: true,
      characteristics: [
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('00002a29-0000-1000-8000-00805f9b34fb'),
            deviceId: const DeviceIdentifier('1DEEC1A1-AE11-5C14-723C-EA40C6740FC3'),
            serviceUuid: Guid('0000180a-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: false,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: []),
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('00002a24-0000-1000-8000-00805f9b34fb'),
            deviceId: const DeviceIdentifier('1DEEC1A1-AE11-5C14-723C-EA40C6740FC3'),
            serviceUuid: Guid('0000180a-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: false,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [])
      ],
      includedServices: []);

  static var servicesOfDeviceD06 = [serviceD06s01, serviceD06s02, serviceD06s03, serviceD06s04, serviceD06s05];

  static var deviceD07 =
      BluetoothDeviceProxy.mock(id: const DeviceIdentifier('D660EA55-E63A-07CB-7A31-249C189D6DF8'), name: 'Mabuti', type: BluetoothDeviceType.le);

  static var serviceD07s01 = BluetoothServiceProxy.mock(
      uuid: Guid('d0611e78-bbb4-4591-a5f8-487910ae4366'),
      deviceId: const DeviceIdentifier('D660EA55-E63A-07CB-7A31-249C189D6DF8'),
      isPrimary: true,
      characteristics: [
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('8667556c-9a37-4c91-84ed-54ee27d90049'),
            deviceId: const DeviceIdentifier('D660EA55-E63A-07CB-7A31-249C189D6DF8'),
            serviceUuid: Guid('d0611e78-bbb4-4591-a5f8-487910ae4366'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: false,
                writeWithoutResponse: false,
                write: true,
                notify: true,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: true,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002900-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('D660EA55-E63A-07CB-7A31-249C189D6DF8'),
                  serviceUuid: Guid('d0611e78-bbb4-4591-a5f8-487910ae4366'),
                  characteristicUuid: Guid('8667556c-9a37-4c91-84ed-54ee27d90049')),
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002902-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('D660EA55-E63A-07CB-7A31-249C189D6DF8'),
                  serviceUuid: Guid('d0611e78-bbb4-4591-a5f8-487910ae4366'),
                  characteristicUuid: Guid('8667556c-9a37-4c91-84ed-54ee27d90049'))
            ])
      ],
      includedServices: []);

  static var serviceD07s02 = BluetoothServiceProxy.mock(
      uuid: Guid('9fa480e0-4967-4542-9390-d343dc5d04ae'),
      deviceId: const DeviceIdentifier('D660EA55-E63A-07CB-7A31-249C189D6DF8'),
      isPrimary: true,
      characteristics: [
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('af0badb1-5b99-43cd-917a-a77bc549e3cc'),
            deviceId: const DeviceIdentifier('D660EA55-E63A-07CB-7A31-249C189D6DF8'),
            serviceUuid: Guid('9fa480e0-4967-4542-9390-d343dc5d04ae'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: false,
                writeWithoutResponse: false,
                write: true,
                notify: true,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: true,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002900-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('D660EA55-E63A-07CB-7A31-249C189D6DF8'),
                  serviceUuid: Guid('9fa480e0-4967-4542-9390-d343dc5d04ae'),
                  characteristicUuid: Guid('af0badb1-5b99-43cd-917a-a77bc549e3cc')),
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002902-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('D660EA55-E63A-07CB-7A31-249C189D6DF8'),
                  serviceUuid: Guid('9fa480e0-4967-4542-9390-d343dc5d04ae'),
                  characteristicUuid: Guid('af0badb1-5b99-43cd-917a-a77bc549e3cc'))
            ])
      ],
      includedServices: []);

  static var serviceD07s03 = BluetoothServiceProxy.mock(
      uuid: Guid('0000180f-0000-1000-8000-00805f9b34fb'),
      deviceId: const DeviceIdentifier('D660EA55-E63A-07CB-7A31-249C189D6DF8'),
      isPrimary: true,
      characteristics: [
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('00002a19-0000-1000-8000-00805f9b34fb'),
            deviceId: const DeviceIdentifier('D660EA55-E63A-07CB-7A31-249C189D6DF8'),
            serviceUuid: Guid('0000180f-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: true,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002902-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('D660EA55-E63A-07CB-7A31-249C189D6DF8'),
                  serviceUuid: Guid('0000180f-0000-1000-8000-00805f9b34fb'),
                  characteristicUuid: Guid('00002a19-0000-1000-8000-00805f9b34fb'))
            ])
      ],
      includedServices: []);

  static var serviceD07s04 = BluetoothServiceProxy.mock(
      uuid: Guid('00001805-0000-1000-8000-00805f9b34fb'),
      deviceId: const DeviceIdentifier('D660EA55-E63A-07CB-7A31-249C189D6DF8'),
      isPrimary: true,
      characteristics: [
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('00002a2b-0000-1000-8000-00805f9b34fb'),
            deviceId: const DeviceIdentifier('D660EA55-E63A-07CB-7A31-249C189D6DF8'),
            serviceUuid: Guid('00001805-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: true,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002902-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('D660EA55-E63A-07CB-7A31-249C189D6DF8'),
                  serviceUuid: Guid('00001805-0000-1000-8000-00805f9b34fb'),
                  characteristicUuid: Guid('00002a2b-0000-1000-8000-00805f9b34fb'))
            ]),
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('00002a0f-0000-1000-8000-00805f9b34fb'),
            deviceId: const DeviceIdentifier('D660EA55-E63A-07CB-7A31-249C189D6DF8'),
            serviceUuid: Guid('00001805-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: false,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [])
      ],
      includedServices: []);

  static var serviceD07s05 = BluetoothServiceProxy.mock(
      uuid: Guid('0000180a-0000-1000-8000-00805f9b34fb'),
      deviceId: const DeviceIdentifier('D660EA55-E63A-07CB-7A31-249C189D6DF8'),
      isPrimary: true,
      characteristics: [
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('00002a29-0000-1000-8000-00805f9b34fb'),
            deviceId: const DeviceIdentifier('D660EA55-E63A-07CB-7A31-249C189D6DF8'),
            serviceUuid: Guid('0000180a-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: false,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: []),
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('00002a24-0000-1000-8000-00805f9b34fb'),
            deviceId: const DeviceIdentifier('D660EA55-E63A-07CB-7A31-249C189D6DF8'),
            serviceUuid: Guid('0000180a-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: false,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [])
      ],
      includedServices: []);

  static var servicesOfDeviceD07 = [serviceD07s01, serviceD07s02, serviceD07s03, serviceD07s04, serviceD07s05];

  static var deviceD08 = BluetoothDeviceProxy.mock(id: const DeviceIdentifier('AD66E916-956B-3EE4-302C-3DC7FFDCEB6C'), name: '', type: BluetoothDeviceType.le);

  static var serviceD08s01 = BluetoothServiceProxy.mock(
      uuid: Guid('0000feb8-0000-1000-8000-00805f9b34fb'),
      deviceId: const DeviceIdentifier('AD66E916-956B-3EE4-302C-3DC7FFDCEB6C'),
      isPrimary: true,
      characteristics: [
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('7a442881-509c-47fa-ac02-b06a37d9eb76'),
            deviceId: const DeviceIdentifier('AD66E916-956B-3EE4-302C-3DC7FFDCEB6C'),
            serviceUuid: Guid('0000feb8-0000-1000-8000-00805f9b34fb'),
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
            descriptors: [
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002902-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('AD66E916-956B-3EE4-302C-3DC7FFDCEB6C'),
                  serviceUuid: Guid('0000feb8-0000-1000-8000-00805f9b34fb'),
                  characteristicUuid: Guid('7a442881-509c-47fa-ac02-b06a37d9eb76'))
            ]),
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('7a442666-509c-47fa-ac02-b06a37d9eb76'),
            deviceId: const DeviceIdentifier('AD66E916-956B-3EE4-302C-3DC7FFDCEB6C'),
            serviceUuid: Guid('0000feb8-0000-1000-8000-00805f9b34fb'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: true,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002902-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('AD66E916-956B-3EE4-302C-3DC7FFDCEB6C'),
                  serviceUuid: Guid('0000feb8-0000-1000-8000-00805f9b34fb'),
                  characteristicUuid: Guid('7a442666-509c-47fa-ac02-b06a37d9eb76'))
            ])
      ],
      includedServices: []);

  static var servicesOfDeviceD08 = [serviceD08s01];

  static var deviceD09 =
      BluetoothDeviceProxy.mock(id: const DeviceIdentifier('53D52CBD-900A-99EA-3050-83F08AD76AC8'), name: '[TV] madness65i', type: BluetoothDeviceType.le);

  static var serviceD09s01 = BluetoothServiceProxy.mock(
      uuid: Guid('ade3d529-c784-4f63-a987-eb69f70ee816'),
      deviceId: const DeviceIdentifier('53D52CBD-900A-99EA-3050-83F08AD76AC8'),
      isPrimary: true,
      characteristics: [
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('e9241982-4580-42c4-8831-95048216b256'),
            deviceId: const DeviceIdentifier('53D52CBD-900A-99EA-3050-83F08AD76AC8'),
            serviceUuid: Guid('ade3d529-c784-4f63-a987-eb69f70ee816'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: true,
                writeWithoutResponse: false,
                write: false,
                notify: false,
                indicate: true,
                authenticatedSignedWrites: false,
                extendedProperties: false,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: []),
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('ad7b334f-4637-4b86-90b6-9d787f03d218'),
            deviceId: const DeviceIdentifier('53D52CBD-900A-99EA-3050-83F08AD76AC8'),
            serviceUuid: Guid('ade3d529-c784-4f63-a987-eb69f70ee816'),
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
            descriptors: [
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002902-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('53D52CBD-900A-99EA-3050-83F08AD76AC8'),
                  serviceUuid: Guid('ade3d529-c784-4f63-a987-eb69f70ee816'),
                  characteristicUuid: Guid('ad7b334f-4637-4b86-90b6-9d787f03d218'))
            ])
      ],
      includedServices: []);

  static var servicesOfDeviceD09 = [serviceD09s01];

  static var deviceD10 = BluetoothDeviceProxy.mock(id: const DeviceIdentifier('D42AEB5F-329A-64F1-1F2E-35A1BCDA4E97'), name: '', type: BluetoothDeviceType.le);

  static var serviceD10s01 = BluetoothServiceProxy.mock(
      uuid: Guid('d0611e78-bbb4-4591-a5f8-487910ae4366'),
      deviceId: const DeviceIdentifier('D42AEB5F-329A-64F1-1F2E-35A1BCDA4E97'),
      isPrimary: true,
      characteristics: [
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('8667556c-9a37-4c91-84ed-54ee27d90049'),
            deviceId: const DeviceIdentifier('D42AEB5F-329A-64F1-1F2E-35A1BCDA4E97'),
            serviceUuid: Guid('d0611e78-bbb4-4591-a5f8-487910ae4366'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: false,
                writeWithoutResponse: false,
                write: true,
                notify: true,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: true,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002900-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('D42AEB5F-329A-64F1-1F2E-35A1BCDA4E97'),
                  serviceUuid: Guid('d0611e78-bbb4-4591-a5f8-487910ae4366'),
                  characteristicUuid: Guid('8667556c-9a37-4c91-84ed-54ee27d90049')),
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002902-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('D42AEB5F-329A-64F1-1F2E-35A1BCDA4E97'),
                  serviceUuid: Guid('d0611e78-bbb4-4591-a5f8-487910ae4366'),
                  characteristicUuid: Guid('8667556c-9a37-4c91-84ed-54ee27d90049'))
            ])
      ],
      includedServices: []);

  static var serviceD10s02 = BluetoothServiceProxy.mock(
      uuid: Guid('9fa480e0-4967-4542-9390-d343dc5d04ae'),
      deviceId: const DeviceIdentifier('D42AEB5F-329A-64F1-1F2E-35A1BCDA4E97'),
      isPrimary: true,
      characteristics: [
        BluetoothCharacteristicProxy.mock(
            uuid: Guid('af0badb1-5b99-43cd-917a-a77bc549e3cc'),
            deviceId: const DeviceIdentifier('D42AEB5F-329A-64F1-1F2E-35A1BCDA4E97'),
            serviceUuid: Guid('9fa480e0-4967-4542-9390-d343dc5d04ae'),
            secondaryServiceUuid: null,
            properties: const CharacteristicProperties(
                broadcast: false,
                read: false,
                writeWithoutResponse: false,
                write: true,
                notify: true,
                indicate: false,
                authenticatedSignedWrites: false,
                extendedProperties: true,
                notifyEncryptionRequired: false,
                indicateEncryptionRequired: false),
            descriptors: [
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002900-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('D42AEB5F-329A-64F1-1F2E-35A1BCDA4E97'),
                  serviceUuid: Guid('9fa480e0-4967-4542-9390-d343dc5d04ae'),
                  characteristicUuid: Guid('af0badb1-5b99-43cd-917a-a77bc549e3cc')),
              BluetoothDescriptorProxy.mock(
                  uuid: Guid('00002902-0000-1000-8000-00805f9b34fb'),
                  deviceId: const DeviceIdentifier('D42AEB5F-329A-64F1-1F2E-35A1BCDA4E97'),
                  serviceUuid: Guid('9fa480e0-4967-4542-9390-d343dc5d04ae'),
                  characteristicUuid: Guid('af0badb1-5b99-43cd-917a-a77bc549e3cc'))
            ])
      ],
      includedServices: []);

  static var servicesOfDeviceD10 = [serviceD10s01, serviceD10s02];

  static var deviceD11 = BluetoothDeviceProxy.mock(id: const DeviceIdentifier('0124248B-6F85-4A29-7E63-244BD58798F2'), name: '', type: BluetoothDeviceType.le);

  static var servicesOfDeviceD11 = [];

  static var deviceD12 = BluetoothDeviceProxy.mock(id: const DeviceIdentifier('14E0F147-F18B-4391-EA6B-64BBE0A8BCE2'), name: '', type: BluetoothDeviceType.le);

  static var servicesOfDeviceD12 = [];

  static var allDevices = <BluetoothDeviceProxy>[
    deviceD01,
    deviceD02,
    deviceD03,
    deviceD04,
    deviceD05,
    deviceD06,
    deviceD07,
    deviceD08,
    deviceD09,
    deviceD10,
    deviceD11,
    deviceD12
  ];

  static var allServices = <BluetoothServiceProxy>[
    serviceD01s01,
    serviceD01s02,
    serviceD02s01,
    serviceD03s01,
    serviceD03s02,
    serviceD03s03,
    serviceD03s04,
    serviceD03s05,
    serviceD05s01,
    serviceD05s02,
    serviceD06s01,
    serviceD06s02,
    serviceD06s03,
    serviceD06s04,
    serviceD06s05,
    serviceD07s01,
    serviceD07s02,
    serviceD07s03,
    serviceD07s04,
    serviceD07s05,
    serviceD08s01,
    serviceD09s01,
    serviceD10s01,
    serviceD10s02
  ];

  static var allServicesByDeviceId = <DeviceIdentifier, List<BluetoothServiceProxy>>{
    const DeviceIdentifier('03E6DB15-C3EC-C339-DEEE-DEAF46A90C67'): [serviceD01s01, serviceD01s02],
    const DeviceIdentifier('15DDACA3-A0FC-72BE-A5CA-D90152DBCE27'): [serviceD02s01],
    const DeviceIdentifier('B7A45E3D-2CE7-A053-380F-3EE01E3DF76C'): [serviceD03s01, serviceD03s02, serviceD03s03, serviceD03s04, serviceD03s05],
    const DeviceIdentifier('64DFDBB6-0AD6-21A3-0768-D78DA8574C47'): [],
    const DeviceIdentifier('285F2D6B-B0D9-5748-EFF7-6A21AB4461A8'): [serviceD05s01, serviceD05s02],
    const DeviceIdentifier('1DEEC1A1-AE11-5C14-723C-EA40C6740FC3'): [serviceD06s01, serviceD06s02, serviceD06s03, serviceD06s04, serviceD06s05],
    const DeviceIdentifier('D660EA55-E63A-07CB-7A31-249C189D6DF8'): [serviceD07s01, serviceD07s02, serviceD07s03, serviceD07s04, serviceD07s05],
    const DeviceIdentifier('AD66E916-956B-3EE4-302C-3DC7FFDCEB6C'): [serviceD08s01],
    const DeviceIdentifier('53D52CBD-900A-99EA-3050-83F08AD76AC8'): [serviceD09s01],
    const DeviceIdentifier('D42AEB5F-329A-64F1-1F2E-35A1BCDA4E97'): [serviceD10s01, serviceD10s02],
    const DeviceIdentifier('0124248B-6F85-4A29-7E63-244BD58798F2'): [],
    const DeviceIdentifier('14E0F147-F18B-4391-EA6B-64BBE0A8BCE2'): []
  };
}
