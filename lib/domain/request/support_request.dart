class SupportRequest {
  String? companyname;
  String? contactperson;
  String? contactnumber;
  String? supportfor;
  String? problemsummary;

  SupportRequest({
    required this.companyname,
    required this.contactperson,
    required this.contactnumber,
    required this.supportfor,
    required this.problemsummary,
  });

  Map<String, dynamic> toJson(int userId) {
    return {
      "request": [
        {"Key": "type", "Value": "mConnectApp_SupportRequest"},
        {"Key": "CompanyName", "Value": companyname},
        {"Key": "ContactPerson", "Value": contactperson},
        {"Key": "ContactNumber", "Value": contactnumber},
        {"Key": "ProductType", "Value": "Tally.ERP9"},
        {"Key": "ProductCategory", "Value": "Tally Prime"},
        {"Key": "SupportFor", "Value": supportfor},
        {"Key": "ProblemSummary", "Value": problemsummary},
        {"Key": "UserID", "Value": userId.toString()}
      ]
    };
  }
}
