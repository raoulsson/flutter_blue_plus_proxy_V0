import 'dart:async';

import 'package:base_template_project/models/ble_device.dart';
import 'package:log_4_dart_2/log_4_dart_2.dart';

import 'bloc_provider.dart';

class BleBloc with Log4Dart implements BlocBase {
  final StreamController<List<BleDevice>> _listSender = StreamController<List<BleDevice>>.broadcast();
  Stream<List<BleDevice>> get bleDeviceListStream => _listSender.stream;

  final StreamController<BleDevice> _receiver = StreamController<BleDevice>.broadcast();
  StreamSink<BleDevice> get addBleSink => _receiver.sink;

  BleBloc() {
    dummyAsyncFill();

    _receiver.stream.listen((_) {
      _listSender.sink.add([_]);
    });
  }

  Future<void> dummyAsyncFill() async {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      addBleSink.add(BleDevice.randomBleDevice());
    }
  }

  @override
  void dispose() {
    _listSender.close();
    _receiver.close();
  }
}
