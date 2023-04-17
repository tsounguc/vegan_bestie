import '../../domain/entities/restaurant_details_entity.dart';
import '../models/yelp_restaurant_details_model.dart';

class RestaurantDetailsMapper {
  RestaurantDetailsEntity mapToEntity(YelpRestaurantDetailsModel restaurantModel) {
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
    return RestaurantDetailsEntity(
      id: restaurantModel.id,
      alias: restaurantModel.alias,
      name: restaurantModel.name,
      imageUrl: restaurantModel.imageUrl,
      isClaimed: restaurantModel.isClaimed,
      isClosed: restaurantModel.isClosed,
      url: restaurantModel.url,
      phone: restaurantModel.phone,
      displayPhone: restaurantModel.displayPhone,
      reviewCount: restaurantModel.reviewCount,
      categories: restaurantModel.categories,
      rating: restaurantModel.rating,
      location: restaurantModel.location,
      coordinates: restaurantModel.coordinates,
      photos: restaurantModel.photos,
      price: restaurantModel.price,
      hours: restaurantModel.hours,
    );
  }
}
