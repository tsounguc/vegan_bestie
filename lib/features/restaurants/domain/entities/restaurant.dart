import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  const Restaurant({
    required this.id,
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
    required this.geoLocation,
    required this.openingHours,
    required this.photos,
    required this.price,
    required this.veganStatus,
    required this.hasVeganOptions,
    this.imageIsFile = false,
    this.description,
    this.image,
  });

  const Restaurant.empty()
      : this(
          id: '_empty.id',
          name: '_empty.name',
          contactName: '_empty.contactName',
          email: '_empty.email',
          streetAddress: '_empty.streetAddress',
          city: '_empty.city',
          state: '_empty.state',
          zipCode: '_empty.zipCode',
          county: '_empty.county',
          areaCode: '_empty.areaCode',
          phoneNumber: '_empty.phoneNumber',
          websiteUrl: '_empty.websiteUrl',
          geoLocation: const GeoLocation.empty(),
          openingHours: const [],
          photos: const [],
          price: '_empty.price',
          veganStatus: false,
          hasVeganOptions: false,
          imageIsFile: false,
          description: null,
          image: null,
        );

  final String id;
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
  final GeoLocation geoLocation;

  // final bool isOpenNow;
  final String? image;
  final String? description;
  final bool imageIsFile;
  final List<String> openingHours;
  final List<String> photos;
  final String price;
  final bool veganStatus;
  final bool hasVeganOptions;

  @override
  List<Object?> get props => [
        id,
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

class GeoLocation extends Equatable {
  const GeoLocation({
    required this.lng,
    required this.lat,
  });

  const GeoLocation.empty()
      : this(
          lat: 0,
          lng: 0,
        );

  final double lng;
  final double lat;

  @override
  List<Object?> get props => [
        lng,
        lat,
      ];
}
