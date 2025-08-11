// import 'dart:html_common';

Future<String> fetchWeather(String city) async {
  if (city.isEmpty){
    throw Exception('City cannot be empty');
  }
  print('Fetching weather for $city');
  await Future.delayed(const Duration(seconds: 2));
  return '$city: 15C, Partly Cloudy';
}
/*
IMP: Should have made the main class async by itself. It is more idomatic and simplifies the structure.
Future<void> main() async {
  List<String> cities = ['London', 'Mumbai', '', 'Surat'];
  for (String city in cities) {
    try {
      String weather = await fetchWeather(city);
      print(weather);
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }
}
*/
void main(){
  List<String> cities = ['London', 'Mumbai', '', 'Surat'];

  void getWeather(List<String> cities) async {
    for(String city in cities){
      try {
      String weather = await fetchWeather(city);
      print('$weather');
      } catch (e) {
        print('Error catchng weather: $e');
      } 
      
    }
  }

  getWeather(cities);
}