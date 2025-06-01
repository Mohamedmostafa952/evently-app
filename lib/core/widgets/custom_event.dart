import 'package:evently_app/core/resources/colors_manager/colors_manager.dart';
import 'package:evently_app/core/widgets/event_date.dart';
import 'package:evently_app/core/widgets/event_title.dart';
import 'package:evently_app/data/DM/event_DM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomEvent extends StatelessWidget {
  const CustomEvent({super.key, required this.event, required this.favEvent});

  final EventDm event;
  final bool favEvent;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.all(16),
      width: double.infinity,
      height: 203.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorsManager.blue, width: 1),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(event.category.imagePath),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EventDate(date: event.dateTime),
          Spacer(),
          EventTitle(event: event, favEvent: favEvent,),
        ],
      ),
    );
  }
}
