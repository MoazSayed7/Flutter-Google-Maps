class MainText {
  final String text;
  final List<Match> matches;

  MainText({
    required this.text,
    required this.matches,
  });

  factory MainText.fromJson(Map<String, dynamic> json) {
    return MainText(
      text: json['text'],
      matches: (json['matches'] as List).map((e) => Match.fromJson(e)).toList(),
    );
  }
}

class Match {
  final int endOffset;

  Match({required this.endOffset});

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(endOffset: json['endOffset']);
  }
}

class PlacePrediction {
  final String place;
  final String placeId;
  final TextData text;
  final StructuredFormat structuredFormat;
  final List<String> types;

  PlacePrediction({
    required this.place,
    required this.placeId,
    required this.text,
    required this.structuredFormat,
    required this.types,
  });

  factory PlacePrediction.fromJson(Map<String, dynamic> json) {
    return PlacePrediction(
      place: json['place'],
      placeId: json['placeId'],
      text: TextData.fromJson(json['text']),
      structuredFormat: StructuredFormat.fromJson(json['structuredFormat']),
      types: List<String>.from(json['types']),
    );
  }
}

class PlaceSuggestion {
  final PlacePrediction placePrediction;

  PlaceSuggestion({required this.placePrediction});

  factory PlaceSuggestion.fromJson(Map<String, dynamic> json) {
    return PlaceSuggestion(
      placePrediction: PlacePrediction.fromJson(json['placePrediction']),
    );
  }
}

class SecondaryText {
  final String text;

  SecondaryText({required this.text});

  factory SecondaryText.fromJson(Map<String, dynamic> json) {
    return SecondaryText(text: json['text']);
  }
}

class StructuredFormat {
  final MainText mainText;
  final SecondaryText secondaryText;

  StructuredFormat({
    required this.mainText,
    required this.secondaryText,
  });

  factory StructuredFormat.fromJson(Map<String, dynamic> json) {
    return StructuredFormat(
      mainText: MainText.fromJson(json['mainText']),
      secondaryText: SecondaryText.fromJson(json['secondaryText']),
    );
  }
}

class TextData {
  final String text;
  final List<Match> matches;

  TextData({
    required this.text,
    required this.matches,
  });

  factory TextData.fromJson(Map<String, dynamic> json) {
    return TextData(
      text: json['text'],
      matches: (json['matches'] as List).map((e) => Match.fromJson(e)).toList(),
    );
  }
}
