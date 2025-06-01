import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectedLocationProvider extends ChangeNotifier {
  CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(37.43296265331129, -122.08832357078792),
    zoom: 19.151926040649414,
  );

  Set<Marker> markers = {
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(37.43296265331129, -122.08832357078792),
      infoWindow: InfoWindow(title: "MY location"),
    ),
  };

  late GoogleMapController mapController;

  goToLocation(LatLng location) {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(location.latitude, location.longitude),
          zoom: 17,
        ),
      ),
    );
    markers = {
      Marker(
        markerId: MarkerId("1"),
        position: LatLng(location.latitude, location.longitude),
        infoWindow: InfoWindow(title: "MY location"),
      ),
    };
    notifyListeners();
  }

  LatLng? selectedLocation;

  changeSelectedLocation(LatLng location) {
    selectedLocation = location;
    goToLocation(location);
    notifyListeners();
  }
}
