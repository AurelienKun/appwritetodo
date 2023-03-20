extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension NameValidator on String {
  bool isValidName() {
    return RegExp(r'^[a-zA-Z]{3,}$').hasMatch(this);
  }
}

extension PasswordValidator on String {
  bool isGoodPassword() {
    // A least one upper case, one special, one lower case, one digit, and more than 8 caracters
    return RegExp(r'(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8,}$')
        .hasMatch(this);
  }
}
