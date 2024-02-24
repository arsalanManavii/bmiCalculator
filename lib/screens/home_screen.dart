import 'package:bmi_application/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isMale = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.0),
              Text(
                'BMI Calculator',
                style: GoogleFonts.inter(
                  color: textColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50.0),
              Text(
                'What\'s Your Gender ? ',
                style: GoogleFonts.inter(
                  color: textColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 70.0),
              _getGenders(),
              SizedBox(height: 60.0),
              Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    backgroundColor: buttonOrangeColor,
                    minimumSize: Size(300.0, 50),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DataScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Next',
                    style: GoogleFonts.inter(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getGenders() {
    return Row(
      children: [
        SizedBox(width: 15.0),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(
                  () {
                    _isMale = true;
                  },
                );
              },
              child: Container(
                width: 150.0,
                height: 250.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.0,
                    color: _isMale ? orangeAccent : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Image.asset('images/man.png'),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'MALE',
              style: GoogleFonts.inter(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: textColor),
            ),
          ],
        ),
        SizedBox(width: 35.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(
                  () {
                    _isMale = false;
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.0,
                    color: !_isMale ? orangeAccent : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                width: 130.0,
                height: 250.0,
                child: Image.asset('images/woman.png'),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Text(
                'FEMALE',
                style: GoogleFonts.inter(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: textColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
