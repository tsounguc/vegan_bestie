extension StringExtension on String {
  String get obscureEmail => replaceRange(
        1,
        indexOf('@'),
        '****',
      );

  String capitalizeFirstLetter() => this.isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';

  String capitalizeEveryWord(String splitPattern) =>
      this.split(splitPattern).map((word) => word.capitalizeFirstLetter()).join(splitPattern);
}
