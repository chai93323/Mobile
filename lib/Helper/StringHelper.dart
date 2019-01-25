import 'dart:convert';

class StringHelper {
  String strBase64Encode(String input) {
    String result = "";
    var bytes = utf8.encode(input);
    result = base64.encode(bytes);
    return result;
  }

  String strBase64Decode(String input) {
    String result = "";
    result = utf8.decode(base64.decode(input));
    return result;
  }

  String xmlEncode(String xml) {
    String result = xml;
    result = result.replaceAll("&", "&#38;");
    result = result.replaceAll("<", "&#60;");
    result = result.replaceAll(">", "&#62;");
    result = result.replaceAll("'", "&#39;");
    result = result.replaceAll("\"", "&#34;");
    return result;
  }

  String xmlDecode(String xml) {
    String result = xml;
    result = result.replaceAll("&#38;", "&");
    result = result.replaceAll("&#60;", "<");
    result = result.replaceAll("&#62;", ">");
    result = result.replaceAll("&#39;", "'");
    result = result.replaceAll("&#34;", "\"");
    return result;
  }

  String between(String src, String preFix, String endFix) {
    String result = "";
    var list = betweenList(src, preFix, endFix);
    if (list.length > 0) {
      result = list[0];
    }
    return result;
  }

  List<String> betweenList(String src, String preFix, String endFix) {
    List<String> values = new List<String>();
    int beginPos = src.indexOf(preFix, 0);
    while (beginPos >= 0) {
      int start = beginPos + preFix.length;
      int stop = src.indexOf(endFix, start);
      if (stop < 0) break;
      values.add(src.substring(start, stop));
      beginPos = src.indexOf(preFix, stop + endFix.length);
    }
    return values;
  }
}
