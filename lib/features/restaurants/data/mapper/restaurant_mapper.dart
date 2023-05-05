import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';

import '../../domain/entities/restaurant_entity.dart';
import '../models/google_restaurant_model.dart';
import '../models/yelp_restaurants_model.dart';

class RestaurantMapper {
  RestaurantEntity mapYelpModelToEntity(YelpRestaurantModel restaurantModel) {
    //TODO: complete RestaurantEntity class
    List<CategoryEntity> categoryEntities = [];
    List<Category>? categories = restaurantModel.categories;
    if (categories != null) {
      for (int index = 0; index < categories.length; index++) {
        categoryEntities.add(
          CategoryEntity(
            alias: categories[index].alias,
            title: categories[index].title,
          ),
        );
      }
    }
    // List<HourEntity> hoursEntity = [];
    // List<Hour>? hours = restaurantModel.hours;
    // if (hours != null) {
    //   for (int index = 0; index < hours.length; index++) {
    //     List<OpenHourEntity> openHoursEntitiy = [];
    //     List<OpenHour> openHours = restaurantModel.hours![index].openHours;
    //     for (int i = 0; i < openHours.length; i++) {
    //       openHoursEntitiy.add(
    //         OpenHourEntity(
    //           day: openHours[i].day,
    //           start: openHours[i].start,
    //           end: openHours[i].end,
    //           isOvernight: openHours[i].isOvernight,
    //         ),
    //       );
    //     }
    //     hoursEntity.add(
    //       HourEntity(
    //         hourType: hours[index].hourType,
    //         openHours: openHoursEntitiy,
    //         isOpenNow: hours[index].isOpenNow,
    //       ),
    //     );
    //   }
    // }

    return RestaurantEntity(
      id: restaurantModel.id,
      name: restaurantModel.name,
      // categories: categoryEntities,
      // url: restaurantModel.url,
      imageUrl: restaurantModel.imageUrl,
      distance: restaurantModel.distance,
      // location: LocationEntity(
      //     address1: restaurantModel.location?.address1,
      //     address2: restaurantModel.location?.address2,
      //     address3: restaurantModel.location?.address3,
      //     city: restaurantModel.location?.city,
      //     zipCode: restaurantModel.location?.zipCode,
      //     country: restaurantModel.location?.country,
      //     state: restaurantModel.location?.state,
      //     displayAddress: restaurantModel.location?.displayAddress),
      price: restaurantModel.price,
      rating: restaurantModel.rating,
      reviewCount: restaurantModel.reviewCount,
      isOpenNow: false,
      vicinity: '',
      lat: null,
      lng: null,
      // isOpenNow: restaurantModel.isOpenNow,
      // hours: hoursEntity,
      // displayPhone: restaurantModel.displayPhone,
      // phone: restaurantModel.phone,
    );
  }

  RestaurantEntity mapGoogleModelToEntity(GoogleRestaurantModel restaurantModel, Position position) {
    //TODO: complete RestaurantEntity class

    return RestaurantEntity(
      id: restaurantModel.placeId,
      name: restaurantModel.name,
      imageUrl: restaurantModel.photos!.isEmpty
          ? restaurantModel.icon
          : "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${restaurantModel.photos![0].photoReference}&key=${dotenv.env['GOOGLE_PLACES_API_KEY']}",
      distance: Geolocator.distanceBetween(position.latitude, position.longitude,
          restaurantModel.geometry!.location!.lat!, restaurantModel.geometry!.location!.lng!),
      vicinity: restaurantModel.vicinity,
      lat: restaurantModel.geometry?.location?.lat,
      lng: restaurantModel.geometry?.location?.lng,
      price: restaurantModel.priceLevel == 0
          ? ""
          : restaurantModel.priceLevel == 1
              ? "\$"
              : restaurantModel.priceLevel == 2
                  ? "\$\$"
                  : restaurantModel.priceLevel == 3
                      ? "\$\$\$"
                      : "\$\$\$\$",
      rating: restaurantModel.rating,
      reviewCount: restaurantModel.userRatingsTotal,
      isOpenNow: restaurantModel.openingHours?.openNow,
    );
  }
}
