import 'package:flutter/material.dart' hide Image;
import 'package:story_2/main.dart';
import 'package:story_2/widgets/letter_drawing_canvas.dart';
import 'package:story_2/models/drawing_model_letter.dart';
import 'package:story_2/models/letter_sketch.dart';
import 'package:story_2/widgets/letter_canvas_side_bar.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:flutter_screen_capture/flutter_screen_capture.dart';

class DrawingPage1 extends HookWidget {
  //const DrawingPage1({Key? key}) : super(key: key);

  //screenshot code

  Future<void> _submitCanvas(BuildContext context) async {
    // Check for camera permission status
    final PermissionStatus cameraPermissionStatus =
        await Permission.camera.status;

    try {
      if (cameraPermissionStatus.isGranted) {
        // Capture the screenshot
        final ScreenshotController screenshotController =
            ScreenshotController();
        final Uint8List? imageBytes = await screenshotController.capture();

        if (imageBytes == null) {
          // Handle the case where capturing the screenshot failed
          print('Failed to capture the screenshot');
          return;
        }

        // Convert the screenshot to base64
        String base64Image = base64Encode(imageBytes);

        // Send the screenshot to the backend
        final response = await http.post(
          Uri.parse('http://192.168.101.88:8000/submit-char/'),
          body: {
            'image1': base64Image,
            'image': 'your_image_name.jpg',
            'original': 'අ',
          },
        );

        // Handle the response
        _handleResponse(context, response);
      } else if (cameraPermissionStatus.isDenied) {
        final PermissionStatus newStatus = await Permission.camera.request();
        if (newStatus.isGranted) {
          // Permission granted, retry capturing the screenshot
          _submitCanvas(context);
        } else {
          print('Permission denied for camera access');
        }
      } else {
        print(
            'Permission is permanently denied or restricted for camera access');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _handleResponse(BuildContext context, http.Response response) {
    if (response.statusCode == 200) {
      // Successfully sent the image to the backend, now handle the response body
      final responseBody = response.body;
      // Add your logic to handle the response here
      print('Response body: $responseBody');
    } else {
      print('Failed to send image to the backend');
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedColor = useState(Colors.black);
    final strokeSize = useState<double>(10);
    final eraserSize = useState<double>(30);
    final drawingMode = useState(DrawingMode.pencil);

    final canvasGlobalKey = GlobalKey();

    ValueNotifier<Sketch?> currentSketch = useState(null);
    ValueNotifier<List<Sketch>> allSketches = useState([]);

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 150),
      initialValue: 1,
    );

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: kCanvasColor,
            width: double.maxFinite,
            height: double.maxFinite,
            child: DrawingCanvas(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              drawingMode: drawingMode,
              selectedColor: selectedColor,
              strokeSize: strokeSize,
              eraserSize: eraserSize,
              sideBarController: animationController,
              currentSketch: currentSketch,
              allSketches: allSketches,
              canvasGlobalKey: canvasGlobalKey,
            ),
          ),
          Positioned(
            top: kToolbarHeight + 10,
            bottom: kToolbarHeight - 60,
            // left: -5,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: Offset.zero,
              ).animate(animationController),
              child: CanvasSideBar(
                drawingMode: drawingMode,
                selectedColor: selectedColor,
                strokeSize: strokeSize,
                eraserSize: eraserSize,
                currentSketch: currentSketch,
                allSketches: allSketches,
                canvasGlobalKey: canvasGlobalKey,
              ),
            ),
          ),
          Positioned(
            bottom: 20, // Adjust the vertical position as needed
            left: 20, // Adjust the horizontal position as needed
            child: ElevatedButton(
              onPressed: () {
                _submitCanvas(context);
              },
              child: Text('Submit'),
            ),
          ),
          _CustomAppBar(animationController: animationController),
          Positioned(
            bottom: 10,
            right: 10,
            child: ElevatedButton(
              onPressed: () {
                // Add your button click logic here
              },
              child: const Text('හරිද බලමු'),
            ),
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final AnimationController animationController;

  const _CustomAppBar({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                if (animationController.value == 0) {
                  animationController.forward();
                } else {
                  animationController.reverse();
                }
              },
              icon: const Icon(Icons.menu),
            ),
            const Text(
              'අ අකුර ලියමු 🧒',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
            const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
