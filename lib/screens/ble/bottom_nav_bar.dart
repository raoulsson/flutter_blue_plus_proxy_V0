import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../ble/flutter_blue_plus_proxy.dart';

class BottomNavBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const BottomNavBar(this.scaffoldKey, {Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  FlutterBluePlusProxy blue = FlutterBluePlusProxy.instance;
  final keepDuration = const Duration(milliseconds: 3000);

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.copy),
          label: 'Export Data',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'Info',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
    _selectedIndex = index;
    List<String> data = [];
    if (_selectedIndex == 0) {
      if (blue.onDevice) {
        data = blue.collectMockData(doPrint: true);
      } else {
        data.add(
            '''This copies the ble data structure of your real BLE environment to a format you can copy-paste into your testing code. It makes only sense when run on a real device. See FlutterBluePlusProxy.onDevice''');
      }
      Clipboard.setData(ClipboardData(text: data.join('\n'))).then((_) {
        widget.scaffoldKey.currentState
          ?..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: const Text('Copied MockDef code to clipboard'),
              duration: keepDuration,
            ),
          );
      });
    }
    if (_selectedIndex == 1) {
      widget.scaffoldKey.currentState
        ?..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: const Text('Nothing happens here yet...'),
            duration: keepDuration,
          ),
        );
    }
  }
}
