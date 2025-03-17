import 'package:flutter/material.dart';
import 'nearest_hospital_screen.dart';

class FirstDegreeBurnPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5A6B81),
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF3C4D5B),
            borderRadius: BorderRadius.circular(30),
          ),
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "First-Degree Burn Care | العناية بالحروق من الدرجة الأولى",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),

              // Burn Care Steps
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                  children: [
                    TextSpan(text: "1. Rinse with "),
                    TextSpan(
                        text: "cool water for 10-15 minutes",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: " (no ice).\n"),
                    TextSpan(text: "   اغسل بالماء البارد لمدة "),
                    TextSpan(
                        text: "10-15 دقيقة (بدون ثلج).\n\n",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text:
                            "2. Cover with a sterile bandage or clean cloth.\n"),
                    TextSpan(
                        text: "   استخدم ضمادة معقمة أو قطعة قماش نظيفة.\n\n"),
                    TextSpan(text: "3. Apply "),
                    TextSpan(
                        text: "aloe vera or burn ointment",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: " (avoid oils/butter).\n"),
                    TextSpan(
                        text:
                            "   ضع جل الصبار أو مرهم الحروق (تجنب الزيوت والزبدة).\n\n"),
                    TextSpan(text: "4. Take pain relievers if needed.\n"),
                    TextSpan(text: "   تناول مسكنات الألم عند الضرورة.\n\n"),
                    TextSpan(
                        text: "5. Seek help ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: "if pain worsens or infection appears.\n"),
                    TextSpan(
                        text:
                            "   اطلب المساعدة إذا تفاقم الألم أو ظهرت علامات العدوى.\n"),
                  ],
                ),
              ),

              SizedBox(height: 30),

              // Nearest Hospital Button
              SizedBox(
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NearestHospitalPage()),
                    );
                  },
                  child: Text(
                    "Nearest Hospital",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
