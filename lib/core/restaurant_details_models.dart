class AddressComponent {
  AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  String? longName;
  String? shortName;
  List<String>? types;

  factory AddressComponent.fromJson(Map<String, dynamic>? json) => AddressComponent(
        longName: json?["long_name"],
        shortName: json?["short_name"],
        types: json?["types"] == null ? [] : List<String>.from(json?["types"].map((x) => x)),
      );

// Map<String, dynamic> toJson() => {
//   "long_name": longName,
//   "short_name": shortName,
//   "types": List<dynamic>.from(types.map((x) => x)),
// };
}

class CurrentOpeningHours {
  CurrentOpeningHours({
    required this.openNow,
    required this.periods,
    required this.weekdayText,
  });

  bool? openNow;
  List<CurrentOpeningHoursPeriod>? periods;
  List<String>? weekdayText;

  factory CurrentOpeningHours.fromJson(Map<String, dynamic>? json) => CurrentOpeningHours(
        openNow: json?["open_now"],
        periods: json?["periods"] == null
            ? []
            : List<CurrentOpeningHoursPeriod>.from(
                json?["periods"].map((x) => CurrentOpeningHoursPeriod.fromJson(x))),
        weekdayText: json?["weekday_text"] == null ? [] : List<String>.from(json?["weekday_text"].map((x) => x)),
      );

// Map<String, dynamic> toJson() => {
//   "open_now": openNow,
//   "periods": List<dynamic>.from(periods.map((x) => x.toJson())),
//   "weekday_text": List<dynamic>.from(weekdayText.map((x) => x)),
// };
}

class CurrentOpeningHoursPeriod {
  CurrentOpeningHoursPeriod({
    required this.close,
    required this.open,
  });

  PurpleClose? close;
  PurpleClose? open;

  factory CurrentOpeningHoursPeriod.fromJson(Map<String, dynamic>? json) => CurrentOpeningHoursPeriod(
        close: PurpleClose.fromJson(json?["close"]),
        open: PurpleClose.fromJson(json?["open"]),
      );

// Map<String, dynamic> toJson() => {
//   "close": close.toJson(),
//   "open": open.toJson(),
// };
}

class PurpleClose {
  PurpleClose({
    required this.date,
    required this.day,
    required this.time,
  });

  DateTime? date;
  int? day;
  String? time;

  factory PurpleClose.fromJson(Map<String, dynamic>? json) => PurpleClose(
        date: DateTime.parse(json?["date"]),
        day: json?["day"],
        time: json?["time"],
      );

// Map<String, dynamic> toJson() => {
//       "date":
//           "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
//       "day": day,
//       "time": time,
//     };
}

class Geometry {
  Geometry({
    required this.location,
    required this.viewport,
  });

  Location? location;
  Viewport? viewport;

  factory Geometry.fromJson(Map<String, dynamic>? json) => Geometry(
        location: Location.fromJson(json?["location"]),
        viewport: Viewport.fromJson(json?["viewport"]),
      );

// Map<String, dynamic> toJson() => {
//       "location": location.toJson(),
//       "viewport": viewport.toJson(),
//     };
}

class Location {
  Location({
    required this.lat,
    required this.lng,
  });

  double? lat;
  double? lng;

  factory Location.fromJson(Map<String, dynamic>? json) => Location(
        lat: json?["lat"]?.toDouble(),
        lng: json?["lng"]?.toDouble(),
      );

// Map<String, dynamic> toJson() => {
//       "lat": lat,
//       "lng": lng,
//     };
}

class Viewport {
  Viewport({
    required this.northeast,
    required this.southwest,
  });

  Location? northeast;
  Location? southwest;

  factory Viewport.fromJson(Map<String, dynamic>? json) => Viewport(
        northeast: Location.fromJson(json?["northeast"]),
        southwest: Location.fromJson(json?["southwest"]),
      );

// Map<String, dynamic> toJson() => {
//       "northeast": northeast.toJson(),
//       "southwest": southwest.toJson(),
//     };
}

class OpeningHours {
  OpeningHours({
    required this.openNow,
    required this.periods,
    required this.weekdayText,
  });

  bool? openNow;
  List<OpeningHoursPeriod>? periods;
  List<String>? weekdayText;

  factory OpeningHours.fromJson(Map<String, dynamic>? json) => OpeningHours(
        openNow: json?["open_now"],
        periods: json?["periods"] == null
            ? []
            : List<OpeningHoursPeriod>.from(json?["periods"].map((x) => OpeningHoursPeriod.fromJson(x))),
        weekdayText: json?["weekday_text"] == null ? [] : List<String>.from(json?["weekday_text"].map((x) => x)),
      );

// Map<String, dynamic> toJson() => {
//       "open_now": openNow,
//       "periods": List<dynamic>.from(periods.map((x) => x.toJson())),
//       "weekday_text": List<dynamic>.from(weekdayText.map((x) => x)),
//     };
}

class OpeningHoursPeriod {
  OpeningHoursPeriod({
    required this.close,
    required this.open,
  });

  FluffyClose? close;
  FluffyClose? open;

  factory OpeningHoursPeriod.fromJson(Map<String, dynamic>? json) => OpeningHoursPeriod(
        close: FluffyClose.fromJson(json?["close"]),
        open: FluffyClose.fromJson(json?["open"]),
      );

// Map<String, dynamic> toJson() => {
//       "close": close.toJson(),
//       "open": open.toJson(),
//     };
}

class FluffyClose {
  FluffyClose({
    required this.day,
    required this.time,
  });

  int? day;
  String? time;

  factory FluffyClose.fromJson(Map<String, dynamic>? json) => FluffyClose(
        day: json?["day"],
        time: json?["time"],
      );

// Map<String, dynamic> toJson() => {
//       "day": day,
//       "time": time,
//     };
}

class Photo {
  Photo({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });

  int? height;
  List<String>? htmlAttributions;
  String? photoReference;
  int? width;

  factory Photo.fromJson(Map<String, dynamic>? json) => Photo(
        height: json?["height"],
        htmlAttributions:
            json?["html_attributions"] == null ? [] : List<String>.from(json?["html_attributions"].map((x) => x)),
        photoReference: json?["photo_reference"],
        width: json?["width"],
      );

// Map<String, dynamic> toJson() => {
//       "height": height,
//       "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
//       "photo_reference": photoReference,
//       "width": width,
//     };
}

class PlusCode {
  PlusCode({
    required this.compoundCode,
    required this.globalCode,
  });

  String? compoundCode;
  String? globalCode;

  factory PlusCode.fromJson(Map<String, dynamic>? json) => PlusCode(
        compoundCode: json?["compound_code"],
        globalCode: json?["global_code"],
      );

// Map<String, dynamic> toJson() => {
//       "compound_code": compoundCode,
//       "global_code": globalCode,
//     };
}

class Review {
  Review({
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

  String? authorName;
  String? authorUrl;
  String? language;
  String? originalLanguage;
  String? profilePhotoUrl;
  int? rating;
  String? relativeTimeDescription;
  String? text;
  int? time;
  bool? translated;

  factory Review.fromJson(Map<String, dynamic>? json) => Review(
        authorName: json?["author_name"],
        authorUrl: json?["author_url"],
        language: json?["language"],
        originalLanguage: json?["original_language"],
        profilePhotoUrl: json?["profile_photo_url"],
        rating: json?["rating"],
        relativeTimeDescription: json?["relative_time_description"],
        text: json?["text"],
        time: json?["time"],
        translated: json?["translated"],
      );

// Map<String, dynamic> toJson() => {
//       "author_name": authorName,
//       "author_url": authorUrl,
//       "language": language,
//       "original_language": originalLanguage,
//       "profile_photo_url": profilePhotoUrl,
//       "rating": rating,
//       "relative_time_description": relativeTimeDescription,
//       "text": text,
//       "time": time,
//       "translated": translated,
//     };
}
