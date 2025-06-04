import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/core/resources/constants_manager.dart';
import 'package:evently_app/data/DM/category_DM.dart';

class EventDm {
  String id;
  final CategoryDM category;
  final String title;
  final String description;
  final DateTime dateTime;
  final double? lat;
  final double? lng;
  final String userId;

  EventDm({
    this.id = "",
    required this.userId,
    required this.category,
    required this.title,
    required this.description,
    required this.dateTime,
    this.lat = 0,
    this.lng = 0,
  });

  // used when receiving date
  // receive category id so we can get its category object
  EventDm.fromJson(Map<String, dynamic> json)
      : this(
    id: json["id"],
    userId: json["userId"],
    title: json["title"],
    description: json["description"],
    dateTime: (json["dateTime"] as Timestamp).toDate(),
    category: ConstantsManager.categoriesWithoutAll.firstWhere(
          (category) => category.id == json["categoryID"],
    ),
    lat: json["lat"] ?? 0,
    lng: json["lng"] ?? 0,
  );

  // convert object to json
  // used when sending data
  // send category id that represents it category object
  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "title": title,
        "description": description,
        "categoryID": category.id,
        "dateTime": Timestamp.fromDate(dateTime),
        "lat": lat,
        "lang": lng,
        "userId": userId
      };
}
