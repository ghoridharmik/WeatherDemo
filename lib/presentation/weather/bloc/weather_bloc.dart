import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weather/api/dio_client.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/weather_service.dart';
import 'package:weather/utils/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

part 'weather_bloc.freezed.dart';
part 'weather_bloc.g.dart';

@injectable
class WeatherBloc extends HydratedBloc<WeatherEvent, WeatherState> {
  final WeatherService weatherService;

  WeatherBloc(this.weatherService) : super(const WeatherState()) {
    on<LoadWeatherData>((event, emit) async {
      try {
        if (!(await hasInternet())) {
          return;
        }
        emit(state.copyWith(loadingStatus: Status.progress));
        final Position position = await _determinePosition();
        final WeatherModel? weatherModel =
            await weatherService.getData(position: position);
        emit(state.copyWith(
            loadingStatus: Status.done, weatherModel: weatherModel));
      } catch (e) {
        emit(state.copyWith(loadingStatus: Status.error, error: e.toString()));
        return;
      }
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  WeatherState? fromJson(Map<String, dynamic> json) {
    return WeatherState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(WeatherState state) {
    return state.toJson();
  }
}

@freezed
@JsonSerializable()
class WeatherState with _$WeatherState {
  const WeatherState._();
  const factory WeatherState({
    @Default(Status.init) Status loadingStatus,
    @Default(null) WeatherModel? weatherModel,
    @Default("") String error,
  }) = _WeatherState;

  Map<String, dynamic> toJson() {
    return _$WeatherStateToJson(this);
  }

  factory WeatherState.fromJson(Map<String, dynamic> json) {
    return _$WeatherStateFromJson(json);
  }
}

sealed class WeatherEvent {}

class LoadWeatherData extends WeatherEvent {}
