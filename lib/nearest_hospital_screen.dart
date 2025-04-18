/*import 'package:flutter/material.dart';
import 'package:flutter_application_1/GovernorateMapsPage.dart';
/*import 'package:url_launcher/url_launcher.dart';*/

class NearestHospitalPage extends StatefulWidget {
  @override
  _NearestHospitalPageState createState() => _NearestHospitalPageState();
}

class _NearestHospitalPageState extends State<NearestHospitalPage> {
  final List<String> governorates = [
    "Cairo",
    "El-giza",
    "Alexandria",
    "El-behara",
    "Matroh",
    "El-monofyah",
    "El-daqahlya",
    "Kafr-elshekh",
    "El-gharbia",
    "Domyat",
    "El-sharqya",
    "Esmailya",
    "Port said",
    "Suez",
    "North sinai",
    "South sinai",
    "Red sea",
    "Fayoum",
    "Bani-suef",
    "New valley",
    "Assiut",
    "Sohag",
    "Qena",
    "Luxor",
    "Aswan",
    "Minya"
  ];

  String? selectedGovernorate;
  void _openGovernoratePage() {
    if (selectedGovernorate != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              GovernorateMapPage(governorate: selectedGovernorate!),
        ),
      );
    }
  }

  /* void _openGovernoratePage() {
    if (selectedGovernorate != null) {
      final url =
          "http://muddy-carolyne-kanzo-399c5b8f.koyeb.app/Governorate/$selectedGovernorate";
      launchUrl(Uri.parse(url));
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5A6B81),
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/hospital.jpg', // Make sure this file exists
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black.withOpacity(0.3), Colors.transparent],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF3C4D5B),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Select Governorate",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Dropdown Menu
                  DropdownButton<String>(
                    value: selectedGovernorate,
                    dropdownColor: Colors.grey[800],
                    hint: Text("Choose a governorate",
                        style: TextStyle(color: Colors.white)),
                    icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    items: governorates.map((String governorate) {
                      return DropdownMenuItem<String>(
                        value: governorate,
                        child: Text(governorate,
                            style: TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGovernorate = newValue;
                      });
                    },
                  ),
                  SizedBox(height: 30),
                  // Button to Open the Link
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: selectedGovernorate == null
                          ? null
                          : _openGovernoratePage,
                      child: Text(
                        "Get Information",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}    */
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/governorate_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_1/governorate_info_page.dart';

class NearestHospitalPage extends StatefulWidget {
  @override
  _NearestHospitalPageState createState() => _NearestHospitalPageState();
}

class _NearestHospitalPageState extends State<NearestHospitalPage> {
  final List<String> governorates = [
    "Cairo",
    "El-giza",
    "Alexandria",
    "El-behara",
    "Matroh",
    "El-monofyah",
    "El-daqahlya",
    "Kafr-elshekh",
    "El-gharbia",
    "Domyat",
    "El-sharqya",
    "Esmailya",
    "Port said",
    "Suez",
    "North sinai",
    "South sinai",
    "Red sea",
    "Fayoum",
    "Bani-suef",
    "New valley",
    "Assiut",
    "Sohag",
    "Qena",
    "Luxor",
    "Aswan",
    "Minya"
  ];

  String? selectedGovernorate;
  bool isLoading = false;

  Future<void> _getGovernorateData() async {
    if (selectedGovernorate == null) return;

    setState(() {
      isLoading = true;
    });

    final url =
        "http://muddy-carolyne-kanzo-399c5b8f.koyeb.app/Governorate/$selectedGovernorate";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Navigate to new page with fetched data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GovernorateInfoPage(
              name: data['name'] ?? selectedGovernorate!,
              population: data['population'],
              area: data['area'],
              description: data['description'],
              latitude: data['latitude'],
              longitude: data['longitude'],
            ),
          ),
        );
      } else {
        _showError("Failed to load data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      _showError("Error occurred: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5A6B81),
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/hospital.jpg',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.black26,
                  height: 200,
                  alignment: Alignment.center,
                  child: Text('Image not found',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black.withOpacity(0.3), Colors.transparent],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF3C4D5B),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Select Governorate",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  DropdownButton<String>(
                    value: selectedGovernorate,
                    dropdownColor: Colors.grey[800],
                    hint: Text("Choose a governorate",
                        style: TextStyle(color: Colors.white)),
                    icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    items: governorates.map((String governorate) {
                      return DropdownMenuItem<String>(
                        value: governorate,
                        child: Text(governorate,
                            style: TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGovernorate = newValue;
                      });
                    },
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: selectedGovernorate == null || isLoading
                          ? null
                          : _getGovernorateData,
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              "Get Information",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
