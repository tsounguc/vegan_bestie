enum NotificationCategory {
  RESTAURANT(value: 'restaurant', image: ''),
  FOOD(value: 'food', image: ''),
  GENERAL(value: 'general', image: ''),
  NONE(value: 'none', image: '');
  // None just means it doesn't have a title

  const NotificationCategory({required this.value, required this.image});

  final String value;
  final String image;
}
