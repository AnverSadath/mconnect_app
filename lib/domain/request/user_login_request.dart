class UserLoginRequest {
  String? name;
  String? password;

  UserLoginRequest({required this.name, required this.password});

  Map<String, dynamic> toJson() {
    return {
      "request": [
        {"Key": "type", "Value": "mConnectApp_UserLogin"},
        {"Key": "Username", "Value": name},
        {"Key": "Password", "Value": password}
      ]
    };
  }
}
