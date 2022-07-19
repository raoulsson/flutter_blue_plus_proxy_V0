import 'dart:convert';

import 'package:base_template_project/ble/models/proxies/bluetooth_characteristic_proxy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:log_4_dart_2/log_4_dart_2.dart';

import 'descriptor_tile.dart';

class CharacteristicTile extends StatefulWidget with Log4Dart {
  final BluetoothCharacteristicProxy characteristic;
  final List<DescriptorTile> descriptorTiles;
  final VoidCallback? onReadPressed;
  final VoidCallback? onNotificationPressed;

  CharacteristicTile({Key? key, required this.characteristic, required this.descriptorTiles, this.onReadPressed, this.onNotificationPressed}) : super(key: key);

  @override
  State<CharacteristicTile> createState() => _CharacteristicTileState();
}

class _CharacteristicTileState extends State<CharacteristicTile> {
  final _sendThisController = TextEditingController(text: '0');
  final _focusNode = FocusNode();

  String _sendThis = '0';

  double _sliderValue = 0;

  get changeColors => null;

  @override
  initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _sendThisController.selection = TextSelection(baseOffset: 0, extentOffset: _sendThisController.text.length);
      }
    });
  }

  @override
  void dispose() {
    _sendThisController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: StreamBuilder<List<int>>(
        stream: widget.characteristic.value,
        initialData: widget.characteristic.lastValue,
        builder: (c, snapshot) {
          final value = snapshot.data;
          return ExpansionTile(
            title: ListTile(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Characteristic'),
                  Text(
                    '0x${widget.characteristic.uuid.toString().toUpperCase().substring(4, 8)}',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Theme.of(context).textTheme.caption?.color),
                  ),
                  SizedBox(
                    height: 60.0,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextField(
                        controller: _sendThisController,
                        focusNode: _focusNode,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.start,
                        onChanged: (value) {
                          setState(() {
                            _sendThis = value;
                          });
                        },
                        decoration: kEmailInputDecoration.copyWith(hintText: 'string or [int, int, int, int]...'),
                      ),
                    ),
                  ),
                  SizedBox(
                    // height: 60.0,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Slider(
                        value: _sliderValue,
                        label: _sliderValue.toString(),
                        onChanged: (value) {
                          setState(() {
                            _sliderValue = value;
                            _sendThis = value.toInt().toString();
                            _sendThisController.text = _sendThis;
                            // _sendThisController.selection = TextSelection.fromPosition(TextPosition(offset: _sendThisController.text.length));
                            _sendThisController.selection = TextSelection(baseOffset: 0, extentOffset: _sendThisController.text.length);
                            writeNow();
                          });
                        },
                        min: 0.0,
                        // max: 4096.0,
                        max: 2595.0,
                        // max: 255.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60.0,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: _colorPicker(),
                    ),
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  color: Colors.grey.shade400,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 4.0),
                          child: Text('Reply:', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Text('Bytes $value'),
                        Text('int ${bytesToInt(value)}'),
                      ],
                    ),
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.all(0.0),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.file_download,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
                  ),
                  onPressed: widget.onReadPressed,
                ),
                IconButton(
                  icon: Icon(
                    Icons.file_upload,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
                  ),
                  onPressed: writeNow,
                ),
                IconButton(
                  icon: _getIcon(widget.characteristic),
                  onPressed: widget.onNotificationPressed,
                ),
                // Expanded(
                //   child: TextField(
                //     onChanged: (value) {
                //       //email = value;
                //     },
                //     //decoration: kEmailInputDecoration.copyWith(hintText: 'Enter Email...'),
                //   ),
                // ),
              ],
            ),
            children: widget.descriptorTiles,
          );
        },
      ),
    );
  }

  // void xxx() {
  //   debounce(() {
  //     print('asdf');
  //   }, const Duration(milliseconds: 4000))();
  // }

  bool writingInProgress = false;
  void writeNow() async {
    if (writingInProgress) {
      return;
    }
    writingInProgress = true;
    if (_sendThis.isEmpty) {
      writingInProgress = false;
      return;
    }

    final List<int> intList = [];
    _sendThis = _sendThis.trim();
    // print('value: $_sendThis');
    if (_sendThis.contains(',')) {
      _sendThis = _sendThis.replaceAll('[', '');
      _sendThis = _sendThis.replaceAll(']', '');
      bool success = true;
      try {
        for (var partial in _sendThis.split(',')) {
          intList.add(int.parse(partial.trim()));
        }
      } on Error {
        success = false;
      }
      if (success) {
        // print('>>>: Sending input value: ' + intList.toString());
        await widget.characteristic.write(intList, withoutResponse: false);
      }
    } else {
      // print('>>>: Sending input value: ' + _sendThis);
      await widget.characteristic.writeUTF8(_sendThis, withoutResponse: false);
    }
    await widget.characteristic.read();
    writingInProgress = false;
  }

  Widget _colorPicker() {
    return ElevatedButton(
      child: const Text('Select Color'),
      onPressed: () {
        _showColorPickerModal();
      },
    );

    // return ColorPicker(
    //   pickerColor: Colors.red, //default color
    //   onColorChanged: (Color color) {
    //     //on color picked
    //     print(color);
    //   },
    // );
    //pickerColor: color, onColorChanged: changeColor, colorPickerWidth: 300, pickerAreaHeightPercent: 0.7, enableAlpha: true, labelTypes: [ColorLabelType.hsl, ColorLabelType.hsv, ColorLabelTypesgb], displayThumbColor: true, paletteType: PaletteType.hsl, pickerAreaBorderRadius: const BorderRadius.only( topLeft: Radius.circular(2), topRight: Radius.circular(2), ), hexlnputBar: true, colorHistory: colorHistory, onHistoryChanged: changeColorHistory,
  }

  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
      var hslColor = HSLColor.fromColor(color);
      var hsl = <int>[];
      hsl.add((hslColor.alpha * 100.0).roundToDouble().toInt());
      hsl.add((hslColor.hue * 1.0).roundToDouble().toInt());
      hsl.add((hslColor.saturation * 100.0).roundToDouble().toInt());
      hsl.add((hslColor.lightness * 100.0).roundToDouble().toInt());
      print(hsl.toString());
      // [233, 77, 32, 100]
      // _sendThis = hsl.toString();
      _sendThis = (hslColor.hue * 7.208333).roundToDouble().toInt().toString();
      _sendThisController.text = _sendThis;
      //Uint8List.
      //print(hex.decode(pickerColor.toString()));
      //writeNow();
    });
  }

  void _showColorPickerModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
            ),
            // Use Material color picker:
            //
            // child: MaterialPicker(
            //   pickerColor: pickerColor,
            //   onColorChanged: changeColor,
            //   enableLabel: true, // only on portrait mode
            // ),
            //
            // Use Block color picker:
            //
            // child: BlockPicker(
            //   pickerColor: currentColor,
            //   onColorChanged: changeColor,
            // ),
            //
            // child: MultipleChoiceBlockPicker(
            //   pickerColors: [pickerColor, Colors.pink],
            //   onColorsChanged: changeColors,
            // ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {
                setState(() => currentColor = pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String bytesToInt(List<int>? value) {
    if (value != null && value.isNotEmpty) {
      // print('>>> ' + value.toString());
      var decode = utf8.decode(value);
      //_sendThisController.text = decode;
      return decode;
    }
    return 'n/a';
  }

  Widget _getIcon(BluetoothCharacteristicProxy chara) {
    return StreamBuilder<bool>(
      stream: chara.isNotifyingStream,
      initialData: false,
      builder: (context, snapshot) {
        final value = snapshot.data;
        if (value != null && value == true) {
          return const Icon(
            Icons.fiber_manual_record_rounded,
            color: Colors.green,
          );
        } else {
          return Icon(
            Icons.fiber_manual_record_outlined,
            color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
          );
        }
      },
    );
  }
  //
  // Future<dynamic> f(var value) async {
  //   print('write');
  //   writeNow();
  //   return Future(() => null);
  // }
}

const kEmailInputDecoration = InputDecoration(
  hintText: '<the hint text goes here>',
  //contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ),
);
