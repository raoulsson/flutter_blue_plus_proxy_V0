import 'package:base_template_project/blocs/ble_bloc.dart';
import 'package:base_template_project/screens/ble/scan_result_tile.dart';
import 'package:base_template_project/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:log_4_dart_2/log_4_dart_2.dart';
import 'package:provider/provider.dart';

import '../../ble/flutter_blue_plus_proxy.dart';
import '../../ble/models/proxies/bluetooth_device_proxy.dart';
import '../../ble/models/proxies/scan_result_proxy.dart';
import '../../blocs/application_bloc.dart';
import '../../blocs/bloc_provider.dart';
import '../../configuration.dart';
import 'bottom_nav_bar.dart';
import 'device_screen.dart';

class BLETechControlScreen extends StatelessWidget with Log4Dart {
  static const String id = 'gemma_control_screen';
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  BLETechControlScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = context.watch<KLocalizations>();

    return BlocProvider<ApplicationBloc>(
      bloc: ApplicationBloc(),
      child: BlocProvider<BleBloc>(
        bloc: BleBloc(),
        child: MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget with Log4Dart {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with Log4Dart {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  FlutterBluePlusProxy blue = FlutterBluePlusProxy.instance;

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

  String update = 'n/a';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _buildScreen(context),
      routes: {
        DeviceScreen.id: (BuildContext context) => DeviceScreen(),
      },
    );
  }

  Widget _buildScreen(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 7.0),
          child: Text(
            kAppTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontFamily: 'Pacifico',
                  fontSize: 26,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SettingsScreen.id);
              },
              icon: const Icon(
                Icons.settings,
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => blue.startScan(timeout: const Duration(seconds: 4)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text('Connected Devices'),
                ),
                const SizedBox(
                  height: 14.0,
                  width: 350,
                ),
                _getBluetoothDeviceProxyStreamBuilder(),
                const SizedBox(
                  height: 30.0,
                  width: 350,
                  child: Divider(
                      //color: Color.fromARGB(255, 115, 245, 243),
                      ),
                ),
                const Text('Available Devices'),
                const SizedBox(
                  height: 14.0,
                  width: 350,
                ),
                _getScanResultProxyStreamBuilder(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: blue.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data!) {
            return FloatingActionButton(
              onPressed: () => blue.stopScan(),
              backgroundColor: Colors.red,
              child: const Icon(Icons.stop),
            );
          } else {
            return FloatingActionButton(
              child: const Icon(Icons.search),
              onPressed: () async {
                blue.startScan(
                  timeout: const Duration(seconds: 4),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(_scaffoldKey),
    );
  }

  // StreamBuilder<List<BluetoothDevice>>(
  // stream: Stream.periodic(Duration(seconds: 2))
  //     .asyncMap((_) => FlutterBlue.instance.connectedDevices),
  // initialData: [],
  // builder: (c, snapshot)
  Widget _getBluetoothDeviceProxyStreamBuilder() {
    return StreamBuilder<List<BluetoothDeviceProxy>>(
      stream: Stream.periodic(const Duration(seconds: 2)).asyncMap((_) {
        return blue.connectedDevices;
      }),
      initialData: const [],
      builder: (c, snapshot) => Column(
        children: snapshot.data!
            .map((d) => ListTile(
                  title: Text(d.toNameOrUUID),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(d.id.toString()),
                      _streamDevState(d),
                    ],
                  ),
                  trailing: StreamBuilder<BluetoothDeviceState>(
                    stream: d.state,
                    initialData: BluetoothDeviceState.disconnected,
                    builder: (c, snapshot) {
                      if (snapshot.data == BluetoothDeviceState.connected) {
                        return ElevatedButton(
                          child: const Text('OPEN'),
                          onPressed: () {
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeviceScreen(device: d)));
                            Navigator.pushNamed(
                              context,
                              DeviceScreen.id,
                              arguments: DeviceScreenArgs(
                                d,
                              ),
                            );
                          },
                        );
                      }
                      return Text(snapshot.data.toString());
                    },
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _getScanResultProxyStreamBuilder() {
    return StreamBuilder<List<ScanResultProxy>>(
      stream: blue.scanResults,
      initialData: const [],
      builder: (BuildContext context, AsyncSnapshot<List<ScanResultProxy>> snapshot) {
        //logDebug('Stream state: ' + snapshot.connectionState.name);
        return Column(
          children: snapshot.data!.map(
            (srp) {
              return ScanResultTile(
                result: srp,
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(builder: (context) {
                  //     srp.device.connect(); // this is wrong here
                  //     return DeviceScreen(device: srp.device);
                  //   }),
                  // );
                  srp.device.connect();
                  Navigator.pushNamed(
                    context,
                    DeviceScreen.id,
                    arguments: DeviceScreenArgs(
                      srp.device,
                    ),
                  );
                },
              );
              //return Text(srp.device.id.toString());
            },
          ).toList(),
        );
      },
    );
  }

  StreamBuilder<BluetoothDeviceState> _streamDevState(BluetoothDeviceProxy device) {
    return StreamBuilder<BluetoothDeviceState>(
      stream: device.state,
      initialData: BluetoothDeviceState.connecting,
      builder: (c, snapshot) {
        return Text('BLE State: ${snapshot.data?.name}');
      },
    );
  }
}
