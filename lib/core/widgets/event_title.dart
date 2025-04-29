import 'package:evently_app/core/resources/colors_manager/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventTitle extends StatelessWidget {
  const EventTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: REdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(title, style: Theme
                  .of(context)
                  .textTheme
                  .labelSmall),
            ),
            Icon(Icons.favorite_outline_sharp, color: ColorsManager.blue,),
          ],
        ),
      ),
    );
  }
}
