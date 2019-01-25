import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:ascentis_advancement/Pages/Home.dart';
import 'package:ascentis_advancement/Pages/Loading.dart';
import 'package:ascentis_advancement/Pages/WebService.dart';
import 'package:ascentis_advancement/Pages/MapLocation.dart';
import 'package:ascentis_advancement/Pages/Scan.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  // var drawerItems = [
  //   new DrawerItem("Home", Icons.home),
  //   new DrawerItem("Device Settings", Icons.settings),
  //   new DrawerItem("Input Controls", Icons.format_align_left),
  //   new DrawerItem("Web Service", Icons.http),
  //   new DrawerItem("Map", Icons.add_location),
  //   new DrawerItem("Scan QR / BarCode", Icons.monochrome_photos),
  //   new DrawerItem("Camera", Icons.camera_alt),
  //   new DrawerItem("Authentication", Icons.account_box),
  //   new DrawerItem("HTML Render", Icons.web),
  //   new DrawerItem("Animation", Icons.tv),
  //   new DrawerItem("Face Recognite", Icons.face),
  //   new DrawerItem("Chart", Icons.insert_chart),
  //   new DrawerItem("Close", Icons.close),
  // ];
  final drawerItems = getDrawerItems();
  final String userName = "Ascentis";
  final String email = "noreply@ascentis.com.my";
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }

  static List<DrawerItem> getDrawerItems() {
    List<DrawerItem> list = new List<DrawerItem>();
    list.add(new DrawerItem("Home", Icons.home));
    list.add(new DrawerItem("Loading", Icons.refresh));
    list.add(new DrawerItem("Web Service", Icons.http));
    list.add(new DrawerItem("Web View", Icons.web));
    list.add(new DrawerItem("Map Location", Icons.add_location));
    list.add(new DrawerItem("Scan QR / BarCode", Icons.monochrome_photos));
    return list;
  }
}

class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    String title = widget.drawerItems[_selectedDrawerIndex].title;
    switch (title) {
      case "Home":
        return new Home();
      case "Loading":
        return new Loading();
      case "Web Service":
        return new WebService();
      case "Map Location":
        return new MapLocation();
         case "Scan QR":
        return new Scan();
      default:
        return new Home();
    }
  }

  _onSelectItem(int index) {
    int lastIdx = _selectedDrawerIndex;
    setState(() => _selectedDrawerIndex = index);
    String title = widget.drawerItems[_selectedDrawerIndex].title;
    if (title == "Web View") {
      _onWebView();
      _selectedDrawerIndex = lastIdx;
    } else
      Navigator.of(context).pop(); // close the drawer
  }

  _onWebView() {
    Navigator.of(context)
        .push(new MaterialPageRoute<void>(builder: (BuildContext context) {
      return new Scaffold(
          appBar: new AppBar(
            title: new Text('Web View'),
          ),
          body: new WebviewScaffold(
              url: "https://www.ishopchangi.com",
              userAgent:
                  "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36"));
    }));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return new Scaffold(
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: new Container(
        constraints: new BoxConstraints.expand(
          width: MediaQuery.of(context).size.width - 100,
        ),
        color: Colors.white,
        child: new ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            new Container(
                height: 130.0,
                padding: const EdgeInsets.all(0.0),
                child: DrawerHeader(
                    padding: const EdgeInsets.all(0.0),
                    child: new UserAccountsDrawerHeader(
                      currentAccountPicture: null,
                      accountName: new Text(
                        widget.userName,
                        style: TextStyle(color: Colors.white),
                      ),
                      accountEmail: new Text(
                        widget.email,
                        style: TextStyle(color: Colors.white),
                      ),
                      decoration: new BoxDecoration(
                        color: Colors.red,
                      ),
                    ),
                    decoration: new BoxDecoration(color: Colors.red))),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
