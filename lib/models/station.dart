import 'package:flutter/material.dart';

class Station {
  String name;
  String id;
  String genre;
  String logo;

  Station({@required this.genre, @required this.logo, @required this.name, @required this.id});

  static Station fromJson(Map<String, dynamic> json) {
    return Station(name: json["name"] ?? "", id: "${json["id"]}", logo: json["logo"] ?? 'https://res.cloudinary.com/jesse-dirisu/image/upload/v1577453507/marconixl.png', genre: json["genre"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "logo": logo,
      "id": id,
      "genre": genre,
    };
  }
}
