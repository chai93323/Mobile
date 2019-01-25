import 'package:flutter/material.dart';

// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Center(
//       child: new Text("Home"),
//     );
//   }
// }

class Home extends StatefulWidget  {
  @override
  State<StatefulWidget> createState()
  {
    return _Home();
  }
}

class _Home extends State<Home>
{
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text("Home"),
    );
  }
}