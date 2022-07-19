abstract class BluetoothDescriptorInterface {
  Stream<List<int>> get value;

  List<int> get lastValue;

  Future<List<int>> read();

  // ignore: prefer_void_to_null
  Future<Null> write(List<int> value);
}
