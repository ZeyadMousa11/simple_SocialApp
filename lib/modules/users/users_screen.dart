import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeCode extends StatefulWidget {
  const NativeCode({Key? key}) : super(key: key);

  @override
  State<NativeCode> createState() => _NativeCodeState();
}

class _NativeCodeState extends State<NativeCode> {

  static const platform = MethodChannel('samples.flutter.dev/battery');
  String batteryLevel = 'Unknown battery level.';

  void getBatteryLevel()  {
    platform
        .invokeMethod('getBatteryLevel')
        .then((value) {
      setState(() {
        batteryLevel = 'Battery level at $value % .';
      });
    })
        .catchError((error){
      setState(() {
        batteryLevel = "Failed to get battery level: '${error.message}'.";
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Get Battery Level'),
              onPressed: getBatteryLevel,
            ),
            Text(batteryLevel),
          ],
        ),
      ),
    );
  }
}

