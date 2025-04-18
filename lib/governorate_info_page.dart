import 'package:flutter/material.dart';

class GovernorateInfoPage extends StatelessWidget {
  final String name;
  final String population;
  final String area;
  final String description;
  final double latitude;
  final double longitude;

  const GovernorateInfoPage({
    required this.name,
    required this.population,
    required this.area,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Population: $population", style: TextStyle(fontSize: 18)),
            Text("Area: $area", style: TextStyle(fontSize: 18)),
            Text("Latitude: $latitude", style: TextStyle(fontSize: 18)),
            Text("Longitude: $longitude", style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text("Description:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(description, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
