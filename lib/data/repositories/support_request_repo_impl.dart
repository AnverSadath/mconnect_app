import 'package:mconnect_app/data/datasources/support_request_datasources.dart';
import 'package:mconnect_app/data/models/support_request_model.dart';
import 'package:mconnect_app/data/models/view_support_list_model.dart';
import 'package:mconnect_app/domain/repositories/support_request_repo.dart';
import 'package:mconnect_app/domain/request/support_request.dart';

class SupportRequestRepoImpl implements SupportRequestRepo {
  SupportRequestDatasources supportRequestDatasources;

  SupportRequestRepoImpl({required this.supportRequestDatasources});

  @override
  Future<SupportRequestDtos?> support(String companyname, String contactperson,
      String contactnumber, String supportfor, String problemsummary) async {
    try {
      return supportRequestDatasources.support(SupportRequest(
          companyname: companyname,
          contactperson: contactperson,
          contactnumber: contactnumber,
          problemsummary: problemsummary,
          supportfor: supportfor));
    } catch (e) {
      print("error support request :$e");
      throw (e);
    }
  }

  Future<ViewSupportListDtos?> viewSupport() async {
    try {
      return supportRequestDatasources.viewSupport();
    } catch (e) {
      print("error view support list :$e");
      throw (e);
    }
  }
}
