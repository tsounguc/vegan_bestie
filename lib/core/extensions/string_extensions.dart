extension StringExtension on String {
  String get obscureEmail => replaceRange(
        1,
        indexOf('@'),
        '****',
      );
}
