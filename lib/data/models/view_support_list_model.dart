class ViewSupportListDtos {
  final int status;
  final int id;
  final String message;
  final List<SupportCall> supportCalls;

  ViewSupportListDtos({
    required this.status,
    required this.id,
    required this.message,
    required this.supportCalls,
  });

  factory ViewSupportListDtos.fromJson(Map<String, dynamic> json) {
    var supportCallsJson = json['DATA'][0] as List;
    List<SupportCall> supportCallsList = supportCallsJson
        .map((callJson) => SupportCall.fromJson(callJson))
        .toList();

    return ViewSupportListDtos(
      status: json['Status'],
      id: json['ID'],
      message: json['Message'],
      supportCalls: supportCallsList,
    );
  }
}

class SupportCall {
  final int slNo;
  final int id;
  final String company;
  final String contactPerson;
  final String serialNo;
  final String contactNo;
  final String problem;
  final String createdOn;
  final String createdTime;
  final String ticketNo;
  final int rating;
  final String? ratedOn;
  final String productType;
  final String productTypeCategory;
  final String supportFor;
  final String callStatus;

  SupportCall({
    required this.slNo,
    required this.id,
    required this.company,
    required this.contactPerson,
    required this.serialNo,
    required this.contactNo,
    required this.problem,
    required this.createdOn,
    required this.createdTime,
    required this.ticketNo,
    required this.rating,
    this.ratedOn,
    required this.productType,
    required this.productTypeCategory,
    required this.supportFor,
    required this.callStatus,
  });

  factory SupportCall.fromJson(Map<String, dynamic> json) {
    return SupportCall(
      slNo: json['SlNo'],
      id: json['ID'],
      company: json['Company'],
      contactPerson: json['ContactPerson'],
      serialNo: json['SerialNo'],
      contactNo: json['ContactNo'],
      problem: json['Problem'],
      createdOn: json['CreatedOn'],
      createdTime: json['CreatedTime'],
      ticketNo: json['TicketNo'],
      rating: json['Rating'],
      ratedOn: json['RatedOn'],
      productType: json['ProductType'],
      productTypeCategory: json['ProductTypeCategory'],
      supportFor: json['SupportFor'],
      callStatus: json['CallStatus'],
    );
  }
}
