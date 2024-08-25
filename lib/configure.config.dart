// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:weather/api/dio_client.dart' as _i23;
import 'package:weather/presentation/weather/bloc/weather_bloc.dart' as _i66;
import 'package:weather/repository/weather_repository.dart' as _i365;
import 'package:weather/services/weather_service.dart' as _i477;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i365.WeatherRepository>(
        () => _i365.WeatherRepository(dioClient: gh<_i23.DioClient>()));
    gh.factory<_i477.WeatherService>(
        () => _i477.WeatherServiceImpl(gh<_i365.WeatherRepository>()));
    gh.factory<_i66.WeatherBloc>(
        () => _i66.WeatherBloc(gh<_i477.WeatherService>()));
    return this;
  }
}
