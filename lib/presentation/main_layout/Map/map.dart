import 'package:evently_app/core/resources/constants_manager.dart';
import 'package:evently_app/data/DM/event_DM.dart';
import 'package:evently_app/data/firebase_services/firebase_services.dart';
import 'package:evently_app/presentation/main_layout/Map/widgets/event_map_item.dart';
import 'package:evently_app/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  late LocationProvider locationProvider;

  @override
  void initState() {
    // TODO: implement initState
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
    // locationProvider.getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    locationProvider = Provider.of<LocationProvider>(context);

    return Consumer<LocationProvider>(
      builder: (context, provider, child) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              onMapCreated: (controller) {
                provider.mapController = controller;
              },
              initialCameraPosition: provider.initialCameraPosition,
              mapType: MapType.normal,
              markers: provider.markers,
            ),
            SizedBox(
              height: 125.h,
              child: StreamBuilder(
                stream: FirebaseServices.getEventsRealtimeUpdates(
                  ConstantsManager.categories[0],
                ),
                // returns data based category id, ex if its 2 then it will return data with id=2
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    print("error");
                  }

                  List<EventDm> events = snapshot.data ?? [];
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: events.length,
                    itemBuilder:
                        (context, index) =>
                        SizedBox(
                          width: 300.w,
                          child: InkWell(
                              onTap: () {
                                provider.goToLocation(LatLng(
                                    events[index].lat ?? 0,
                                    events[index].lng ?? 0));
                              },
                              child: EventMapItem(event: events[index])),
                        ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
