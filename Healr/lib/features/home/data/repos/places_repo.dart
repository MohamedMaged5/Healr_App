import 'package:dio/dio.dart';
import 'package:healr/features/home/data/models/places_model/places_model.dart';

class PlacesRepo {
  final Dio dio;

  PlacesRepo({required this.dio});

  Future<List<PlacesModel>> getNearbyHospitals({
    required double lat,
    required double lng,
  }) async {
    try {
      final response = await dio.get(
        'https://healer-tau.vercel.app/doctor/hospital',
        queryParameters: {
          'lat': lat,
          'lng': lng,
        },
      );

      final data = response.data['data'] as List;
      return data.map((e) => PlacesModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('فشل في تحميل البيانات: $e');
    }
  }
}
