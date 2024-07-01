import 'package:story_2/utils/util_function.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:story_2/utils/assets.dart';
import 'package:story_2/views/home/letterWritting/drawingPage2.dart';

class LearnPage2 extends StatefulWidget {
  const LearnPage2({super.key});

  @override
  State<LearnPage2> createState() => _LearnPage2State();
}

class _LearnPage2State extends State<LearnPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' 🤱   අකුර හදුනාගමු   🤱 '),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 249, 39, 245),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                image: AssetImage(AssetsConstants.letterLearning1),
                width: 100, // Adjust the width as needed
                height: 50, // Adjust the height as needed
              ),
              Image(
                image: AssetImage(AssetsConstants.letterLearning22), // Replace with your image path
                width: 400, // Adjust the width as needed
                height: 200, // Adjust the height as needed
              ),
              Image(
                image: AssetImage(AssetsConstants.letterLearning2), // Replace with your image path
                width: 100, // Adjust the width as needed
                height: 50, // Adjust the height as needed
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              Container(
                width: 150, // Set the button width
                  height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Perform button action
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DrawingPage2()),
                    );
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                        Size(150, 50)), // Set button size
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                          return Colors.blue
                              .withOpacity(0.8); // Set hover color
                        }
                        return Colors.blue; // Default color
                      },
                    ),
                  ),
                  child: Text('ලියමු'),
                ),
              ),
              SizedBox(width: 1),
            ],
          ),
        ],
      ),
    );
  }
}
