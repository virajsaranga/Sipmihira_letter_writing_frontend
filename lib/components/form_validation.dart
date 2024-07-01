class FormValidation {
  String validateName(String value) {
    if (value.isEmpty) {
      return 'Name is required';
    }

    return "";
  }

  String validateEmail(String value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    if (value.isEmpty) {
      return 'Email is required';
    }

    if (!regex.hasMatch(value)) {
      return 'Email is not valid';
    }

    return "";
  }

  String validatePassword(String value) {
    final RegExp uppercaseRegex = RegExp(r'^(?=.*[A-Z])');
    final RegExp lowercaseRegex = RegExp(r'^(?=.*[a-z])');
    final RegExp digitRegex = RegExp(r'^(?=.*?[0-9])');
    final RegExp specialCharRegex = RegExp(r'^(?=.*?[!@#\$&*~])');
    final RegExp lengthRegex = RegExp(r'^.{8,}$');

    if (value.isEmpty || value == " ") {
      return 'Password is required';
    }

    if (!uppercaseRegex.hasMatch(value)) {
      return 'Password must has uppercase ';
    }

    if (!lowercaseRegex.hasMatch(value)) {
      return 'Password must has lowercase';
    }

    if (!digitRegex.hasMatch(value)) {
      return 'Password must has digits';
    }

    if (!specialCharRegex.hasMatch(value)) {
      return 'Password must has special characters';
    }

    if (!lengthRegex.hasMatch(value)) {
      return 'Password must has 8 characters';
    }

    return "";
  }
}
