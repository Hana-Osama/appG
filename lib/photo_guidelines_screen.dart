import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'scan_screen.dart';

class PhotographyGuidelinesPage extends StatefulWidget {
  @override
  _PhotographyGuidelinesPageState createState() =>
      _PhotographyGuidelinesPageState();
}

class _PhotographyGuidelinesPageState extends State<PhotographyGuidelinesPage> {
  File? _selectedImage;

  Future<void> _pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5A6B81),
      appBar: AppBar(
        title: Text(
          'Guidelines Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF87A1C3),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Spacer(),
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(12),
              ),
              child: _selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(_selectedImage!, fit: BoxFit.cover))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child:
                          Image.asset('assets/image 1.png', fit: BoxFit.cover)),
            ),
            SizedBox(height: 20),
            Text(
              'Photography Guidelines | إرشادات التصوير',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            _buildGuideline('Clean the lens', 'نظف العدسة'),
            _buildGuideline('Use natural light when possible',
                'استخدم الإضاءة الطبيعية كلما أمكن'),
            _buildGuideline('Avoid backlighting', 'تجنب التصوير ضد الإضاءة'),
            _buildGuideline('Tap to focus (phones)', 'اضغط للتركيز (الهواتف)'),
            SizedBox(height: 30),
            // Buttons
            CustomButton(
                text: 'Scan',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ScanPage()));
                }),
            SizedBox(height: 10),
            CustomButton(
                text: 'Upload Image',
                onPressed: _pickImageFromGallery), // Opens Gallery
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideline(String english, String arabic) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text: '• $english\n',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: '$arabic',
                style: TextStyle(color: Colors.white70, fontSize: 13)),
          ],
        ),
        textAlign: TextAlign.left,
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
    return SizedBox(
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
    );
  }
}
