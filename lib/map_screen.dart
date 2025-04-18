import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/nearest_hospital_screen.dart';
import 'package:flutter_application_1/photo_guidelines_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  final String selectedGovernorate;

  MapScreen({required this.selectedGovernorate});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LatLng _center;
  late GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
    _fetchGovernorateData();
  }

  Future<void> _fetchGovernorateData() async {
    final url = Uri.parse(
        'http://muddy-carolyne-kanzo-399c5b8f.koyeb.app/Governorate/${widget.selectedGovernorate}');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final lat = data['latitude']; // Assuming the response contains latitude
        final lng =
            data['longitude']; // Assuming the response contains longitude
        setState(() {
          _center = LatLng(lat, lng);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      // Handle any errors, maybe show a message or fallback position
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Governorate Location'),
      ),
      body: _center != null
          ? GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 12,
              ),
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              markers: {
                Marker(
                  markerId: MarkerId('govLocation'),
                  position: _center,
                  infoWindow: InfoWindow(title: widget.selectedGovernorate),
                ),
              },
            )
          : Center(
              child: CircularProgressIndicator()), // Show loading indicator
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5A6B81),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Image.asset(
                'assets/start.png',
                height: 180,
              ),
              SizedBox(height: 40),
              CustomButton(
                text: "Start",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhotographyGuidelinesPage(),
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              CustomButton(
                text: "Nearest Hospital",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NearestHospitalPage(),
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              CustomButton(
                text: "View on Map",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(
                        selectedGovernorate:
                            'Cairo', // Pass the selected governorate here
                      ),
                    ),
                  );
                },
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
