import 'package:flutter/material.dart';

class ThirdDegreeBurnPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Third-Degree Burns')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Third-Degree Burns',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('• Charring of skin', style: TextStyle(fontSize: 18)),
            Text('• Numbness due to nerve damage',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
