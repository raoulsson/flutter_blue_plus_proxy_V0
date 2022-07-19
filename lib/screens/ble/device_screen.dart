import 'dart:math';

import 'package:base_template_project/ble/flutter_blue_plus_proxy.dart';
import 'package:base_template_project/screens/ble/service_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../ble/models/proxies/bluetooth_device_proxy.dart';
import '../../ble/models/proxies/bluetooth_service_proxy.dart';
import 'bottom_nav_bar.dart';
import 'characteristics_tile.dart';
import 'descriptor_tile.dart';

class DeviceScreenArgs {
  final BluetoothDeviceProxy device;

  DeviceScreenArgs(this.device);
}

class DeviceScreen extends StatefulWidget {
  static const String id = 'device_screen';
  late BluetoothDeviceProxy device;

  DeviceScreen({Key? key}) : super(key: key);

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<int> _getRandomBytes() {
    final math = Random();
    return [math.nextInt(255), math.nextInt(255), math.nextInt(255), math.nextInt(255)];
  }

  bool showProgressHUD = true;
  bool listening = false;

  BluetoothDeviceState connectionState = BluetoothDeviceState.disconnected;

  @override
  void initState() {
    super.initState();
    _listenToSnackBarMessages();
  }

  void _listenToSnackBarMessages() {
    FlutterBluePlusProxy.instance.snackbarMessages.listen((msg) {
      _scaffoldKey.currentState?.hideCurrentSnackBar();
      final snackBar = SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(msg),
        // action: SnackBarAction(
        //   label: 'dismiss',
        //   onPressed: () {},
        // ),
      );
      _scaffoldKey.currentState?.showSnackBar(snackBar);
    });
  }

  void _startListening() {
    if (listening == false) {
      widget.device.state.listen((state) {
        if (mounted) {
          setState(() {
            connectionState = state;
            if (state == BluetoothDeviceState.connected) {
              showProgressHUD = false;
            } else {
              showProgressHUD = true;
            }
          });
        }
      });
      listening = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DeviceScreenArgs;
    widget.device = args.device;
    _startListening();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.device.toNameOrUUID),
          actions: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
              stream: widget.device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) {
                VoidCallback? onPressed;
                String text;
                switch (snapshot.data) {
                  case BluetoothDeviceState.connected:
                    onPressed = () {
                      widget.device.disconnect();
                    };
                    text = 'DISCONNECT';
                    break;
                  case BluetoothDeviceState.disconnected:
                    onPressed = () {
                      widget.device.connect();
                    };
                    text = 'CONNECT';
                    break;
                  default:
                    onPressed = null;
                    text = (snapshot.data != null ? '${snapshot.data!.name.toString().toUpperCase()}...' : 'n/a');
                    break;
                }
                return TextButton(
                    onPressed: onPressed,
                    child: Text(
                      text,
                      style: Theme.of(context).primaryTextTheme.button?.copyWith(color: Colors.white),
                    ));
              },
            )
          ],
        ),
        body: ModalProgressHUD(
          inAsyncCall: showProgressHUD,
          progressIndicator: _progressIndicatorWidgets(),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                StreamBuilder<BluetoothDeviceState>(
                  stream: widget.device.state,
                  initialData: BluetoothDeviceState.connecting,
                  builder: (c, snapshot) => ListTile(
                    leading: _setBLEIcon(snapshot.data),
                    title: Text('Device is ${snapshot.data?.toString().split('.')[1]}.'),
                    subtitle: Text('${widget.device.id}'),
                    trailing: StreamBuilder<bool>(
                      stream: widget.device.isDiscoveringServices,
                      initialData: false,
                      builder: (c, snapshot) => IndexedStack(
                        index: snapshot.data! ? 1 : 0,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.router),
                            onPressed: () {
                              widget.device.discoverServices();
                            },
                          ),
                          const IconButton(
                            icon: SizedBox(
                              width: 18.0,
                              height: 18.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.grey),
                              ),
                            ),
                            onPressed: null,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                StreamBuilder<int>(
                  stream: widget.device.mtu,
                  initialData: 0,
                  builder: (c, snapshot) => ListTile(
                    title: const Text('MTU Size'),
                    subtitle: Text('${snapshot.data} bytes'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        widget.device.requestMtu(223);
                      },
                    ),
                  ),
                ),
                StreamBuilder<List<BluetoothServiceProxy>>(
                  stream: widget.device.services,
                  initialData: const [],
                  builder: (c, snapshot) {
                    return Column(
                      children: _buildServiceTiles(snapshot.data!),
                    );
                  },
                ),
                const SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBar(_scaffoldKey),
      ),
    );
  }

  List<Widget> _buildServiceTiles(List<BluetoothServiceProxy> services) {
    return services
        .map(
          (s) => ServiceTile(
            service: s,
            characteristicTiles: s.characteristics
                .map(
                  (c) => CharacteristicTile(
                    characteristic: c,
                    onReadPressed: () {
                      // print('>>>: Reading bytes form characteristics: ' + c.uuid.toString());
                      c.read();
                    },
                    // onWritePressed: () async {
                    //   print('>>>: Writing bytes to characteristics: ' + c.uuid.toString());
                    //   await c.writeUTF8(valueToSend, withoutResponse: false);
                    //   await c.read();
                    // },
                    onNotificationPressed: () async {
                      print('>>>: Notifying characteristics: ${c.uuid}');
                      await c.setNotifyValue(!c.isNotifying);
                      //await c.read();
                    },
                    descriptorTiles: c.descriptors
                        .map(
                          (d) => DescriptorTile(
                            descriptor: d,
                            onReadPressed: () => d.read(),
                            onWritePressed: () => d.write(_getRandomBytes()),
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }

  _progressIndicatorWidgets() {
    if (connectionState == BluetoothDeviceState.connecting || connectionState == BluetoothDeviceState.disconnecting) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: Colors.pink,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const Text(
                  'Device State is:',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                const SizedBox(height: 12.0),
                Text(
                  connectionState.name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink),
                ),
              ],
            ),
          ),
        ],
      );
    } else if (connectionState == BluetoothDeviceState.disconnected) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //const CircularProgressIndicator(),
          const Text(
            'Device State is:',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          const SizedBox(height: 12.0),
          Text(
            connectionState.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink),
          ),
        ],
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        //const CircularProgressIndicator(),
        Text('Should be connected and thus this text not visible...'),
      ],
    );
  }

  Widget _setBLEIcon(BluetoothDeviceState? data) {
    if (data == null || data == BluetoothDeviceState.disconnected) {
      return const Icon(Icons.bluetooth_disabled);
    }
    if (data == BluetoothDeviceState.connecting) {
      return const Icon(Icons.bluetooth_disabled, color: Colors.orange);
    }
    if (data == BluetoothDeviceState.disconnecting) {
      return const Icon(Icons.bluetooth_connected, color: Colors.orange);
    }
    if (data == BluetoothDeviceState.connected) {
      return const Icon(Icons.bluetooth_connected, color: Colors.blue);
    }
    return const Icon(Icons.bluetooth_disabled);
  }
}
