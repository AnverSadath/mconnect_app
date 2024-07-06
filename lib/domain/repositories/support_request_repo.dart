import 'package:mconnect_app/data/models/support_request_model.dart';
import 'package:mconnect_app/data/models/view_support_list_model.dart';

abstract class SupportRequestRepo {
  Future<SupportRequestDtos?> support(String companyname, String contactperson,
      String contactnumber, String supportfor, String problemsummary);

  Future<ViewSupportListDtos?> viewSupport();
}
