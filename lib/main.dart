import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather/configure.dart';
import 'package:weather/presentation/weather/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  configureDependencies();
  runApp(
    const MyApp(
      child: WeatherScreen(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget child;

  const MyApp({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: child);
  }
}
