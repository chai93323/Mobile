import 'package:flutter/material.dart';
import 'dart:async';

class Loading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Loading();
  }
}

class _Loading extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<String>(
        future: getMessage(),
        builder: (context, snapshots) {
          switch (snapshots.connectionState) {
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.red)));
            case ConnectionState.done:
              return new Text(snapshots.data);
            default:
          }
        });
  }

  var timeout = Duration(seconds: 2);

  Future<String> getMessage() async {
    return new Future.delayed(timeout, () => 'Welcome to your async screen');
  }
}
