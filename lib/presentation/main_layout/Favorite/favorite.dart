import 'package:evently_app/core/resources/colors_manager/colors_manager.dart';
import 'package:evently_app/core/widgets/custom_event.dart';
import 'package:evently_app/data/DM/event_DM.dart';
import 'package:evently_app/data/DM/user_DM.dart';
import 'package:evently_app/data/firebase_services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  String searchKey = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          buildSearchTextField(),
          FutureBuilder(
            future: FirebaseServices.getEvents(),
            builder: (context, snapshot) {
              List<EventDm> events = snapshot.data ?? [];
              List<EventDm> favEvents =
              events
                  .where(
                    (event) =>
                    UserDm.currentUser!.favEventsIds.contains(event.id),
              )
                  .toList();
              List<EventDm> filteredList = favEvents;
              filteredList = filteredList
                  .where(
                    (event) =>
                event.title.toLowerCase().contains(searchKey) ||
                    event.title.contains(searchKey),
              )
                  .toList();
              return Expanded(
                child: ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder:
                      (context, index) =>
                      CustomEvent(event: filteredList[index], favEvent: true),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildSearchTextField() {
    return Padding(
      padding: REdgeInsets.all(16),
      child: TextField(
        onChanged: (inputValue) {
          setState(() {
            searchKey = inputValue;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: ColorsManager.blue),
          labelText: "Search for Event",
          labelStyle: Theme
              .of(context)
              .textTheme
              .labelMedium,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(color: ColorsManager.blue, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(color: ColorsManager.blue, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(color: ColorsManager.blue, width: 1),
          ),
        ),
      ),
    );
  }
}
