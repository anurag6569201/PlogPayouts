import 'package:flutter/material.dart';

class Category {
  Category(
      {required this.id,
      required this.title,
      required this.color,
      required this.coordinates});

  String id;
  String title;
  Color color;
  List<double> coordinates;
}
