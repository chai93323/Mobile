import 'package:ascentis_advancement/Config.dart';
import 'package:ascentis_advancement/Helper/StringHelper.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ServiceHelper {
  String requestXML(String json) {
    StringHelper sh = new StringHelper();
    String userName = Config.SERVICE_USERNAME;
    String password = Config.SERVICE_PASSWORD;
    userName = sh.strBase64Encode(userName);
    password = sh.strBase64Encode(password);
    json = sh.xmlEncode(json);
    var request = """<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <SOAPAuthHeader xmlns="http://MatrixAPIs/">
      <strUserName>[USERNAME]</strUserName>
      <strPassword>[PASSWORD]</strPassword>
    </SOAPAuthHeader>
  </soap:Header>
  <soap:Body>
    <JSONCommand xmlns="http://MatrixAPIs/">
      <requestJSON>[JSON]</requestJSON>
    </JSONCommand>
  </soap:Body>
</soap:Envelope>""";
    request = request.replaceAll("[USERNAME]", userName);
    request = request.replaceAll("[PASSWORD]", password);
    request = request.replaceAll("[JSON]", json);
    return request;
  }

  Future<String> fetchPost(String json) async {
    String result = "";
    var req = requestXML(json);
    StringHelper sh = new StringHelper();
    Map<String, String> hd = new Map<String, String>();
    hd["content-type"] = "text/xml; charset=utf-8";
    final response =
        await http.post(Config.SERVICE_URL, headers: hd, body: req);
    result = sh.between(
        response.body, "<JSONCommandResult>", "</JSONCommandResult>");
    result = sh.xmlDecode(result);
    return result;
  }

  // String authentication() {
  //   StringHelper sh = new StringHelper();
  //   String userName = Config.SERVICE_USERNAME;
  //   String password = Config.SERVICE_PASSWORD;
  //   Map<String, String> m = {
  //     "username": sh.strBase64Encode(userName),
  //     "password": sh.strBase64Encode(password),
  //     "cusCode": "QA4",
  //     "reqSource": ""
  //   };
  //   return json.encode(m);
  // }

  // Future<String> fetchPost(String json) async {
  //   String result = "";
  //   String auth = authentication();
  //   String url = Config.REST_SERVICE_URL + "/Authenticate";
  //   var tokenRequest = await http.post(url,
  //       headers: {"Content-Type": "application/json; charset=utf-8"},
  //       body: auth);
  //   String token = tokenRequest.body;
  //   url = Config.REST_SERVICE_URL + "/RequestJson";
  //   String cmdRequest = '{"token":' + token + ',"requestCmd":' + json + '}';
  //   var request = await http.post(url,
  //       headers: {"Content-Type": "application/json; charset=utf-8"},
  //       body: cmdRequest);
  //   result = request.body;
  //   return result;
  // }
}
