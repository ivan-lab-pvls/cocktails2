import 'package:flutter/material.dart';

class Cocktail {
  String? name;
  String? description1;
  String? description2;
  String? compound;
  String? photo;
  bool? isLiked;
  DateTime? date;
  double? rating;

  Cocktail(
      {this.name,
      this.description1,
      this.compound,
      this.description2,
      this.photo,
      this.isLiked,
      this.date,
      this.rating});
  factory Cocktail.fromJson(Map<String, dynamic> parsedJson) {
    return Cocktail(
      name: parsedJson['name'] ?? "",
      description1: parsedJson['description1'] ?? "",
      description2: parsedJson['description2'] ?? "",
      compound: parsedJson['compound'] ?? "",
      photo: parsedJson['photo'] ?? "",
      isLiked: parsedJson['isLiked'],
      date: DateTime.tryParse(parsedJson['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      "description1": description1,
      "description2": description2,
      'compound': compound,
      'photo': photo,
      'isLiked': isLiked,
      'date': date.toString()
    };
  }
}
