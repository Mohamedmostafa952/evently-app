class UserDm {
  static UserDm? currentUser;
  String name;
  List<String> eventsIds;
  String id;
  String email;
  List<String> favEventsIds;

  UserDm({
    required this.name,
    this.eventsIds = const [],
    required this.email,
    required this.id,
    required this.favEventsIds,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "eventsIds": eventsIds,
    "email": email,
    "name": name,
    "favEventsIds": favEventsIds,
  };

  UserDm.fromJson(Map<String, dynamic> json)
    : this(
        id: json["id"],
        eventsIds:
            (json["eventsIds"] as List<dynamic>)
                .map((item) => item.toString())
                .toList(),
        email: json["email"],
        name: json["name"],
        favEventsIds:
            (json['favEventsIds'] as List<dynamic>)
                .map((item) => item.toString())
                .toList(),
      );
}
