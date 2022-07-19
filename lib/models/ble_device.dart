import 'dart:math';

import 'package:uuid/uuid.dart';

class BleDevice {
  String uuid;
  String name;

  BleDevice({required this.uuid, required this.name});

  @override
  String toString() {
    return 'BleDevice{uuid: $uuid, name: $name}';
  }

  static BleDevice randomBleDevice() {
    Uuid uuid = const Uuid();
    String name = _randomString(8);
    return BleDevice(uuid: uuid.v4(), name: name);
  }

  static String _randomString(int length) {
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random rnd = Random();

    return String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }
}
