class Validators {

  static String? email(String? value) {

    if (value == null ||
        value.trim().isEmpty) {

      return "Email is required";
    }

    final emailRegex = RegExp(

      r'^[^@]+@[^@]+\.[^@]+',

    );

    if (!emailRegex.hasMatch(value)) {

      return "Invalid email";
    }

    return null;
  }

  static String? password(
      String? value) {

    if (value == null ||
        value.isEmpty) {

      return "Password is required";
    }

    if (value.length < 6) {

      return "Minimum 6 characters";
    }

    return null;
  }
}