import 'package:hava_durumu/services/location.dart';
import 'package:hava_durumu/services/networking.dart';

const apiKey = 'b374ed8558b1064c347109eaa7709272';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    // Hata kontrolü
    if (weatherData == null || weatherData['main'] == null) {
      throw 'Hava durumu verisi alınamadı. Lütfen şehri kontrol edin.';
    }

    return weatherData; // Bu noktada sıcaklık Celsius cinsindendir
  }


  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    // Hata kontrolü
    if (weatherData == null || weatherData['main'] == null) {
      throw 'Hava durumu verisi alınamadı. Lütfen konumunuzu kontrol edin.';
    }

    return weatherData; // Bu noktada sıcaklık Celsius cinsindendir
  }



  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'Dondurma Yeme Zamanı';
    } else if (temp > 20) {
      return 'Şort ve 👕 Zamanı';
    } else if (temp > 10) {
      return '🧥 giysen iyi olur';
    } else {
      return '🧣 ve 🧤 giyebilirsin';
    }
  }
}
