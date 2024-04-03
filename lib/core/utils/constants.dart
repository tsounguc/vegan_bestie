import 'package:flutter_dotenv/flutter_dotenv.dart';

const kFoodFactBaseUrl = 'https://us.openfoodfacts.org';

const kGooglePlaceBaseUrl = 'https://maps.googleapis.com/maps/api/place/';

final kGoogleApiKey = dotenv.env['GOOGLE_PLACES_API_KEY'];

const kImageBaseUrl = 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=';

const kDefaultAvatar = 'https://images.freeimages.com/fic/images/icons/573/must_have/256/user.png';

const kUserIconPath = 'assets/user.png';
