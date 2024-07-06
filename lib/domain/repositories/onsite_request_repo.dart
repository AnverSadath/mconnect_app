import 'package:mconnect_app/data/models/onsite_request_model.dart';

abstract class OnsiteRequestRepo {
  Future<OnsiteRequestDtos?> onsite(String companyname, String contactperson,
      String contactnumber, String problemsummary);
}
