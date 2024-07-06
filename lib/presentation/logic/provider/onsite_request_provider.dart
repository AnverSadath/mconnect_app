import 'package:flutter/foundation.dart';
import 'package:mconnect_app/data/models/onsite_request_model.dart';
import 'package:mconnect_app/domain/repositories/onsite_request_repo.dart';

class OnsiteRequestProvider extends ChangeNotifier {
  final OnsiteRequestRepo onsiteRequestRepo;

  OnsiteRequestProvider({required this.onsiteRequestRepo});

  Future<OnsiteRequestDtos?> onsiteRequest(String companyname,
      String contactperson, String contactnumber, String problemsummary) async {
    try {
      final response = await onsiteRequestRepo.onsite(
          companyname, contactperson, contactnumber, problemsummary);
      notifyListeners();
      return response;
    } catch (e) {
      print("Error Onsite Request$e");
      throw (e);
    }
  }
}
