import 'package:evently_app/core/resources/colors_manager/colors_manager.dart';
import 'package:evently_app/data/DM/event_DM.dart';
import 'package:evently_app/data/firebase_services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventTitle extends StatefulWidget {
  const EventTitle({super.key, required this.event, required this.favEvent});

  final EventDm event;
  final bool favEvent;

  @override
  State<EventTitle> createState() => _EventTitleState();
}

class _EventTitleState extends State<EventTitle> {
  late bool isFavorite = widget.favEvent;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: REdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.event.title,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            IconButton(
              onPressed: favEvent,
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_outline),
              color: ColorsManager.blue,
            ),
          ],
        ),
      ),
    );
  }

  void favEvent() {
    isFavorite = !isFavorite;
    setState(() {});
    isFavorite
        ? FirebaseServices.addEventToFavorite(widget.event.id)
        : FirebaseServices.removeEventFromFavorite(widget.event.id);
  }
}
