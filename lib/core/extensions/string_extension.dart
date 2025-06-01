extension StringExtension on String {
  String get getStringWithoutSpaces {
    List<String> chars = this.split("");
    List<String> validText = [];
    for (int i = 0; i < chars.length; i++) {
      if (chars[i].trim().isNotEmpty) {
        validText.add(chars[i]);
      }
    }
    return validText.join();
  }

  bool get isValidEmail {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(this);
  }
}
