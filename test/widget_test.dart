// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:weather/main.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/presentation/weather/weather_screen.dart';

void main() {
  testWidgets('Weather list test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MyApp(
        child: WeatherBody(
          weatherModel: WeatherModel(
            weatherData: [
              WeatherData(
                  //Remove date if you want to fail the widget test
                  date: "2024-08-24 09:00:00",
                  main: Main(
                    pressure: 1,
                    temp: 1,
                  ),
                  visibility: 1,
                  wind: Wind(speed: 1))
            ],
            city: City(name: "Surat"),
          ),
        ),
      ),
    );
  });
}
