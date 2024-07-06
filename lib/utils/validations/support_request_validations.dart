class SupportRequestValidations {
  static String? validateCompanyName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Organization';
    }
    return null;
  }

  static String? validateContactPerson(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the Contact Person';
    }
    return null;
  }

  static String? validateContactNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your ContactNumber';
    }
    return null;
  }

  static String? validateSupportFor(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the Support For';
    }
    return null;
  }

  static String? validateSummary(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the Summary of problem';
    }
    return null;
  }
}
