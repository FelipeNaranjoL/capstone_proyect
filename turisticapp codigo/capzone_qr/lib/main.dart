import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

// ignore: use_key_in_widget_constructors
class MyApp extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String qrvalue = "Código QR";

  Future<void> checkCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  Future<void> checkStoragePermissions() async {
    var writeStatus = await Permission.storage.status;
    if (!writeStatus.isGranted) {
      await Permission.storage.request();
    }

    var readStatus = await Permission.accessMediaLocation.status;
    if (!readStatus.isGranted) {
      await Permission.accessMediaLocation.request();
    }
  }

  void scanQr() async {
    // Verifica y solicita los permisos necesarios antes de usar la cámara
    await checkCameraPermission();
    await checkStoragePermissions();

    // Escanea el código QR
    String cameraScanResult =
        await scanner.scan() ?? 'No se pudo escanear el código';
    setState(() {
      qrvalue = cameraScanResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR SCAN',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[200],
          title: const Text('QR SCAN'),
        ),
        body: Center(
          child: Container(
            child: Text(
              qrvalue,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurpleAccent,
          onPressed: () => scanQr(),
          child: Icon(
            Icons.camera,
          ),
        ),
      ),
    );
  }
}
