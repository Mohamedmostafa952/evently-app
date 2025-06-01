import 'package:evently_app/core/resources/colors_manager/colors_manager.dart';
import 'package:evently_app/presentation/create_event/providers/selected_location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SelectedLocation extends StatelessWidget {
  const SelectedLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SelectedLocationProvider(),
      child: Consumer<SelectedLocationProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: provider.initialCameraPosition,
                    markers: provider.markers,
                    onMapCreated: (controller) {
                      provider.mapController = controller;
                    },
                    onTap: (LatLng latLng) {
                      provider.changeSelectedLocation(latLng);
                      Navigator.pop(context, provider.selectedLocation);
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: REdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(color: ColorsManager.blue),
                  child: Text(
                    "Tap on Location To Select",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
