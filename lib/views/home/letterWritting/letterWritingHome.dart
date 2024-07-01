import 'package:flutter/material.dart'; 
//import '../letterWritting//drawingPage1.dart'; 
 
import '../letterWritting/letterTeach//letterLearnin1.dart';
import '../letterWritting/letterTeach//letterLearning2.dart';
import '../letterWritting/letterTeach//letterLearning2.dart';
import '../letterWritting/letterTeach//letterLearnin3.dart';
import '../letterWritting/letterTeach//letterLearning4.dart';
import '../letterWritting/letterTeach//letterLearning5.dart';
import '../letterWritting/letterTeach//letterLearning6.dart';
import '../letterWritting/letterTeach//letterLearning7.dart';
import '../letterWritting/letterTeach//letterLearning8.dart';
import '../letterWritting/letterTeach//letterLearning9.dart';
import '../letterWritting/letterTeach//letterLearning10.dart';
import '../letterWritting/letterTeach//letterLearning11.dart';
import '../letterWritting/letterTeach//letterLearning12.dart';
import '../letterWritting/letterTeach//letterLearning13.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:letterWritingHome(),
    );
  }
}

class letterWritingHome extends StatelessWidget {





  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('✍️ අකුරු ලියන්න පටන් ගමු ✍️'),
        centerTitle: true, 
        backgroundColor: Color.fromARGB(255, 249, 39, 245),
      ),
body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 9, 136, 216)!, const Color.fromARGB(255, 217, 196, 220)!],
          ),
        ),
    
    child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  buttonText: 'අ  ලියමු',
                  onPressed: () {
                    // Navigate to the DrawingPage when button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LearnPage1()),
                    );
                  },
                ),
                // SizedBox(width: 15),
                // CustomButton(
                //   buttonText: 'උ   ලියමු ',
                //   onPressed: () {
                //     // Navigate to the DrawingPage when button is pressed
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => LearnPage2()),
                //     );
                //   },
                // ),
                // SizedBox(width: 15),
                // CustomButton(
                //   buttonText: 'ට    ලියමු ',
                //   onPressed: () {
                //     // Navigate to the DrawingPage when button is pressed
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => LearnPage3()),
                //     );
                //   },
                // ),
              ],
            ),
            SizedBox(height: 20), // Add some spacing between rows
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  buttonText: 'ත   ලියමු ',
                  onPressed: () {
                    // Navigate to the DrawingPage when button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LearnPage4()),
                    );
                  },
                ),
                SizedBox(width: 15),
                CustomButton(
                  buttonText: 'ප   ලියමු ',
                  onPressed: () {
                    // Navigate to the DrawingPage when button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LearnPage5()),
                    );
                  },
                ),
                SizedBox(width: 15),
                CustomButton(
                  buttonText: 'ල   ලියමු',
                  onPressed: () {
                    // Navigate to the DrawingPage when button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LearnPage6()),
                    );
                  },
                ),
                SizedBox(width: 15),
                CustomButton(
                  buttonText: 'ම   ලියමු',
                  onPressed: () {
                    // Navigate to the DrawingPage when button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LearnPage7()),
                    );
                  },
                ),
                SizedBox(width: 15),
                CustomButton(
                  buttonText: 'ය   ලියමු ',
                  onPressed: () {
                    // Navigate to the DrawingPage when button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LearnPage8()),
                    );
                  },
                ),
                // Add more buttons for this row
              ],
            ),
            SizedBox(height: 20), // Add some spacing between rows
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  buttonText: 'ර   ලියමු ',
                  onPressed: () {
                    // Navigate to the DrawingPage when button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LearnPage9()),
                    );
                  },
                ),
                SizedBox(width: 15),
                CustomButton(
                  buttonText: 'ද   ලියමු',
                  onPressed: () {
                    // Navigate to the DrawingPage when button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LearnPage10()),
                    );
                  },
                ),
                SizedBox(width: 15),
                CustomButton(
                  buttonText: 'ග   ලියමු ',
                  onPressed: () {
                    // Navigate to the DrawingPage when button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LearnPage11()),
                    );
                  },
                ),
                SizedBox(width: 15),
                CustomButton(
                  buttonText: 'ස   ලියමු',
                  onPressed: () {
                    // Navigate to the DrawingPage when button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LearnPage12()),
                    );
                  },
                ),
                SizedBox(width: 15),
                CustomButton(
                  buttonText: 'ඉ   ලියමු ',
                  textSize: 30.0, // Custom text size
                  isTextBold: true, // Text is bold
                  onPressed: () {
                    // Navigate to the DrawingPage when button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LearnPage13()),
                    );
                  },
                ),
                // Add more buttons for this row
              ],
            ),
          ],
        ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color buttonColor;
  final double padding;
  final double textSize; // New parameter for text size
  final bool isTextBold; // New parameter for bold text


  const CustomButton({
    required this.buttonText,
    required this.onPressed,
    this.buttonColor = const Color.fromARGB(70, 15, 0, 0), // Default button color
    this.padding = 25.0, // Default padding
    this.textSize = 46.0, // Default text size
    this.isTextBold = true, // Default is not bold
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            gradient: LinearGradient(
              colors: [
                buttonColor,
                buttonColor.withOpacity(0.8), // Adjust opacity for gradient
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          ),
          padding: EdgeInsets.all(padding),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: isTextBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
