import 'package:flutter/material.dart';
import 'package:ascentis_advancement/Helper/ServiceHelper.dart';
import 'package:ascentis_advancement/Classes/CardEnquiry.dart';
import 'dart:convert';

class WebService extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WebService();
  }
}

class _WebService extends State<WebService> {
  static String cardNo = "TheLeague01";

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //      if (_loading) {
  //       Future<String> post = sh.fetchPost(json);
  //       post.then((result) {
  //         resp = jsonDecode(result);
  //         cardNo =resp.CardNo;
  //         name = resp.Name;
  //         _loading = false;
  //       });
  //      }
  //   });
  // }

  Future<CardEnquiryResponse> loadCardInfo() async {
    CardEnquiryRequest req = new CardEnquiryRequest(cardNo);
    ServiceHelper sh = new ServiceHelper();
    CardEnquiryResponse resp = new CardEnquiryResponse();
    try {
      String json = jsonEncode(req);
      String result = await sh.fetchPost(json);
      if (result != "") {
        var  map = jsonDecode(result);
        resp = new CardEnquiryResponse.fromJson(map);
      }
    } catch (e) {
      print(e.toString());
    }
    return resp;
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<CardEnquiryResponse>(
        future: loadCardInfo(),
        builder: (context, snapshots) {
          switch (snapshots.connectionState) {
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.red)));
            case ConnectionState.done:
              return new Scaffold(
                  resizeToAvoidBottomPadding: false,
                  body: new SingleChildScrollView(
                    child: new Column(
                      children: <Widget>[
                         new ListTile(
                          leading: Icon(Icons.high_quality),
                          title: Text('CustomerCode'),
                          subtitle: Text('QA4'),
                        ),
                        new ListTile(
                          leading: Icon(Icons.label),
                          title: Text('Card No'),
                          subtitle: Text(cardNo),
                        ),
                        new ListTile(
                          leading: const Icon(Icons.person),
                           title: Text('Name'),
                          subtitle: Text(snapshots.data.Name),
                        ),
                        new ListTile(
                          leading: const Icon(Icons.phone),
                          title: Text('MobileNo'),
                          subtitle: Text(snapshots.data.MobileNo),
                        ),
                        new ListTile(
                          leading: const Icon(Icons.email),
                         title: Text('Email'),
                          subtitle: Text(snapshots.data.Email),
                        ),
                        new ListTile(
                          leading: Icon(Icons.today),
                          title: Text('Birthday'),
                          subtitle: Text(""),
                        ),
                        new ListTile(
                          leading: Icon(Icons.info),
                          title: Text('Point Balance'),
                          subtitle: Text(""),
                        ),
                        const Divider(
                          height: 1.0,
                        ),
                      ],
                    ),
                  ));
            default:
          }
        });
  }
}
