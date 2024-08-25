import 'package:weather/models/weather_model.dart';
import 'package:weather/presentation/weather/bloc/weather_bloc.dart';
import 'package:weather/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Weather", style: TextStyle(color: Colors.white)),
      ),
      body: BlocProvider(
        create: (context) => GetIt.I<WeatherBloc>()..add(LoadWeatherData()),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            switch (state.loadingStatus) {
              case Status.init:
              case Status.progress:
                return const Center(child: CircularProgressIndicator());
              case Status.error:
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    state.error,
                    textAlign: TextAlign.center,
                  ),
                ));
              case Status.done:
                return WeatherBody(
                  weatherModel: state.weatherModel,
                );
            }
          },
        ),
      ),
    );
  }
}

class WeatherBody extends StatelessWidget {
  final WeatherModel? weatherModel;

  const WeatherBody({super.key, this.weatherModel});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      itemBuilder: (context, index) {
        final WeatherData weather = weatherModel!.weatherData![index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  offset: const Offset(0, 3),
                  spreadRadius: 3,
                  blurRadius: 8,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Date: ${DateFormat("E, dd MMM").format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(weather.date ?? ""))}"),
              Text("City: ${weatherModel?.city?.name ?? ""}"),
              Text("Temperature: ${weather.main?.temp ?? 0.0}"),
              Text("Pressure: ${weather.main?.pressure ?? 0.0}"),
              Text("Visibility: ${weather.visibility ?? 0.0}"),
              Text("Wind Speed: ${weather.wind?.speed ?? 0.0} km/h"),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: (weatherModel?.weatherData ?? []).length,
    );
  }
}
