import 'package:flutter/material.dart';

class EventDm {
  final String category;
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay time;
  final int? lat;
  final int? lng;

  EventDm({
    required this.category,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    this.lat,
    this.lng,
  });
}
