import 'package:weather/api/dio_client.dart';
import 'package:weather/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@injectable
class WeatherRepository {
  final DioClient dioClient;

  WeatherRepository({required this.dioClient});

  Future<Response?> getData({required Position position}) async {
    try {
      final response = await dioClient.get(Endpoints.forecast,
          queryParameters: {
            "lat": position.latitude,
            "lon": position.longitude
          });
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
