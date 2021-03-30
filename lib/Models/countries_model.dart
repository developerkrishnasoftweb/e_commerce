class Countries {
  String id,
      twoLetterAbbreviation,
      threeLetterAbbreviation,
      fullNameLocale,
      fullNameEnglish;
  List<Regions> availableRegions;

  Countries(
      {this.id,
      this.twoLetterAbbreviation,
      this.threeLetterAbbreviation,
      this.fullNameLocale,
      this.fullNameEnglish,
      this.availableRegions});

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    twoLetterAbbreviation = json['two_letter_abbreviation'];
    threeLetterAbbreviation = json['three_letter_abbreviation'];
    fullNameLocale = json['full_name_locale'];
    fullNameEnglish = json['full_name_english'];
    if (json['available_regions'] != null) {
      availableRegions = new List<Regions>();
      json['available_regions'].forEach((v) {
        availableRegions.add(new Regions.fromJson(v));
      });
    }
  }
}

class Regions {
  String id, code, name;

  Regions({this.id, this.code, this.name});

  Regions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
  }
}
