import 'dart:convert';

import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';

class RestaurantModel extends Restaurant {
  const RestaurantModel({
    required super.id,
    required super.name,
    required super.contactName,
    required super.email,
    required super.streetAddress,
    required super.city,
    required super.state,
    required super.zipCode,
    required super.county,
    required super.areaCode,
    required super.phoneNumber,
    required super.geoLocation,
    required super.websiteUrl,
    required super.openHours,
    required super.photos,
    required super.price,
    required super.veganStatus,
    required super.hasVeganOptions,
    required super.dineIn,
    required super.takeout,
    required super.delivery,
    required super.permanentlyClosed,
    super.description,
    super.thumbnail,
    super.imageIsFile = false,
  });

  const RestaurantModel.empty()
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
          geoLocation: const GeoLocationModel.empty(),
          openHours: const OpenHoursModel.empty(),
          photos: const [],
          price: '_empty.price',
          permanentlyClosed: false,
          veganStatus: false,
          hasVeganOptions: false,
          dineIn: false,
          takeout: false,
          delivery: false,
        );

  RestaurantModel.copy(Restaurant restaurant) // HERE
      : this(
          id: restaurant.id,
          name: restaurant.name,
          contactName: restaurant.contactName,
          email: restaurant.email,
          description: restaurant.description,
          streetAddress: restaurant.streetAddress,
          city: restaurant.city,
          state: restaurant.state,
          zipCode: restaurant.zipCode,
          county: restaurant.county,
          areaCode: restaurant.areaCode,
          phoneNumber: restaurant.phoneNumber,
          websiteUrl: restaurant.websiteUrl,
          geoLocation: restaurant.geoLocation,
          openHours: restaurant.openHours,
          photos: restaurant.photos,
          price: restaurant.price,
          permanentlyClosed: restaurant.permanentlyClosed,
          veganStatus: restaurant.veganStatus,
          hasVeganOptions: restaurant.hasVeganOptions,
          dineIn: restaurant.dineIn,
          takeout: restaurant.takeout,
          delivery: restaurant.delivery,
        );

  factory RestaurantModel.fromJson(String source) => RestaurantModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  RestaurantModel.fromMap(DataMap dataMap)
      : this(
          id: dataMap['id'] as String? ?? '',
          thumbnail: dataMap['thumbnail'] as String?,
          imageIsFile: dataMap['imageIsFile'] as bool? ?? false,
          description: dataMap['description'] as String?,
          name: dataMap['name'] as String? ?? '',
          contactName: dataMap['contactName'] as String? ?? '',
          email: dataMap['email'] as String? ?? '',
          streetAddress: dataMap['streetAddress'] as String? ?? '',
          city: dataMap['city'] as String? ?? '',
          state: dataMap['state'] as String? ?? '',
          zipCode: dataMap['zipCode'] as String? ?? '',
          county: dataMap['county'] as String? ?? '',
          areaCode: dataMap['areaCode'] as String? ?? '',
          phoneNumber: dataMap['phoneNumber'] as String? ?? '',
          websiteUrl: dataMap['websiteUrl'] as String? ?? '',
          geoLocation: dataMap['geoLocation'] == null
              ? const GeoLocationModel.empty()
              : GeoLocationModel.fromMap(dataMap['geoLocation'] as DataMap),
          openHours: dataMap['openHours'] == null
              ? const OpenHoursModel.empty()
              : OpenHoursModel.fromMap(dataMap['openHours'] as DataMap),
          photos: dataMap['photos'] == null
              ? []
              : List<String>.from(
                  (dataMap['photos'] as List).map((photo) => photo),
                ),
          price: dataMap['price'] as String? ?? '',
          permanentlyClosed: dataMap['permanentlyClosed'] as bool? ?? false,
          veganStatus: dataMap['veganStatus'] as bool? ?? false,
          hasVeganOptions: dataMap['hasVeganOptions'] as bool? ?? false,
          dineIn: dataMap['dineIn'] as bool? ?? false,
          takeout: dataMap['takeout'] as bool? ?? false,
          delivery: dataMap['delivery'] as bool? ?? false,
        );

  String toJson() => jsonEncode(toMap());

  DataMap toMap() => {
        'id': id,
        'thumbnail': thumbnail,
        'imageIsFile': imageIsFile,
        'description': description,
        'name': name,
        'contactName': contactName,
        'email': email,
        'streetAddress': streetAddress,
        'city': city,
        'state': state,
        'zipCode': zipCode,
        'county': county,
        'areaCode': areaCode,
        'phoneNumber': phoneNumber,
        'websiteUrl': websiteUrl,
        'geoLocation': (geoLocation as GeoLocationModel).toMap(),
        'openHours': (openHours as OpenHoursModel).toMap(),
        'photos': List<dynamic>.from(
          photos.map(
            (photo) => photo,
          ),
        ),
        'permanentlyClosed': permanentlyClosed,
        'price': price,
        'veganStatus': veganStatus,
        'hasVeganOptions': hasVeganOptions,
        'dineIn': dineIn,
        'takeout': takeout,
        'delivery': delivery,
      };

  RestaurantModel copyWith({
    String? id,
    String? thumbnail,
    bool? imageIsFile,
    String? description,
    String? name,
    String? contactName,
    String? email,
    String? streetAddress,
    String? city,
    String? state,
    String? zipCode,
    String? county,
    String? areaCode,
    String? phoneNumber,
    String? websiteUrl,
    GeoLocation? geoLocation,
    OpenHoursModel? openHours,
    List<String>? photos,
    String? price,
    bool? permanentlyClosed,
    bool? veganStatus,
    bool? hasVeganOptions,
    bool? dineIn,
    bool? takeout,
    bool? delivery,
  }) {
    return RestaurantModel(
      id: id ?? this.id,
      thumbnail: thumbnail ?? this.thumbnail,
      imageIsFile: imageIsFile ?? this.imageIsFile,
      description: description ?? this.description,
      name: name ?? this.name,
      contactName: contactName ?? this.contactName,
      email: email ?? this.email,
      streetAddress: streetAddress ?? this.streetAddress,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      county: county ?? this.county,
      areaCode: areaCode ?? this.areaCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      geoLocation: geoLocation ?? this.geoLocation,
      openHours: openHours ?? this.openHours,
      photos: photos ?? this.photos,
      price: price ?? this.price,
      permanentlyClosed: permanentlyClosed ?? this.permanentlyClosed,
      veganStatus: veganStatus ?? this.veganStatus,
      hasVeganOptions: hasVeganOptions ?? this.hasVeganOptions,
      dineIn: dineIn ?? this.dineIn,
      takeout: takeout ?? this.takeout,
      delivery: delivery ?? this.delivery,
    );
  }
}

class OpenHoursModel extends OpenHours {
  const OpenHoursModel({
    required super.periods,
  });

  const OpenHoursModel.empty()
      : this(
          periods: const [],
        );

  factory OpenHoursModel.fromJson(String source) => OpenHoursModel.fromMap(jsonDecode(source) as DataMap);

  OpenHoursModel.fromMap(DataMap dataMap)
      : this(
          periods: dataMap['periods'] == null
              ? []
              : List<PeriodModel>.from(
                  (dataMap['periods'] as List).map(
                    (period) => PeriodModel.fromMap(period as DataMap),
                  ),
                ),
        );

  String toJson() => json.encode(toMap());

  DataMap toMap() => {
        'periods': List<dynamic>.from(
          periods.map(
            (period) => (period as PeriodModel).toMap(),
          ),
        ),
      };

  OpenHoursModel copyWith({
    List<Period>? periods,
  }) =>
      OpenHoursModel(
        periods: periods ?? this.periods,
      );
}

class PeriodModel extends Period {
  const PeriodModel({
    required super.open,
    required super.close,
  });

  const PeriodModel.empty()
      : this(
          open: const OpenCloseModel.empty(),
          close: const OpenCloseModel.empty(),
        );

  factory PeriodModel.fromJson(String source) => PeriodModel.fromMap(jsonDecode(source) as DataMap);

  PeriodModel.fromMap(DataMap dataMap)
      : this(
          open: dataMap['open'] == null
              ? const OpenCloseModel.empty()
              : OpenCloseModel.fromMap(dataMap['open'] as DataMap),
          close: dataMap['close'] == null
              ? const OpenCloseModel.empty()
              : OpenCloseModel.fromMap(dataMap['close'] as DataMap),
        );

  String toJson() => jsonEncode(toMap());

  DataMap toMap() => {
        'close': (close as OpenCloseModel).toMap(),
        'open': (open as OpenCloseModel).toMap(),
      };

  PeriodModel copyWith({
    OpenCloseModel? close,
    OpenCloseModel? open,
  }) =>
      PeriodModel(
        close: close ?? this.close,
        open: open ?? this.open,
      );
}

class OpenCloseModel extends OpenClose {
  const OpenCloseModel({
    required super.day,
    required super.time,
  });

  const OpenCloseModel.empty()
      : this(
          day: 0,
          time: '',
        );

  factory OpenCloseModel.fromJson(String source) => OpenCloseModel.fromMap(jsonDecode(source) as DataMap);

  OpenCloseModel.fromMap(DataMap dataMap)
      : this(
          day: dataMap['day'] as int? ?? 0,
          time: dataMap['time'] as String? ?? '',
        );

  String toJson() => jsonEncode(toMap());

  DataMap toMap() => {
        'day': day,
        'time': time,
      };
}

class GeoLocationModel extends GeoLocation {
  const GeoLocationModel({required super.lng, required super.lat});

  const GeoLocationModel.empty()
      : this(
          lat: 0,
          lng: 0,
        );

  factory GeoLocationModel.fromJson(String source) => GeoLocationModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  GeoLocationModel.fromMap(DataMap dataMap)
      : this(
          lat: double.tryParse(dataMap['lat'].toString()) ?? 0.0,
          lng: double.tryParse(dataMap['lng'].toString()) ?? 0.0,
        );

  String toJson() => jsonEncode(toMap());

  DataMap toMap() => {
        'lat': lat,
        'lng': lng,
      };
}

// class OpenPeriodModel extends OpenPeriod {
//   const OpenPeriodModel({
//     required super.openingTime,
//     required super.closingTime,
//   });
//
//   const OpenPeriodModel.empty()
//       : this(
//           openingTime: '00:00',
//           closingTime: '00:00',
//         );
//
//   factory OpenPeriodModel.fromJson(String source) => OpenPeriodModel.fromMap(
//         jsonDecode(source) as DataMap,
//       );
//
//   String toJson() => json.encode(toMap());
//
//   factory OpenPeriodModel.fromMap(DataMap dataMap) => OpenPeriodModel(
//         openingTime: dataMap["openingTime"] as String? ?? '',
//         closingTime: dataMap["closingTime"] as String? ?? '',
//       );
//
//   Map<String, dynamic> toMap() => {
//         'openingTime': openingTime,
//         'closingTime': closingTime,
//       };
// }
