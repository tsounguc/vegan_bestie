import 'dart:convert';

import 'package:sheveegan/core/common/entities/restaurant_entities.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';

class RestaurantDetailsModel extends RestaurantDetails {
  const RestaurantDetailsModel({
    required super.addressComponents,
    required super.adrAddress,
    required super.businessStatus,
    required super.currentOpeningHours,
    required super.delivery,
    required super.dineIn,
    required super.formattedAddress,
    required super.formattedPhoneNumber,
    required super.geometry,
    required super.imageUrl,
    required super.icon,
    required super.iconBackgroundColor,
    required super.iconMaskBaseUri,
    required super.internationalPhoneNumber,
    required super.name,
    required super.openingHours,
    required super.photos,
    required super.id,
    required super.plusCode,
    required super.rating,
    required super.reference,
    required super.reservable,
    required super.servesBeer,
    required super.servesDinner,
    required super.servesLunch,
    required super.servesVegetarianFood,
    required super.servesWine,
    required super.takeout,
    required super.types,
    required super.url,
    required super.userRatingsTotal,
    required super.utcOffset,
    required super.vicinity,
    required super.website,
    required super.wheelchairAccessibleEntrance,
    super.reviewCount,
  });

  RestaurantDetailsModel.empty()
      : this(
          addressComponents: [],
          adrAddress: '_empty.adrAddress',
          businessStatus: '_empty.businessStatus',
          currentOpeningHours: CurrentOpeningHours.empty(),
          delivery: false,
          dineIn: false,
          formattedAddress: '_empty.formattedAddress',
          formattedPhoneNumber: '_empty.formattedPhoneNumber',
          geometry: const Geometry.empty(),
          icon: '_empty.icon',
          imageUrl: '_empty.imageUrl',
          iconBackgroundColor: '_empty.icon_background_color',
          iconMaskBaseUri: '_empty.icon_mask_base_uri',
          internationalPhoneNumber: '_empty.international_phone_number',
          name: '_empty.name',
          openingHours: OpeningHours.empty(),
          photos: [],
          id: '_empty.place_id',
          plusCode: const PlusCode.empty(),
          rating: 0,
          reference: '_empty.reference',
          reservable: false,
          servesBeer: false,
          servesDinner: false,
          servesLunch: false,
          servesVegetarianFood: false,
          servesWine: false,
          takeout: false,
          types: [],
          url: '_empty.url',
          userRatingsTotal: 5,
          utcOffset: 0,
          vicinity: '_empty.vicinity',
          website: '_empty.website',
          wheelchairAccessibleEntrance: false,
        );

  factory RestaurantDetailsModel.fromJson(String source) => RestaurantDetailsModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  RestaurantDetailsModel.fromMap(DataMap dataMap)
      : this(
          addressComponents: dataMap['address_components'] == null
              ? []
              : List<AddressComponentModel>.from(
                  (dataMap['address_components'] as List).map(
                    (component) => AddressComponentModel.fromMap(component as DataMap),
                  ),
                ),
          adrAddress: dataMap['adr_address'] == null ? '' : dataMap['adr_address'] as String,
          businessStatus: dataMap['business_status'] == null ? '' : dataMap['business_status'] as String,
          currentOpeningHours: dataMap['current_opening_hours'] == null
              ? CurrentOpeningHours.empty()
              : CurrentOpeningHoursModel.fromMap(
                  dataMap['current_opening_hours'] as DataMap,
                ),
          delivery: dataMap['delivery'] == null ? false : dataMap['delivery'] as bool,
          dineIn: dataMap['dine_in'] == null ? false : dataMap['dine_in'] as bool,
          formattedAddress: dataMap['formatted_address'] == null ? '' : dataMap['formatted_address'] as String,
          formattedPhoneNumber:
              dataMap['formatted_phone_number'] == null ? '' : dataMap['formatted_phone_number'] as String,
          geometry: GeometryModel.fromMap(dataMap['geometry'] as DataMap),
          icon: dataMap['icon'] == null ? '' : dataMap['icon'] as String,
          imageUrl: dataMap['image_url'] == null ? '' : dataMap['image_url'] as String,
          iconBackgroundColor:
              dataMap['icon_background_color'] == null ? '' : dataMap['icon_background_color'] as String,
          iconMaskBaseUri: dataMap['icon_mask_base_uri'] == null ? '' : dataMap['icon_mask_base_uri'] as String,
          internationalPhoneNumber:
              dataMap['international_phone_number'] == null ? '' : dataMap['international_phone_number'] as String,
          name: dataMap['name'] == null ? '' : dataMap['name'] as String,
          openingHours: dataMap['opening_hours'] == null
              ? OpeningHoursModel.empty()
              : OpeningHoursModel.fromMap(
                  dataMap['opening_hours'] as DataMap,
                ),
          photos: dataMap['photos'] == null
              ? []
              : List<Photo>.from(
                  (dataMap['photos'] as List).map(
                    (photo) => PhotoModel.fromMap(photo as DataMap),
                  ),
                ),
          id: dataMap['place_id'] == null ? '' : dataMap['place_id'] as String,
          plusCode: PlusCodeModel.fromMap(dataMap['plus_code'] as DataMap),
          rating: double.tryParse(dataMap['rating'].toString()) ?? 0.0,
          reference: dataMap['reference'] == null ? '' : dataMap['reference'] as String,
          reservable: dataMap['reservable'] == null ? false : dataMap['reservable'] as bool,
          servesBeer: dataMap['serves_beer'] == null ? false : dataMap['serves_beer'] as bool,
          servesDinner: dataMap['serves_dinner'] == null ? false : dataMap['serves_dinner'] as bool,
          servesLunch: dataMap['serves_lunch'] == null ? false : dataMap['serves_lunch'] as bool,
          servesVegetarianFood:
              dataMap['serves_vegetarian_food'] == null ? false : dataMap['serves_vegetarian_food'] as bool,
          servesWine: dataMap['serves_wine'] == null ? false : dataMap['serves_wine'] as bool,
          takeout: dataMap['takeout'] == null ? false : dataMap['takeout'] as bool,
          types: dataMap['types'] == null
              ? []
              : List<String>.from(
                  (dataMap['types'] as List).map((type) => type),
                ),
          url: dataMap['url'] == null ? '' : dataMap['url'] as String,
          userRatingsTotal: int.tryParse(dataMap['user_ratings_total'].toString()) ?? 0,
          utcOffset: int.tryParse(dataMap['utc_offset'].toString()) ?? 0,
          vicinity: dataMap['vicinity'] == null ? '' : dataMap['vicinity'] as String,
          website: dataMap['website'] == null ? '' : dataMap['website'] as String,
          wheelchairAccessibleEntrance: dataMap['wheelchair_accessible_entrance'] == null
              ? false
              : dataMap['wheelchair_accessible_entrance'] as bool,
          reviewCount: int.tryParse(dataMap['restaurantReviewsCount'].toString()) ?? 0,
        );

  String toJson() => jsonEncode(toMap());

  RestaurantDetailsModel copyWith({
    List<AddressComponent>? addressComponents,
    String? adrAddress,
    String? businessStatus,
    CurrentOpeningHours? currentOpeningHours,
    bool? delivery,
    bool? dineIn,
    String? formattedAddress,
    String? formattedPhoneNumber,
    Geometry? geometry,
    String? imageUrl,
    String? icon,
    String? iconBackgroundColor,
    String? iconMaskBaseUri,
    String? internationalPhoneNumber,
    String? name,
    OpeningHours? openingHours,
    List<Photo>? photos,
    String? id,
    PlusCode? plusCode,
    double? rating,
    String? reference,
    bool? reservable,
    int? reviewCount,
    bool? servesBeer,
    bool? servesDinner,
    bool? servesLunch,
    bool? servesVegetarianFood,
    bool? servesWine,
    bool? takeout,
    List<String>? types,
    String? url,
    int? userRatingsTotal,
    int? utcOffset,
    String? vicinity,
    String? website,
    bool? wheelchairAccessibleEntrance,
  }) {
    return RestaurantDetailsModel(
      addressComponents: addressComponents ?? this.addressComponents,
      adrAddress: adrAddress ?? this.adrAddress,
      businessStatus: businessStatus ?? this.businessStatus,
      currentOpeningHours: currentOpeningHours ?? this.currentOpeningHours,
      delivery: delivery ?? this.delivery,
      dineIn: dineIn ?? this.dineIn,
      formattedAddress: formattedAddress ?? this.formattedAddress,
      formattedPhoneNumber: formattedPhoneNumber ?? this.formattedPhoneNumber,
      geometry: geometry ?? this.geometry,
      imageUrl: imageUrl ?? this.imageUrl,
      icon: icon ?? this.icon,
      iconBackgroundColor: iconBackgroundColor ?? this.iconBackgroundColor,
      iconMaskBaseUri: iconMaskBaseUri ?? this.iconMaskBaseUri,
      internationalPhoneNumber: internationalPhoneNumber ?? this.internationalPhoneNumber,
      name: name ?? this.name,
      openingHours: openingHours ?? this.openingHours,
      photos: photos ?? this.photos,
      id: id ?? this.id,
      plusCode: plusCode ?? this.plusCode,
      rating: rating ?? this.rating,
      reference: reference ?? this.reference,
      reservable: reservable ?? this.reservable,
      servesBeer: servesBeer ?? this.servesBeer,
      servesDinner: servesDinner ?? this.servesDinner,
      servesLunch: servesLunch ?? this.servesLunch,
      servesVegetarianFood: servesVegetarianFood ?? this.servesVegetarianFood,
      servesWine: servesWine ?? this.servesWine,
      takeout: takeout ?? this.takeout,
      types: types ?? this.types,
      url: url ?? this.url,
      userRatingsTotal: userRatingsTotal ?? this.userRatingsTotal,
      utcOffset: utcOffset ?? this.utcOffset,
      vicinity: vicinity ?? this.vicinity,
      website: website ?? this.website,
      wheelchairAccessibleEntrance: wheelchairAccessibleEntrance ?? this.wheelchairAccessibleEntrance,
      reviewCount: reviewCount ?? this.reviewCount,
    );
  }

  Map<String, dynamic> toMap() => {
        'address_components': List<dynamic>.from(
          addressComponents.map(
            (component) => (component as AddressComponentModel).toMap(),
          ),
        ),
        'adr_address': adrAddress,
        'business_status': businessStatus,
        'current_opening_hours': (currentOpeningHours as CurrentOpeningHoursModel).toMap(),
        'delivery': delivery,
        'dine_in': dineIn,
        'formatted_address': formattedAddress,
        'formatted_phone_number': formattedPhoneNumber,
        'geometry': (geometry as GeometryModel).toMap(),
        'icon': icon,
        'icon_background_color': iconBackgroundColor,
        'icon_mask_base_uri': iconMaskBaseUri,
        'international_phone_number': internationalPhoneNumber,
        'name': name,
        'opening_hours': (openingHours as OpeningHoursModel).toMap(),
        'photos': List<dynamic>.from(
          photos.map(
            (photo) => (photo as PhotoModel).toMap(),
          ),
        ),
        'place_id': id,
        'plus_code': (plusCode as PlusCodeModel).toMap(),
        'rating': rating,
        'reference': reference,
        'reservable': reservable,
        'serves_beer': servesBeer,
        'serves_dinner': servesDinner,
        'serves_lunch': servesLunch,
        'serves_vegetarian_food': servesVegetarianFood,
        'serves_wine': servesWine,
        'takeout': takeout,
        'types': List<dynamic>.from(
          types.map((type) => type),
        ),
        'url': url,
        'user_ratings_total': userRatingsTotal,
        'utc_offset': utcOffset,
        'vicinity': vicinity,
        'website': website,
        'wheelchair_accessible_entrance': wheelchairAccessibleEntrance,
      };
}

class AddressComponentModel extends AddressComponent {
  const AddressComponentModel({
    required super.longName,
    required super.shortName,
    required super.types,
  });

  factory AddressComponentModel.fromJson(String source) => AddressComponentModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  AddressComponentModel.fromMap(DataMap dataMap)
      : this(
          longName: dataMap['long_name'] == null ? '' : dataMap['long_name'] as String,
          shortName: dataMap['short_name'] == null ? '' : dataMap['short_name'] as String,
          types: dataMap['types'] == null
              ? []
              : List<String>.from(
                  (dataMap['types'] as List).map(
                    (type) => type.toString(),
                  ),
                ),
        );

  DataMap toMap() => {
        'long_name': longName,
        'short_name': shortName,
        'types': types,
      };
}

class CurrentOpeningHoursModel extends CurrentOpeningHours {
  const CurrentOpeningHoursModel({required super.openNow, required super.periods, required super.weekdayText});

  factory CurrentOpeningHoursModel.fromJson(String source) => CurrentOpeningHoursModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  CurrentOpeningHoursModel.fromMap(DataMap dataMap)
      : this(
          openNow: dataMap['open_now'] == null ? false : dataMap['open_now'] as bool,
          periods: List<CurrentOpeningHoursPeriod>.from(
            (dataMap['periods'] as List).map(
              (period) => CurrentOpeningHoursPeriodModel.fromMap(period as DataMap),
            ),
          ),
          weekdayText: List<String>.from(
            (dataMap['weekday_text'] as List).map(
              (weekdayText) => weekdayText.toString(),
            ),
          ),
        );

  DataMap toMap() => {
        'open_now': openNow,
        'periods': List<dynamic>.from(
          periods.map(
            (period) => (period as CurrentOpeningHoursPeriodModel).toMap(),
          ),
        ),
        'weekday_text': weekdayText,
      };
}

class CurrentOpeningHoursPeriodModel extends CurrentOpeningHoursPeriod {
  const CurrentOpeningHoursPeriodModel({required super.close, required super.open});

  factory CurrentOpeningHoursPeriodModel.fromJson(String source) => CurrentOpeningHoursPeriodModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  CurrentOpeningHoursPeriodModel.fromMap(DataMap dataMap)
      : this(
          close: PurpleCloseModel.fromMap(dataMap['close'] as DataMap),
          open: PurpleCloseModel.fromMap(dataMap['open'] as DataMap),
        );

  DataMap toMap() => {
        'close': (close as PurpleCloseModel).toMap(),
        'open': (close as PurpleCloseModel).toMap(),
      };
}

class PurpleCloseModel extends PurpleClose {
  const PurpleCloseModel({required super.date, required super.day, required super.time});

  factory PurpleCloseModel.fromJson(String source) => PurpleCloseModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  PurpleCloseModel.fromMap(DataMap dataMap)
      : this(
          date: DateTime.tryParse(dataMap['date'].toString()) ?? DateTime.now(),
          day: int.tryParse(dataMap['day'].toString()) ?? 0,
          time: dataMap['time'] as String,
        );

  DataMap toMap() => {
        'date': date.toString(),
        'day': day,
        'time': time,
      };
}

class OpeningHoursModel extends OpeningHours {
  const OpeningHoursModel({
    required super.openNow,
    required super.periods,
    required super.weekdayText,
  });

  OpeningHoursModel.empty() : this(openNow: false, periods: [], weekdayText: []);

  factory OpeningHoursModel.fromJson(String source) => OpeningHoursModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  OpeningHoursModel.fromMap(DataMap dataMap)
      : this(
          openNow: dataMap['open_now'] == null ? false : dataMap['open_now'] as bool,
          periods: dataMap['periods'] == null
              ? []
              : List<OpeningHoursPeriod>.from(
                  (dataMap['periods'] as List).map(
                    (period) => OpeningHoursPeriodModel.fromMap(period as DataMap),
                  ),
                ),
          weekdayText: dataMap['weekday_text'] == null
              ? []
              : List<String>.from(
                  (dataMap['weekday_text'] as List).map(
                    (weekdayText) => weekdayText.toString(),
                  ),
                ),
        );

  DataMap toMap() => {
        'open_now': openNow,
        'periods': List<dynamic>.from(
          periods.map(
            (period) => (period as OpeningHoursPeriodModel).toMap(),
          ),
        ),
        'weekday_text': weekdayText,
      };
}

class OpeningHoursPeriodModel extends OpeningHoursPeriod {
  const OpeningHoursPeriodModel({required super.close, required super.open});

  factory OpeningHoursPeriodModel.fromJson(String source) => OpeningHoursPeriodModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  OpeningHoursPeriodModel.fromMap(DataMap dataMap)
      : this(
          close: FluffyCloseModel.fromMap(dataMap['close'] as DataMap),
          open: FluffyCloseModel.fromMap(dataMap['open'] as DataMap),
        );

  DataMap toMap() => {
        'close': (close as FluffyCloseModel).toMap(),
        'open': (close as FluffyCloseModel).toMap(),
      };
}

class FluffyCloseModel extends FluffyClose {
  const FluffyCloseModel({required super.day, required super.time});

  factory FluffyCloseModel.fromJson(String source) => FluffyCloseModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  FluffyCloseModel.fromMap(DataMap dataMap)
      : this(
          day: int.tryParse(dataMap['day'].toString()) ?? 0,
          time: dataMap['time'] == null ? '' : dataMap['time'] as String,
        );

  DataMap toMap() => {
        'day': day,
        'time': time,
      };
}

// class ReviewModel extends Review {
//   const ReviewModel({
//     required super.authorName,
//     required super.authorUrl,
//     required super.language,
//     required super.originalLanguage,
//     required super.profilePhotoUrl,
//     required super.rating,
//     required super.relativeTimeDescription,
//     required super.text,
//     required super.time,
//     required super.translated,
//   });
//
//   factory ReviewModel.fromJson(String source) => ReviewModel.fromMap(
//         jsonDecode(source) as DataMap,
//       );
//
//   ReviewModel.fromMap(DataMap dataMap)
//       : this(
//           authorName: dataMap['author_name'] == null ? '' : dataMap['author_name'] as String,
//           authorUrl: dataMap['author_url'] == null ? '' : dataMap['author_url'] as String,
//           language: dataMap['language'] == null ? '' : dataMap['language'] as String,
//           originalLanguage: dataMap['original_language'] == null ? '' : dataMap['original_language'] as String,
//           profilePhotoUrl: dataMap['author_name'] == null ? '' : dataMap['author_name'] as String,
//           rating: int.tryParse(dataMap['rating'].toString()) ?? 0,
//           relativeTimeDescription:
//               dataMap['relative_time_description'] == null ? '' : dataMap['relative_time_description'] as String,
//           text: dataMap['text'] == null ? '' : dataMap['text'] as String,
//           time: int.tryParse(dataMap['time'].toString()) ?? 0,
//           translated: dataMap['translated'] == null ? false : dataMap['translated'] as bool,
//         );
//
//   DataMap toMap() => {
//         'author_name': authorName,
//         'author_url': authorUrl,
//         'language': language,
//         'original_language': originalLanguage,
//         'profile_photo_url': profilePhotoUrl,
//         'rating': rating,
//         'relative_time_description': relativeTimeDescription,
//         'text': text,
//         'time': time,
//         'translated': translated,
//       };
// }

class PlusCodeModel extends PlusCode {
  const PlusCodeModel({
    required super.compoundCode,
    required super.globalCode,
  });

  factory PlusCodeModel.fromJson(String source) => PlusCodeModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  PlusCodeModel.fromMap(DataMap dataMap)
      : this(
          compoundCode: dataMap['compound_code'] == null ? '' : dataMap['compound_code'] as String,
          globalCode: dataMap['global_code'] == null ? '' : dataMap['global_code'] as String,
        );

  DataMap toMap() => {
        'compound_code': compoundCode,
        'globalCode': globalCode,
      };
}
