class Validations {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    final nameRegExp = RegExp(
        r'^[a-zA-Z ]+$'); // Regular expression to allow only alphabets and spaces
    if (!nameRegExp.hasMatch(value)) {
      return 'Name can only contain alphabets and spaces';
    }
    return null;
  }

  static String? emailValidator(String? email) {
    if (email == '') {
      return "email is required";
    }
    if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email ?? '')) {
      return "Enter valid Email";
    }
    return null;
  }

  static String? phoneValidator(String? phone) {
    if (phone == null || phone.isEmpty) {
      return "Phone number is required";
    }

    // Regular expression for phone number validation (accepts numbers with optional '+')
    // You can adjust the regex as per your specific phone number format requirements.
    if (!RegExp(r'^\+?[0-9]{10,}$').hasMatch(phone)) {
      return "Enter a valid phone number";
    }

    return null;
  }
}
