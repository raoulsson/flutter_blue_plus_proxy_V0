// import 'package:flutter_blue/flutter_blue.dart';
//
// import '../interfaces/bluetooth_service_interface.dart';
//
// class BluetoothServiceProxy implements BluetoothServiceInterface {
//   late final Guid _uuid;
//   late final DeviceIdentifier _deviceId;
//   late final bool _isPrimary;
//   late final List<BluetoothCharacteristic> _characteristics;
//   late final List<BluetoothService> _includedServices;
//
//   BluetoothServiceProxy.name(this._uuid, this._deviceId, this._isPrimary, this._characteristics, this._includedServices);
//
//   @override
//   List<BluetoothCharacteristic> get characteristics {
//     return _characteristics;
//   }
//
//   @override
//   DeviceIdentifier get deviceId {
//     return _deviceId;
//   }
//
//   @override
//   List<BluetoothService> get includedServices {
//     return _includedServices;
//   }
//
//   @override
//   bool get isPrimary {
//     return _isPrimary;
//   }
//
//   @override
//   Guid get uuid {
//     return _uuid;
//   }
// }
