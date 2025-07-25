import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  static Position? currentPosition;
  static bool? _permissionStatus;

  // Request permission once on app start
  static Future<bool> requestPermissionOnce() async {
    if (_permissionStatus != null) {
      return _permissionStatus!;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log('Location permission denied');
        _permissionStatus = false;
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      log('Location permission permanently denied');
      _permissionStatus = false;
      return false;
    }

    _permissionStatus = true;
    return true;
  }

  // Check if permission is granted
  static bool isPermissionGranted() {
    return _permissionStatus == true;
  }

  // Get current location (only if permission is granted)
  static Future<Position?> getCurrentLocation() async {
    if (!isPermissionGranted()) {
      log('Location permission not granted');
      return null;
    }

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log('Location service is disabled');
      await Geolocator.openLocationSettings();

      for (int i = 0; i < 5; i++) {
        await Future.delayed(const Duration(seconds: 1));
        if (await Geolocator.isLocationServiceEnabled()) {
          log('✅ GPS is now enabled');
          break;
        }
      }

      if (!await Geolocator.isLocationServiceEnabled()) {
        log('❌ Still disabled after retry');
        return null;
      }
    }

    currentPosition = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    log('Current location: ${currentPosition?.longitude}, ${currentPosition?.latitude}');
    return currentPosition;
  }

  static Future<void> moveToUserLocation(
      BuildContext context, GoogleMapController mapController) async {
    final position = await getCurrentLocation();
    if (position != null) {
      final userLatLng = LatLng(position.latitude, position.longitude);
      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(userLatLng, 16),
      );
    }
  }
}
