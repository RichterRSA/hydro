import 'package:http/http.dart' as http;
import 'dart:convert';

const properties = {
  "temperature",
  "humidity",
  "ec",
  "ph",
  "powerCons",
  "waterFlow",
  "tankLevel",
};

enum ReadingType {
  current,
  historical,
  startEnd,
}

Future<String> getReading() async {
  final response = await http.get(
      Uri.parse('https://48f7-102-65-70-40.in.ngrok.io/tankLevel_current'));
  if (response.statusCode == 200) {
    return json.decode(response.body).toString();
  } else {
    throw Exception('Failed to load data');
  }
}
