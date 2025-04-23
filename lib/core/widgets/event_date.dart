import 'package:evently_app/core/extensions/date_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDate extends StatelessWidget {
  const EventDate({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: REdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              date.day.toString(),
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text(
              date.getMonthFormDateTime,
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.copyWith(fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}
