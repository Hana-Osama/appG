import 'dart:convert';
import 'package:http/http.dart' as http;

// Function to fetch governorate data
Future<Map<String, dynamic>?> fetchGovernorateData(
    String selectedGovernorate) async {
  final url = Uri.parse(
      'http://muddy-carolyne-kanzo-399c5b8f.koyeb.app/Governorate/$selectedGovernorate');

  try {
    final response = await http.get(url);

    // Check if the response is successful (status code 200)
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data; // Return the fetched data
    } else {
      print('Failed to load data: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error fetching data: $e');
    return null;
  }
}
