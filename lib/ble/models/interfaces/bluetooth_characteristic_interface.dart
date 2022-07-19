abstract class BluetoothCharacteristicInterface {
  bool get isNotifying;

  Stream<List<int>> get value;

  List<int> get lastValue;

  Stream<List<int>> get onValueChangedStream;

  Future<List<int>> read();

  // ignore: prefer_void_to_null
  Future<Null> write(List<int> value, {bool withoutResponse = false});

  Future<bool> setNotifyValue(bool notify);
}
