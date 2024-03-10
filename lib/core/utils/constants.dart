import 'package:flutter_dotenv/flutter_dotenv.dart';

const kFoodFactBaseUrl = 'https://us.openfoodfacts.org';

const kGooglePlaceBaseUrl = 'https://maps.googleapis.com/maps/api/place/';

final kGoogleApiKey = dotenv.env['GOOGLE_PLACES_API_KEY'];

const kImageBaseUrl = 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=';
