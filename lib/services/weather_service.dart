import 'package:weather/repository/weather_repository.dart';
import 'package:weather/models/weather_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

abstract class WeatherService {
  Future<WeatherModel?> getData({required Position position});
}

@Injectable(as: WeatherService)
class WeatherServiceImpl implements WeatherService {
  final WeatherRepository weatherRepository;

  WeatherServiceImpl(this.weatherRepository);

  @override
  Future<WeatherModel?> getData({required Position position}) async {
    try {
      final res = await weatherRepository.getData(position: position);
      if (res != null) {
        return WeatherModel.fromJson(res.data);
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
