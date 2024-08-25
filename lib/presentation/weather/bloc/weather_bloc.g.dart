// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherState _$WeatherStateFromJson(Map<String, dynamic> json) => WeatherState(
      loadingStatus: $enumDecode(_$StatusEnumMap, json['loadingStatus']),
      weatherModel: json['weatherModel'] == null
          ? null
          : WeatherModel.fromJson(json['weatherModel'] as Map<String, dynamic>),
      error: json['error'] as String,
    );

Map<String, dynamic> _$WeatherStateToJson(WeatherState instance) =>
    <String, dynamic>{
      'loadingStatus': _$StatusEnumMap[instance.loadingStatus]!,
      'weatherModel': instance.weatherModel,
      'error': instance.error,
    };

const _$StatusEnumMap = {
  Status.init: 'init',
  Status.progress: 'progress',
  Status.error: 'error',
  Status.done: 'done',
};
