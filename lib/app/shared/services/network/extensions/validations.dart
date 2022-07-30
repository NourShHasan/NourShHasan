/// Email Validations
extension EmailValidator on String {
  // validate if there is [@] char and [.] char in email.
  bool get isValidEmail => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);

  // validate if there are capital letters in string.
  bool get isSmallLetters => RegExp(r"^[^A-Z\s]+\.[^A-Z\s]+$").hasMatch(this);
}

/// Phone Validations
extension PhoneValidation on String {
  bool get isValidPhone {
    if (this.isNotEmpty && (this.length >= 9 && this.length <= 11)) {
      return true;
    }
    return false;
  }
}

extension PasswordValidation on String {
  bool get isValidPassword {
    if (this.isNotEmpty && this.length >= 6) {
      return true;
    }
    return false;
  }
}

extension UserNameValidation on String {
  bool get validateSpecialChar {
    if (this.isEmpty ||
        this[0] == '.' ||
        this[0] == '_' ||
        this[this.length - 1] == '.' ||
        this[this.length - 1] == '_') {
      return true;
    }
    return false;
  }

  bool get hasSpecialChar => RegExp(r'^[a_.-zA-Z0-9]+$').hasMatch(this);

  bool get isValidWord =>
      this.length >= 3 && !RegExp("[a-zA-Z]").hasMatch(this);

  bool get usernameMustBeAtLeastCharacters {
    if (this.length < 3) {
      return true;
    }
    return false;
  }
}
