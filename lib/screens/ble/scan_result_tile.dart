import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:log_4_dart_2/log_4_dart_2.dart';

import '../../ble/models/proxies/bluetooth_device_proxy.dart';
import '../../ble/models/proxies/scan_result_proxy.dart';

class ScanResultTile extends StatelessWidget with Log4Dart {
  const ScanResultTile({Key? key, required this.result, this.onTap}) : super(key: key);

  final ScanResultProxy result;
  final VoidCallback? onTap;

  Widget _buildTitle(BuildContext context) {
    var deviceName = 'N/A';
    var deviceId = result.device.id.toString();
    if (result.device.name.isNotEmpty) {
      deviceName = result.device.name;
    }
    //logDebug('result.device : ${result.device.toString()}');
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          deviceName,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          deviceId,
          style: Theme.of(context).textTheme.caption,
        ),
        _streamDevState(context, result.device),
      ],
    );
  }

  Widget _buildAdvRow(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.caption),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.caption?.apply(color: Colors.black),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  String getNiceHexArray(List<int> bytes) {
    return '[${bytes.map((i) => i.toRadixString(16).padLeft(2, '0')).join(', ')}]'.toUpperCase();
  }

  String getNiceManufacturerData(Map<int, List<int>> data) {
    if (data.isEmpty) {
      return 'N/A';
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add('${id.toRadixString(16).toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  String getNiceServiceData(Map<String, List<int>> data) {
    if (data.isEmpty) {
      return 'N/A';
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add('${id.toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: _buildTitle(context),
      leading: Text(result.rssi.toString()),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          onPrimary: Colors.white,
        ),
        onPressed: (result.advertisementData.connectable) ? onTap : null,
        child: const Text('CONNECT'),
      ),
      children: <Widget>[
        _buildAdvRow(context, 'Complete Local Name', result.advertisementData.localName == '' ? 'N/A' : result.advertisementData.localName),
        _buildAdvRow(context, 'Tx Power Level', '${result.advertisementData.txPowerLevel ?? 'N/A'}'),
        _buildAdvRow(context, 'Manufacturer Data', getNiceManufacturerData(result.advertisementData.manufacturerData)),
        _buildAdvRow(context, 'Service UUIDs',
            (result.advertisementData.serviceUuids.isNotEmpty) ? result.advertisementData.serviceUuids.join(', ').toUpperCase() : 'N/A'),
        _buildAdvRow(context, 'Service Data', getNiceServiceData(result.advertisementData.serviceData)),
      ],
    );
  }

  StreamBuilder<BluetoothDeviceState> _streamDevState(BuildContext context, BluetoothDeviceProxy device) {
    return StreamBuilder<BluetoothDeviceState>(
      stream: device.state,
      initialData: BluetoothDeviceState.connecting,
      builder: (c, snapshot) {
        return Row(
          children: [
            Text(
              'BLE State: ',
              style: Theme.of(context).textTheme.caption,
            ),
            Text(
              '${snapshot.data?.name}',
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        );
      },
    );
  }
}
