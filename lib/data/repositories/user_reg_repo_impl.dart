import 'package:mconnect_app/data/datasources/user_reg_datasources.dart';
import 'package:mconnect_app/data/models/user_activate_model.dart';
import 'package:mconnect_app/data/models/user_reg_model.dart';
import 'package:mconnect_app/domain/repositories/user_reg_repo.dart';
import 'package:mconnect_app/domain/request/user_reg_request.dart';

class UserRegistrationRepoImpl implements UserRegistrationRepo {
  UserRegistrationDatasource userRegistrationDataSource;

  UserRegistrationRepoImpl({required this.userRegistrationDataSource});
  @override
  Future<UserRegistrationDtos?> registeruser(String name, String email,
      String mobile, String designation, String password) async {
    try {
      return await userRegistrationDataSource.registerUser(
          (UserRegistrationRequest(
              name: name,
              mobile: mobile,
              email: email,
              designation: designation,
              password: password)));
    } catch (e) {
      print(" error registering user:$e");
      throw (e);
    }
  }

  Future<UserActivateDtos?> activateuser(String qrCode) async {
    try {
      return await userRegistrationDataSource.activateUser(qrCode);
    } catch (e) {
      print(" error ectivating user:$e");
      throw (e);
    }
  }
}
