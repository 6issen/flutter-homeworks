class AppValid {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'This form is empty';
    }
    if (!value.contains('@')) {
      return 'Email must contain an "@" symbol';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'This form is empty';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }
}
