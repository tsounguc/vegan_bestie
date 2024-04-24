extension StringExtension on String {
  String get obscureEmail => replaceRange(
        1,
        indexOf('@'),
        '****',
      );

  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';
}
