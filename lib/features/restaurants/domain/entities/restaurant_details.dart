import 'package:equatable/equatable.dart';
import 'package:sheveegan/core/common/entities/restaurant_entities.dart';

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
    required this.id,
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
          id: '_empty.placeId',
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
  final String id;
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
        id,
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
