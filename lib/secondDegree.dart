import 'package:flutter/material.dart';
import 'package:flutter_application_1/nearest_hospital_screen.dart';

class SecondDegreeBurnPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5A6B81),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Second-Degree Burns |',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'الحروق من الدرجة الثانية',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildBurnStep('1. Rinse with cool water for 15 minutes.',
                      'اغسل المنطقة بالماء البارد لمدة 15 دقيقة.'),
                  _buildBurnStep('2. Cover with a loose, sterile bandage.',
                      'غطِّ الحرق بضمادة معقمة وفضفاضة.'),
                  _buildBurnStep(
                      '3. Apply antibiotic cream.', 'ضع كريم مضاد للبكتيريا.'),
                  _buildBurnStep('4. Use pain relievers if needed.',
                      'استخدم مسكنات الألم إذا لزم الأمر.'),
                  _buildBurnStep(
                      '5. For burns larger than 3 inches or on sensitive areas, consult a doctor.',
                      'استشر الطبيب للحروق الكبيرة أو في المناطق الحساسة.'),
                  SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NearestHospitalPage()),
                          );
                        },
                        child: Text(
                          'Nearest Hospital',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
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

  Widget _buildBurnStep(String english, String arabic) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$english\n',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            TextSpan(
              text: arabic,
              style: TextStyle(fontSize: 15, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
