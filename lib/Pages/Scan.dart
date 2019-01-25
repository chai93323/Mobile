import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';

List<CameraDescription> cameras;

class Scan extends StatefulWidget {
  //cameras = await availableCameras();
  @override
  State<StatefulWidget> createState() {
    return _Scan();
  }
}

class _Scan extends State<Scan> {
  QRReaderController controller;

  Future<Null> getCameras() async {
    cameras = await availableCameras();
    controller = new QRReaderController(
        cameras[0], ResolutionPreset.medium, [CodeFormat.qr,CodeFormat.code128], (dynamic value) {
      print(value);
      _showDialog(value);
      new Future.delayed(const Duration(seconds: 3), controller.startScanning);
    });
    await controller.initialize();
    controller.startScanning();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<Null>(
        future: getCameras(),
        builder: (context, snapshots) {
          switch (snapshots.connectionState) {
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.red)));
            case ConnectionState.done:
              return new AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: new QRReaderPreview(controller));
            default:
          }
        });
  }

  void _showDialog(String input) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("QR Code / BarCode"),
          content: new Text(input),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
