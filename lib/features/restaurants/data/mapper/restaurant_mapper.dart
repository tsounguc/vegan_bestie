import '../../domain/entities/restaurant_entity.dart';
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
    return RestaurantEntity(
      name: restaurantModel.name,
      categories: categoryEntities,
      url: restaurantModel.url,
      imageUrl: restaurantModel.imageUrl,
      distance: restaurantModel.distance,
      location: LocationEntity(
          address1: restaurantModel.location?.address1,
          address2: restaurantModel.location?.address2,
          address3: restaurantModel.location?.address3,
          city: restaurantModel.location?.city,
          zipCode: restaurantModel.location?.zipCode,
          country: restaurantModel.location?.country,
          state: restaurantModel.location?.state,
          displayAddress: restaurantModel.location?.displayAddress),
      price: restaurantModel.price,
      rating: restaurantModel.rating,
      reviewCount: restaurantModel.reviewCount,
    );
  }
}