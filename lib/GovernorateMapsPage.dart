import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GovernorateMapPage extends StatefulWidget {
  final String governorate;

  GovernorateMapPage({required this.governorate});

  @override
  _GovernorateMapPageState createState() => _GovernorateMapPageState();
}

class _GovernorateMapPageState extends State<GovernorateMapPage> {
  late GoogleMapController mapController;
  Set<Marker> _markers = {};
  bool _isLoading = true;

  Future<void> fetchGovernorateData() async {
    final url =
        "http://muddy-carolyne-kanzo-399c5b8f.koyeb.app/Governorate/${widget.governorate}";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        double latitude = data['latitude'];
        double longitude = data['longitude'];

        setState(() {
          _markers.add(Marker(
            markerId: MarkerId(widget.governorate),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(title: widget.governorate),
          ));
          _isLoading = false;
        });

        mapController
            .moveCamera(CameraUpdate.newLatLng(LatLng(latitude, longitude)));
      } else {
        throw Exception('Failed to load governorate data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchGovernorateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.governorate)),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: (controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(0.0, 0.0), // Set a default position
                zoom: 6.0,
              ),
              markers: _markers,
            ),
    );
  }
}
