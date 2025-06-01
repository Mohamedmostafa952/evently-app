import 'package:evently_app/core/resources/colors_manager/colors_manager.dart';
import 'package:evently_app/data/DM/event_DM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventMapItem extends StatelessWidget {
  const EventMapItem({super.key, required this.event});

  final EventDm event;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(8),
      margin: REdgeInsets.symmetric(horizontal: 8.0, vertical: 24),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Image.asset(event.category.imagePath, fit: BoxFit.cover),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Text(
                    event.description,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        "${event.lat}, ${event.lng}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
