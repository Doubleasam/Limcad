import 'dart:convert';

class ValidationUtil {
  static String? validatePassword(String password) {
    String errMessage = "";
    if (password.isEmpty) {
      errMessage = "Password is required. ";
    }
    if (!RegExp(r"[A-Z]").hasMatch(password)) {
      return "upper case character(s) missing";
    }
    if (!RegExp(r"[a-z]").hasMatch(password)) {
      return "lower case character(s) missing";
    }
    if (!RegExp(r"[0-9]").hasMatch(password)) {
      return "alphanumeric character(s) missing";
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return "special character(s) missing";
    }
    if (password.length < 8 || password.length > 30) {
      return "incomplete password length";
    }
    if (password.contains(" ")) {
      return "remove empty spaces";
    }
    return errMessage.isEmpty ? null : errMessage;
  }

  static String? validateConfirmPassword(
      String confirmPassword, String password) {
    if (password != confirmPassword) {
      return "Password does not match password above";
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    final RegExp phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');

    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static bool isValidPassword(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[A-Za-z]')) &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  static String? validateInput(String? value, String name) {
    return (value == null || value.isEmpty) ? "$name is required" : null;
  }

  static String? isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    );

    if (emailRegex.hasMatch(email)) {
      return null;
    } else {
      return 'Invalid email address';
    }
  }

  static String? validateText(String text) {
    if (text.isEmpty) {
      return "Input cannot be empty";
    }
    return null;
  }
}
