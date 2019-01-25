import 'package:ascentis_advancement/Classes/RequestHeader.dart';

class CardEnquiryRequest extends RequestHeader {
  String CardNo = "";
  CardEnquiryRequest(this.CardNo);
  Map<String, dynamic> toJson() => {
        'Command': "CARD ENQUIRY",
        'DB': DB,
        'EnquiryCode': EnquiryCode,
        'OutletCode': OutletCode,
        'PosID': PosID,
        'CashierID': CashierID,
        'CardNo': CardNo //CardNo != "" ? CardNo : null
      };
}

class CardEnquiryResponse {
  int ReturnStatus = 0;
  String CardNo = "";
  String MembershipPhotoLink = "";
  String MemberID = "";
  String Name = "";
  String NRIC = "";
  String MobileNo = "";
  String Email = "";
  CardEnquiryResponse();
  CardEnquiryResponse.fromJson(Map<String, dynamic> json) {
    ReturnStatus = json['ReturnStatus'];
    if (json.containsKey('CardInfo')) {
      CardNo = json['CardInfo']['CardNo'];
      MembershipPhotoLink = json['CardInfo']['MembershipPhotoLink'];
      MemberID = json['CardInfo']['MemberID'];
    }
    if (json.containsKey('MemberInfo')) {
      Name = json['MemberInfo']['Name'];
      NRIC = json['MemberInfo']['NRIC'];
      MobileNo = json['MemberInfo']['MobileNo'];
      Email = json['MemberInfo']['Email'];
    }
  }
}
