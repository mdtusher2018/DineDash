import 'package:dine_dash/core/utils/helper.dart';

class AuthValidator {
  /// Validate Sign In fields
  static String? validateSignIn({
    required String email,
    required String password,
  }) {
    if (email.isNullOrEmpty) {
      return "Email can't be empty";
    }
    if (!email.isValidEmail) {
      return "Please enter a valid email address";
    }
    if (password.isNullOrEmpty) {
      return "Password can't be empty";
    }
    if (!password.isValidPassword) {
      return "Password must be 6–16 characters with letters & numbers";
    }
    return null;
  }



static String? validateSignUp({
  required String fullName,
  required String email,
  required String postalCode,
  required String password,
  required String confirmPassword,
}) {
  if (fullName.isNullOrEmpty || !fullName.isValidName) {
    return "Please enter a valid full name";
  }
  if (email.isNullOrEmpty || !email.isValidEmail) {
    return "Please enter a valid email address";
  }
  if (postalCode.isNullOrEmpty) {
    return "Postal code can't be empty";
  }
  if (password.isNullOrEmpty || !password.isValidPassword) {
    return "Password must be 6–16 characters with letters & numbers";
  }
  if (confirmPassword.isNullOrEmpty) {
    return "Please confirm your password";
  }
  if (password != confirmPassword) {
    return "Passwords do not match";
  }
  return null; // All validations passed
}


}
