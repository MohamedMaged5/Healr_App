import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacesModel {
  final String title;
  final String phone;
  final int distance;
  final LatLng position;
  final List<LatLng>? accessPoints;
  final String district;
  final String label;
  final String categoryName;

  PlacesModel({
    required this.title,
    required this.phone,
    required this.distance,
    required this.position,
    required this.accessPoints,
    required this.district,
    required this.label,
    required this.categoryName,
  });

  factory PlacesModel.fromJson(Map<String, dynamic> json) {
    final accessList = json['access'] as List<dynamic>?;

    return PlacesModel(
      title: json['title'] ?? '',
      phone: json['phone'] ?? 'غير متوفر',
      distance: json['distance'] ?? 0,
      position: LatLng(
        (json['position']['lat'] as num).toDouble(),
        (json['position']['lng'] as num).toDouble(),
      ),
      accessPoints: accessList?.map((e) {
              final lat = (e['lat'] as num?)?.toDouble();
              final lng = (e['lng'] as num?)?.toDouble();
              if (lat != null && lng != null) {
                return LatLng(lat, lng);
              }
              return null;
            }).whereType<LatLng>().toList(),
      district: json['district'] ?? '',
      label: json['label'] ?? '',
      categoryName: json['categoryName'] ?? '',
    );
  }
}
