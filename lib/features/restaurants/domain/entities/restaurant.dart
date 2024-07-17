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
    required this.openHours,
    required this.photos,
    required this.price,
    required this.veganStatus,
    required this.hasVeganOptions,
    required this.dineIn,
    required this.takeout,
    required this.delivery,
    required this.permanentlyClosed,
    this.imageIsFile = false,
    this.description,
    this.thumbnail,
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
          openHours: const OpenHours.empty(),
          photos: const ['_empty.photo1', '_empty.photo2'],
          price: '_empty.price',
          veganStatus: false,
          hasVeganOptions: false,
          imageIsFile: false,
          description: null,
          thumbnail: null,
          dineIn: false,
          takeout: false,
          delivery: false,
          permanentlyClosed: false,
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
  final String? thumbnail;
  final String? description;
  final bool imageIsFile;
  final OpenHours openHours;
  final List<String> photos;
  final String price;
  final bool veganStatus;
  final bool hasVeganOptions;
  final bool dineIn;
  final bool takeout;
  final bool delivery;
  final bool permanentlyClosed;

  @override
  List<Object?> get props => [
        id,
        // name,
        // contactName,
        // email,
        // streetAddress,
        // city,
        // state,
        // zipCode,
        // county,
        // areaCode,
        // phoneNumber,
        // websiteUrl,
        // geoLocation,
        // openingHours,
        // photos,
        // price,
        // veganStatus,
        // hasVeganOptions,
      ];
}

class OpenHours extends Equatable {
  const OpenHours({
    required this.periods,
  });

  const OpenHours.empty() : this(periods: const []);
  final List<Period> periods;

  @override
  List<Object?> get props => [periods];

  @override
  String toString() {
    return 'OpenHours: {\nperiods: $periods \n}';
  }
}

class Period extends Equatable {
  const Period({
    required this.close,
    required this.open,
  });

  const Period.empty()
      : this(
          open: const OpenClose.empty(),
          close: const OpenClose.empty(),
        );

  final OpenClose open;
  final OpenClose close;

  @override
  List<Object?> get props => [open, close];

  @override
  String toString() {
    return 'Period{\nopen: $open,\nclose: $close\n}\n';
  }
}

class OpenClose extends Equatable {
  const OpenClose({
    required this.day,
    required this.time,
  });

  const OpenClose.empty()
      : this(
          day: 0,
          time: '20:00',
        );

  final int day;
  final String time;

  @override
  List<Object?> get props => [day, time];

  @override
  String toString() {
    return '{\nday: $day,\ntime: $time\n}\n';
  }
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
