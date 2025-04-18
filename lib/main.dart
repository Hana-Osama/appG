import 'package:flutter/material.dart';
import 'package:flutter_application_1/nearest_hospital_screen.dart';
import 'photo_guidelines_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'api_service.dart';
import 'burn_degree_predictor.dart';

void main() {
  runApp(BurnSkinApp());
}

class BurnSkinApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedGovernorate = "Cairo"; // Default to Cairo

  // Function to fetch data and navigate to the map screen
  void _fetchDataAndNavigate() async {
    try {
      final data = await fetchGovernorateData(selectedGovernorate);

      print("API Response: $data"); // Debugging: Print API response

      if (data != null) {
        final latitude = data['latitude'];
        final longitude = data['longitude'];

        print(
            "Latitude: $latitude, Longitude: $longitude"); // Debugging: Print latitude and longitude

        if (latitude != null && longitude != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MapScreen(latitude: latitude, longitude: longitude),
            ),
          );
        } else {
          print('Location data not available');
        }
      } else {
        print('No data returned from API');
      }
    } catch (e) {
      print("Error fetching data: $e"); // Debugging: Catch any errors
    }
  }

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
                text: "Scan",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScanScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              CustomButton(
                text: "Upload",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UploadScreen(),
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
                onPressed: _fetchDataAndNavigate,
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

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  File? _image;
  final predictor = BurnDegreePredictor();
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    predictor.loadModel();
  }

  Future<void> _scanImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      String result = await predictor.predictBurnDegree(_image!);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ResultScreen(result: result, image: _image!)),
      );
    }
  }

  @override
  void dispose() {
    predictor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? const Icon(Icons.camera_alt, size: 100)
                : Image.file(_image!, height: 200),
            const SizedBox(height: 20),
            CustomButton(onPressed: _scanImage, text: 'Capture Image'),
          ],
        ),
      ),
    );
  }
}

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? _image;
  final predictor = BurnDegreePredictor();
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    predictor.loadModel();
  }

  Future<void> _uploadImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      String result = await predictor.predictBurnDegree(_image!);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ResultScreen(result: result, image: _image!)),
      );
    }
  }

  @override
  void dispose() {
    predictor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? const Icon(Icons.upload, size: 100)
                : Image.file(_image!, height: 200),
            const SizedBox(height: 20),
            CustomButton(onPressed: _uploadImage, text: 'Upload Image'),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final String result;
  final File image;

  const ResultScreen({super.key, required this.result, required this.image});

  String _getCareInstructions(String result) {
    switch (result) {
      case 'Normal Skin':
        return 'No treatment needed.';
      case 'First-Degree Burn':
        return '1. Rinse with cool water for 10-15 minutes (not ice).\n2. Apply aloe vera or a burn ointment.\n3. Cover with a sterile cloth if needed.';
      case 'Second-Degree Burn':
        return '1. Rinse with cool water for 15 minutes.\n2. Apply a sterile bandage.\n3. Consult a doctor if blisters or pain worsen.';
      case 'Third-Degree Burn':
        return '1. Call emergency services immediately.\n2. Do not apply ointments or remove clothes stuck to burn.\n3. Elevate and cover with a clean cloth.';
      default:
        return 'Unknown condition.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(image, height: 200),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('RESULT',
                        style: Theme.of(context).textTheme.headlineSmall),
                    Text(result, style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    Text(_getCareInstructions(result),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: () => Navigator.pop(context),
              text: 'Back',
            ),
          ],
        ),
      ),
    );
  }
}

class MapScreen extends StatelessWidget {
  final double latitude;
  final double longitude;

  MapScreen({required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Governorate Location'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 12.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId('governorate_marker'),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(title: 'Governorate Location'),
          ),
        },
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter_application_1/nearest_hospital_screen.dart';
import 'photo_guidelines_screen.dart';

void main() {
  runApp(BurnSkinApp());
}

class BurnSkinApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
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
}*/
