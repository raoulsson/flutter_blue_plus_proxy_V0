import 'package:flutter/material.dart';
import 'package:log_4_dart_2/log_4_dart_2.dart';

import '../../ble/models/proxies/bluetooth_service_proxy.dart';
import 'characteristics_tile.dart';

class ServiceTile extends StatefulWidget with Log4Dart {
  final BluetoothServiceProxy service;
  final List<CharacteristicTile> characteristicTiles;

  const ServiceTile({Key? key, required this.service, required this.characteristicTiles}) : super(key: key);

  @override
  State<ServiceTile> createState() => _ServiceTileState();
}

class _ServiceTileState extends State<ServiceTile> {
  var _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.characteristicTiles.isNotEmpty) {
      return ExpansionTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Service'),
            Text('0x${widget.service.uuid.toString().toUpperCase().substring(4, 8)}',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Theme.of(context).textTheme.caption?.color))
          ],
        ),
        initiallyExpanded: _isExpanded,
        onExpansionChanged: (x) {
          setState(() {
            _isExpanded = x;
          });
        },
        children: widget.characteristicTiles,
      );
    } else {
      return ListTile(
        title: const Text('Service'),
        subtitle: Text('0x${widget.service.uuid.toString().toUpperCase().substring(4, 8)}'),
      );
    }
  }
}
