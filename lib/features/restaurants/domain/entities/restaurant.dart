import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  Restaurant({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.contactName,
    required this.email,
    required this.streetAddress,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.county,
    required this.areaCode,
    required this.phoneNumber,
    required this.websiteUrl,
    required this.openingHours,
    required this.photos,
    required this.price,
    required this.veganStatus,
    required this.hasVeganOptions,
  });

  final String id;
  final String imageUrl;
  final String name;
  final String contactName;
  final String email;
  final String streetAddress;
  final String city;
  final String state;
  final String zipCode;
  final String county;
  final String areaCode;
  final String phoneNumber;
  final String websiteUrl;

  // final bool isOpenNow;
  final List<String> openingHours;
  final List<String> photos;
  final List<String> price;
  final bool veganStatus;
  final bool hasVeganOptions;

  @override
  List<Object?> get props => [
        id,
        imageUrl,
        name,
        contactName,
        email,
        streetAddress,
        city,
        state,
        zipCode,
        county,
        areaCode,
        phoneNumber,
        websiteUrl,
        openingHours,
        photos,
        price,
        veganStatus,
        hasVeganOptions,
      ];
}
