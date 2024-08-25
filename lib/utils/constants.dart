class Endpoints {
  Endpoints._();

  static const String baseUrl = "https://api.openweathermap.org/data/2.5";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;

  static const String forecast = '/forecast';
}
