class LoginValidations {
  static String? validateEmailmobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your moblie/email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    return null;
  }
}
