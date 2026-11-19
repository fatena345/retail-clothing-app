bool isValidPassword(String password) {
    final hasMinLength = password.length >= 8;
    final hasLowercase = RegExp(r'[a-z]').hasMatch(password);
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
    final hasNumber = RegExp(r'[0-9]').hasMatch(password);
    final hasSpecialChar = RegExp(r'[^A-Za-z0-9\s]').hasMatch(password);
    final hasNoWhitespace = !RegExp(r'\s').hasMatch(password);

    return hasMinLength &&
        hasLowercase &&
        hasUppercase &&
        hasNumber &&
        hasSpecialChar &&
        hasNoWhitespace;
  }