import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationProvider extends ChangeNotifier {
  Location location = Location();
  String locationMessage = "check location";

  getLocation() async {
    bool isLocationPermissionEnabled = await checkPermission();

    if (!isLocationPermissionEnabled) {
      locationMessage = "Check permission denied";
      notifyListeners();
      return;
    }

    bool isServiceEnabled = await checkServiceEnabled();

    if (!isServiceEnabled) {
      locationMessage = "Check service denied";
      notifyListeners();
      return;
    }

    LocationData myLocation = await location.getLocation();

    goToLocation(LatLng(myLocation.latitude ?? 0, myLocation.longitude ?? 0));
  }

  Future<bool> checkPermission() async {
    PermissionStatus permissionStatus = await location.hasPermission();

    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }

    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> checkServiceEnabled() async {
    bool isServiceEnabled = await location.serviceEnabled();

    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
    }

    return isServiceEnabled;
  }

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

  streamLocation() {
    location.onLocationChanged.listen((location) {
      goToLocation(LatLng(location.latitude ?? 0, location.longitude ?? 0));
    });
  }
}
