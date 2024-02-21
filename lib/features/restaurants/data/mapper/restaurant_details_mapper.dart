import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../domain/entities/restaurant_details_entity.dart';
import '../models/google_restaurant_details_model.dart';
import '../models/yelp_restaurant_details_model.dart';

class RestaurantDetailsMapper {
  RestaurantDetailsEntity? mapYelpModelToEntity(YelpRestaurantDetailsModel? restaurantModel) {
    //   List<CategoryEntity> categoryEntities = [];
    //   List<Category>? categories = restaurantModel.categories;
    //   if (categories != null) {
    //     for (int index = 0; index < categories.length; index++) {
    //       categoryEntities.add(
    //         CategoryEntity(
    //           alias: categories[index].alias,
    //           title: categories[index].title,
    //         ),
    //       );
    //     }
    //   }
    //   return RestaurantDetailsEntity(
    //     id: restaurantModel.id,
    //     // alias: restaurantModel.alias,
    //     name: restaurantModel.name,
    //     imageUrl: restaurantModel.imageUrl,
    //     isClaimed: restaurantModel.isClaimed,
    //     isClosed: restaurantModel.isClosed,
    //     url: restaurantModel.url,
    //     phone: restaurantModel.phone,
    //     displayPhone: restaurantModel.displayPhone,
    //     reviewCount: restaurantModel.reviewCount,
    //     categories: restaurantModel.categories,
    //     rating: restaurantModel.rating,
    //     location: restaurantModel.location,
    //     coordinates: restaurantModel.coordinates,
    //     photos: restaurantModel.photos,
    //     price: restaurantModel.price,
    //     hours: restaurantModel.hours,
    //   );
  }

  RestaurantDetailsEntity mapGoogleModelToEntity(GoogleRestaurantDetailsModel restaurantModel) {
    return RestaurantDetailsEntity(
      addressComponents: restaurantModel.addressComponents,
      adrAddress: restaurantModel.adrAddress,
      businessStatus: restaurantModel.businessStatus,
      currentOpeningHours: restaurantModel.currentOpeningHours,
      delivery: restaurantModel.delivery,
      dineIn: restaurantModel.dineIn,
      formattedAddress: restaurantModel.formattedAddress,
      formattedPhoneNumber: restaurantModel.formattedPhoneNumber,
      geometry: restaurantModel.geometry,
      imageUrl: restaurantModel.photos!.isEmpty
          ? restaurantModel.icon
          : "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${restaurantModel.photos![0].photoReference}&key=${dotenv.env['GOOGLE_PLACES_API_KEY']}",
      icon: restaurantModel.icon,
      iconBackgroundColor: restaurantModel.iconBackgroundColor,
      iconMaskBaseUri: restaurantModel.iconMaskBaseUri,
      internationalPhoneNumber: restaurantModel.internationalPhoneNumber,
      name: restaurantModel.name,
      openingHours: restaurantModel.openingHours,
      photos: restaurantModel.photos,
      placeId: restaurantModel.placeId,
      plusCode: restaurantModel.plusCode,
      rating: restaurantModel.rating,
      reference: restaurantModel.reference,
      reservable: restaurantModel.reservable,
      reviews: restaurantModel.reviews,
      servesBeer: restaurantModel.servesBeer,
      servesDinner: restaurantModel.servesDinner,
      servesLunch: restaurantModel.servesLunch,
      servesVegetarianFood: restaurantModel.servesVegetarianFood,
      servesWine: restaurantModel.servesWine,
      takeout: restaurantModel.takeout,
      types: restaurantModel.types,
      url: restaurantModel.url,
      userRatingsTotal: restaurantModel.userRatingsTotal,
      utcOffset: restaurantModel.utcOffset,
      vicinity: restaurantModel.vicinity,
      website: restaurantModel.website,
      wheelchairAccessibleEntrance: restaurantModel.wheelchairAccessibleEntrance,
    );
  }
}
