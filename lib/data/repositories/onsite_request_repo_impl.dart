import 'package:mconnect_app/data/datasources/onsite_request_datasources.dart';
import 'package:mconnect_app/data/models/onsite_request_model.dart';
import 'package:mconnect_app/domain/repositories/onsite_request_repo.dart';
import 'package:mconnect_app/domain/request/onsite_request.dart';

class OnsiteRequestRepoImpl extends OnsiteRequestRepo {
  OnsiteRequestDatasources onsiteRequestDatasources;
  OnsiteRequestRepoImpl({required this.onsiteRequestDatasources});

  Future<OnsiteRequestDtos?> onsite(String companyname, String contactperson,
      String contactnumber, String problemsummary) async {
    try {
      return onsiteRequestDatasources.onsite(OnsiteRequest(
          companyname: companyname,
          contactperson: contactperson,
          contactnumber: contactnumber,
          problemsummary: problemsummary));
    } catch (e) {
      print("error onsite request :$e");
      throw (e);
    }
  }
}
