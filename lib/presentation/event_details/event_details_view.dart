import 'package:evently_app/core/extensions/date_extensions.dart';
import 'package:evently_app/core/resources/colors_manager/colors_manager.dart';
import 'package:evently_app/core/resources/dialog_utils.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/data/DM/event_DM.dart';
import 'package:evently_app/data/DM/user_DM.dart';
import 'package:evently_app/data/firebase_services/firebase_services.dart';
import 'package:evently_app/presentation/event_details/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocode/geocode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventDetailsView extends StatefulWidget {
  const EventDetailsView({super.key, required this.event});

  final EventDm event;

  @override
  State<EventDetailsView> createState() => _EventDetailsViewState();
}

class _EventDetailsViewState extends State<EventDetailsView> {
  String address = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    concertLocationToAddress();
  }

  concertLocationToAddress() async {
    GeoCode geoCode = GeoCode();

    var response = await geoCode.reverseGeocoding(
      latitude: widget.event.lat!,
      longitude: widget.event.lng!,
    );

    print(response.city);
    setState(() {
      address = "${response.city}, ${response.countryName}";
    });
    print(address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Details"),
        actions:
            widget.event.userId == UserDm.currentUser!.id
                ? [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RoutesManager.createEvent,
                        arguments: widget.event,
                      );
                    },
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      deleteEvent();
                    },
                    icon: Icon(Icons.delete, color: ColorsManager.red),
                  ),
                ]
                : [],
      ),
      body: ListView(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.asset(widget.event.category.imagePath),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            widget.event.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 16.h),
          CustomContainer(
            icon: Icons.calendar_month,
            secondPart: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.event.dateTime.day} ${widget.event.dateTime.getMonthFormDateTime} ${widget.event.dateTime.year}",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: ColorsManager.blue),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.event.dateTime.getTimeFormatted,
                  style: Theme.of(context).textTheme.bodySmall!,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          CustomContainer(
            icon: Icons.gps_fixed,
            secondPart: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 8,
                  child: Text(
                    address,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall!.copyWith(color: ColorsManager.blue),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: ColorsManager.blue),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            height: 200.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),

              border: Border.all(color: ColorsManager.blue),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: GoogleMap(
                rotateGesturesEnabled: false,
                zoomGesturesEnabled: false,
                scrollGesturesEnabled: false,
                tiltGesturesEnabled: false,
                markers: {
                  Marker(
                    markerId: MarkerId("1"),
                    position: LatLng(widget.event.lat!, widget.event.lng!),
                  ),
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.event.lat!, widget.event.lng!),
                  zoom: 16,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text("Description", style: Theme.of(context).textTheme.bodySmall),
          SizedBox(height: 16.h),
          Text(
            widget.event.description,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  deleteEvent() async {
    DialogUtils.showLoadingDialog("Loading..", context);
    await FirebaseServices.deleteEvent(widget.event.id);
    DialogUtils.hideDialog(context);
    DialogUtils.showMessageDialog(
      context,
      message: "Are you sure you want to delete this event",
      posActionTitle: "Yes",
      posAction: () {
        Navigator.pushNamed(context, RoutesManager.mainLayout);
      },
      negActionTitle: "No",
    );
  }
}
