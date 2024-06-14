class UserRegistrationRequest {
  String? name;
  String? email;
  String? mobile;
  String? designation;
  String? password;

  UserRegistrationRequest({
    required this.name,
    required this.mobile,
    required this.email,
    required this.designation,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "request": [
        {"Key": "type", "Value": "mConnectApp_RegisterUser"},
        {"Key": "MID", "Value": "0"},
        {"Key": "Name", "Value": name},
        {"Key": "Mobile", "Value": mobile},
        {"Key": "Email", "Value": email},
        {"Key": "Designation", "Value": designation},
        {"Key": "Password", "Value": password},
      ]
    };
  }
}
