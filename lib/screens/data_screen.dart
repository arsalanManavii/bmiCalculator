
import 'package:bmi_application/constant/colors.dart';
import 'package:bmi_application/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  int _height = 140;
  int _weight = 40;
  int _age = 25;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: textColor,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100.0),
              Text(
                'how tall are you ?',
                style: GoogleFonts.robotoMono(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              Text(
                'in cm ',
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              _getHeighContainer(),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _getWeightColumn(),
                  _getAgeColumn(),
                ],
              ),
              SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _clearButton(),
                  _calculateButton(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _calculateButton(BuildContext context) {
    return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      backgroundColor: buttonOrangeColor,
                      minimumSize: Size(170, 50)),
                  onPressed: () {
                    double status = calculateBMI(_height, _weight);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(
                          status: status,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'calculate',
                    style: GoogleFonts.inter(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                );
  }

  Widget _clearButton() {
    return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      backgroundColor: buttonOrangeColor,
                      minimumSize: Size(170, 50)),
                  onPressed: () {
                    setState(
                      () {
                        _height = 140;
                        _weight = 40;
                        _age = 25;
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.0,
                        width: 20.0,
                        child: Icon(
                          Icons.cached,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 18.0),
                      Text(
                        'clear',
                        style: GoogleFonts.inter(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
  }

  Widget _getAgeColumn() {
    return Column(
                  children: [
                    Text(
                      'what\'s your age?',
                      style: GoogleFonts.inter(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 25.0),
                    _getAgeContainer(),
                  ],
                );
  }

  Widget _getWeightColumn() {
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0),
                    Text(
                      'what\'s your weight?',
                      style: GoogleFonts.inter(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Text(
                      'in kg ',
                      style: GoogleFonts.inter(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    _getWeightContainer(),
                  ],
                );
  }

  bool _isValidAge(int age) {
    if (age >= 65 || age <= 18) {
      return false;
    }
    return true;
  }

  Widget _getAgeContainer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: 165.0,
      height: 90.0,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.0,
          color: Color(0xffFFF3E0),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              if (_isValidAge(_age) || _age == 65) {
                setState(() {
                  _age--;
                });
              }
            },
            icon: Icon(
              Icons.remove_outlined,
              color: textColor,
            ),
          ),
          Text(
            '$_age',
            style: GoogleFonts.merriweather(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          IconButton(
            onPressed: () {
              if (_isValidAge(_age) || _age == 18) {
                setState(() {
                  _age++;
                });
              }
            },
            icon: Icon(
              Icons.add_outlined,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getWeightContainer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      width: 165.0,
      height: 90.0,
      decoration: BoxDecoration(
        color: Color(0xffFFF3E0),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: NumberPicker(
        axis: Axis.horizontal,
        textStyle: GoogleFonts.inter(
            fontSize: 13.0, fontWeight: FontWeight.bold, color: textColor),
        selectedTextStyle: GoogleFonts.inter(
            fontSize: 22.0, fontWeight: FontWeight.bold, color: orangeAccent),
        itemWidth: 48.0,
        minValue: 40,
        maxValue: 200,
        value: _weight,
        onChanged: (value) {
          setState(
            () {
              _weight = value;
            },
          );
        },
      ),
    );
  }

  Widget _getHeighContainer() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 30.0,
      ),
      width: double.infinity,
      height: 100.0,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.0,
          color: Color(0xffFFF3E0),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: NumberPicker(
        textStyle: GoogleFonts.inter(
            fontSize: 15.0, fontWeight: FontWeight.bold, color: textColor),
        selectedTextStyle: GoogleFonts.inter(
            fontSize: 22.0, fontWeight: FontWeight.bold, color: orangeAccent),
        itemWidth: 45,
        axis: Axis.horizontal,
        minValue: 140,
        maxValue: 210,
        value: _height,
        infiniteLoop: false,
        onChanged: (value) {
          setState(
            () {
              _height = value;
            },
          );
        },
      ),
    );
  }

  double calculateBMI(int height, int weight) {
    double newHeight = height.toDouble();
    var heightInM = (newHeight / 100) * 2;
    double result = weight / heightInM;
    return result;
  }
}
