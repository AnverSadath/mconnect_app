class OnsiteRequest {
  String? companyname;
  String? contactperson;
  String? contactnumber;
  String? problemsummary;

  OnsiteRequest({
    required this.companyname,
    required this.contactperson,
    required this.contactnumber,
    required this.problemsummary,
  });

  Map<String, dynamic> toJson(int userId) {
    return {
      "request": [
        {"Key": "type", "Value": "mConnectApp_OnsiteRequest"},
        {"Key": "CompanyName", "Value": companyname},
        {"Key": "ContactPerson", "Value": contactperson},
        {"Key": "ContactNumber", "Value": contactnumber},
        {"Key": "ProductType", "Value": "Tally ERP"},
        {"Key": "Place", "Value": ""},
        {"Key": "Problem", "Value": problemsummary},
        {"Key": "UserID", "Value": userId.toString()}
      ]
    };
  }
}
