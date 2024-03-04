import 'package:equatable/equatable.dart';

class RestaurantDetails extends Equatable {
  const RestaurantDetails({
    required this.addressComponents,
    required this.adrAddress,
    required this.businessStatus,
    required this.currentOpeningHours,
    required this.delivery,
    required this.dineIn,
    required this.formattedAddress,
    required this.formattedPhoneNumber,
    required this.geometry,
    required this.imageUrl,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconMaskBaseUri,
    required this.internationalPhoneNumber,
    required this.name,
    required this.openingHours,
    required this.photos,
    required this.placeId,
    required this.plusCode,
    required this.rating,
    required this.reference,
    required this.reservable,
    required this.reviews,
    required this.servesBeer,
    required this.servesDinner,
    required this.servesLunch,
    required this.servesVegetarianFood,
    required this.servesWine,
    required this.takeout,
    required this.types,
    required this.url,
    required this.userRatingsTotal,
    required this.utcOffset,
    required this.vicinity,
    required this.website,
    required this.wheelchairAccessibleEntrance,
  });

  RestaurantDetails.empty()
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
          imageUrl: '_empty.imageUrl',
          icon: '_empty.icon',
          iconBackgroundColor: '_empty.iconBackgroundColor',
          iconMaskBaseUri: '_empty.iconMaskBaseUri',
          internationalPhoneNumber: '_empty.internationalPhoneNumber',
          name: '_empty.name',
          openingHours: OpeningHours.empty(),
          photos: [],
          placeId: '_empty.placeId',
          plusCode: const PlusCode.empty(),
          rating: 0,
          reference: '_empty.reference',
          reservable: false,
          reviews: [],
          servesBeer: false,
          servesDinner: false,
          servesLunch: false,
          servesVegetarianFood: false,
          servesWine: false,
          takeout: false,
          types: [],
          url: '_empty.url',
          userRatingsTotal: 0,
          utcOffset: 0,
          vicinity: '_empty.vicinity',
          website: '_empty.website',
          wheelchairAccessibleEntrance: false,
        );

  final List<AddressComponent> addressComponents;
  final String adrAddress;
  final String businessStatus;
  final CurrentOpeningHours currentOpeningHours;
  final bool delivery;
  final bool dineIn;
  final String formattedAddress;
  final String formattedPhoneNumber;
  final Geometry geometry;
  final String imageUrl;
  final String icon;
  final String iconBackgroundColor;
  final String iconMaskBaseUri;
  final String internationalPhoneNumber;
  final String name;
  final OpeningHours openingHours;
  final List<Photo> photos;
  final String placeId;
  final PlusCode plusCode;
  final double rating;
  final String reference;
  final bool reservable;
  final List<Review> reviews;
  final bool servesBeer;
  final bool servesDinner;
  final bool servesLunch;
  final bool servesVegetarianFood;
  final bool servesWine;
  final bool takeout;
  final List<String> types;
  final String url;
  final int userRatingsTotal;
  final int utcOffset;
  final String vicinity;
  final String website;
  final bool wheelchairAccessibleEntrance;

  @override
  List<Object?> get props => [
        addressComponents,
        adrAddress,
        businessStatus,
        currentOpeningHours,
        delivery,
        dineIn,
        formattedAddress,
        formattedPhoneNumber,
        geometry,
        imageUrl,
        icon,
        iconBackgroundColor,
        iconMaskBaseUri,
        internationalPhoneNumber,
        name,
        openingHours,
        photos,
        placeId,
        plusCode,
        rating,
        reference,
        reservable,
        reviews,
        servesBeer,
        servesDinner,
        servesLunch,
        servesVegetarianFood,
        servesWine,
        takeout,
        types,
        url,
        userRatingsTotal,
        utcOffset,
        vicinity,
        website,
        wheelchairAccessibleEntrance,
      ];
}

class AddressComponent extends Equatable {
  const AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  AddressComponent.empty()
      : this(
          longName: '_empty.longName',
          shortName: '_empty.shortName',
          types: [],
        );

  final String longName;
  final String shortName;
  final List<String> types;

  @override
  List<Object?> get props => [longName, shortName, types];
}

class CurrentOpeningHours extends Equatable {
  const CurrentOpeningHours({
    required this.openNow,
    required this.periods,
    required this.weekdayText,
  });

  CurrentOpeningHours.empty()
      : this(
          openNow: false,
          periods: [],
          weekdayText: [],
        );

  final bool openNow;
  final List<CurrentOpeningHoursPeriod> periods;
  final List<String> weekdayText;

  @override
  List<Object?> get props => [openNow, periods, weekdayText];
}

class CurrentOpeningHoursPeriod extends Equatable {
  const CurrentOpeningHoursPeriod({
    required this.close,
    required this.open,
  });

  CurrentOpeningHoursPeriod.empty()
      : this(
          close: PurpleClose.empty(),
          open: PurpleClose.empty(),
        );

  final PurpleClose close;
  final PurpleClose open;

  @override
  List<Object?> get props => [close, open];
}

class PurpleClose extends Equatable {
  const PurpleClose({
    required this.date,
    required this.day,
    required this.time,
  });

  PurpleClose.empty()
      : this(
          date: DateTime.now(),
          day: 0,
          time: '_empty.time',
        );

  final DateTime date;
  final int day;
  final String time;

  @override
  List<Object?> get props => [date, day, time];
}

class Geometry extends Equatable {
  const Geometry({
    required this.location,
    required this.viewport,
  });

  const Geometry.empty()
      : this(
          location: const Location.empty(),
          viewport: const Viewport.empty(),
        );

  final Location location;
  final Viewport viewport;

  @override
  List<Object?> get props => [location, viewport];
}

class Location extends Equatable {
  const Location({
    required this.lat,
    required this.lng,
  });

  const Location.empty() : this(lat: 0, lng: 0);

  final double lat;
  final double lng;

  @override
  List<Object?> get props => [lat, lng];
}

class Viewport extends Equatable {
  const Viewport({
    required this.northeast,
    required this.southwest,
  });

  const Viewport.empty()
      : this(
          northeast: const Location.empty(),
          southwest: const Location.empty(),
        );

  final Location northeast;
  final Location southwest;

  @override
  List<Object?> get props => [northeast, southwest];
}

class OpeningHours extends Equatable {
  const OpeningHours({
    required this.openNow,
    required this.periods,
    required this.weekdayText,
  });

  OpeningHours.empty()
      : this(
          openNow: false,
          periods: [],
          weekdayText: [],
        );

  final bool openNow;
  final List<OpeningHoursPeriod> periods;
  final List<String> weekdayText;

  @override
  List<Object?> get props => [openNow, periods, weekdayText];
}

class OpeningHoursPeriod extends Equatable {
  const OpeningHoursPeriod({
    required this.close,
    required this.open,
  });

  const OpeningHoursPeriod.empty()
      : this(
          close: const FluffyClose.empty(),
          open: const FluffyClose.empty(),
        );

  final FluffyClose close;
  final FluffyClose open;

  @override
  List<Object?> get props => [close, open];
}

class FluffyClose extends Equatable {
  const FluffyClose({
    required this.day,
    required this.time,
  });

  const FluffyClose.empty()
      : this(
          day: 0,
          time: '_empty.time',
        );

  final int day;
  final String time;

  @override
  List<Object?> get props => [day, time];
}

class Photo extends Equatable {
  const Photo({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });

  Photo.empty()
      : this(
          height: 0,
          htmlAttributions: [],
          photoReference: '_empty.photoReference',
          width: 0,
        );

  final int height;
  final List<String> htmlAttributions;
  final String photoReference;
  final int width;

  @override
  List<Object?> get props => [
        height,
        htmlAttributions,
        photoReference,
        width,
      ];
}

class PlusCode extends Equatable {
  const PlusCode({
    required this.compoundCode,
    required this.globalCode,
  });

  const PlusCode.empty()
      : this(
          compoundCode: '_empty.compoundCode',
          globalCode: '_empty.globalCode',
        );

  final String compoundCode;
  final String globalCode;

  @override
  List<Object?> get props => [compoundCode, globalCode];
}

class Review extends Equatable {
  const Review({
    required this.authorName,
    required this.authorUrl,
    required this.language,
    required this.originalLanguage,
    required this.profilePhotoUrl,
    required this.rating,
    required this.relativeTimeDescription,
    required this.text,
    required this.time,
    required this.translated,
  });

  const Review.empty()
      : this(
          authorName: '_empty.authorName',
          authorUrl: '_empty.authorUrl',
          language: '_empty.language',
          originalLanguage: '_empty.originalLanguage',
          profilePhotoUrl: '_empty.profilePhotoUrl',
          rating: 0,
          relativeTimeDescription: '_empty.relativeTimeDescription',
          text: '_empty.text',
          time: 0,
          translated: false,
        );

  final String authorName;
  final String authorUrl;
  final String language;
  final String originalLanguage;
  final String profilePhotoUrl;
  final int rating;
  final String relativeTimeDescription;
  final String text;
  final int time;
  final bool translated;

  @override
  List<Object?> get props => [
        authorName,
        authorUrl,
        language,
        originalLanguage,
        profilePhotoUrl,
        rating,
        relativeTimeDescription,
        text,
        time,
        translated,
      ];
}
