import 'package:weather/api/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'configure.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
configureDependencies() async {
  getIt.init();
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));
}
