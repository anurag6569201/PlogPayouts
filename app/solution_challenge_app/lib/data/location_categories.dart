import 'package:flutter/material.dart';

class Category {
  Category(
      {required this.Id,
      required this.title,
      required this.color,
      required this.coordinates,
      required this.imageUrl,
      required this.uuid,
      required this.distance});

  String Id;
  String title;
  Color color;
  List<double> coordinates;
  String imageUrl;
  String uuid;

  double distance;
}
