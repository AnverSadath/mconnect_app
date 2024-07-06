import 'package:flutter/material.dart';
import 'package:mconnect_app/data/models/support_request_model.dart';
import 'package:mconnect_app/data/models/view_support_list_model.dart';
import 'package:mconnect_app/domain/repositories/support_request_repo.dart';

class SupportRequestProvider extends ChangeNotifier {
  final SupportRequestRepo supportRequestRepo;
  SupportRequestProvider({required this.supportRequestRepo});

  Future<SupportRequestDtos?> support(
    String companyname,
    String contactperson,
    String contactnumber,
    String supportfor,
    String problemsummary,
  ) async {
    try {
      final response = await supportRequestRepo.support(companyname,
          contactperson, contactnumber, supportfor, problemsummary);
      notifyListeners();
      return response;
    } catch (e) {
      print("Error Support Request$e");
      throw (e);
    }
  }

  Future<ViewSupportListDtos?> viewSupport() async {
    try {
      final response = await supportRequestRepo.viewSupport();
      notifyListeners();
      return response;
    } catch (e) {
      print("Error Support Request$e");
      throw (e);
    }
  }
}
