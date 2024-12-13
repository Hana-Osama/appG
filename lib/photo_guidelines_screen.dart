import 'package:flutter/material.dart';

class PhotoGuidelinesScreen extends StatelessWidget {
  const PhotoGuidelinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF78909C),
      appBar: AppBar(title: const Text("Photo Guidelines")),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.checklist_rounded,
              size: 80,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            const Text(
              'Photography Guidelines',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '• Clean the lens\n• Use natural light when possible\n• Avoid backlighting\n• Tap to focus (phones)',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/scan');
              },
              child: const Text('Scan'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/select');
              },
              child: const Text('Select'),
            ),
          ],
        ),
      ),
    );
  }
}
