import 'package:flutter/material.dart' hide Image;
import 'package:story_2/main.dart';
import 'package:story_2/widgets/letter_drawing_canvas.dart';
import 'package:story_2/models/drawing_model_letter.dart';
import 'package:story_2/models/letter_sketch.dart';
import 'package:story_2/widgets/letter_canvas_side_bar.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:universal_html/html.dart' as html;
import 'dart:async';
import 'dart:convert';



class DrawingPage10 extends HookWidget {
  const DrawingPage10({Key? key}) : super(key: key);

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

    Future<Uint8List?> getBytes() async {
      // Define the getBytes function here
      RenderRepaintBoundary boundary = canvasGlobalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();
      return pngBytes;
    }

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
            bottom:kToolbarHeight -60 ,
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
          _CustomAppBar(animationController: animationController,
          getBytesCallback: getBytes,),
          Positioned(
            bottom: 10,
            right: 10,
            child: ElevatedButton(
              onPressed: () async {
                Uint8List? pngBytes = await getBytes();
                if (pngBytes != null) saveFile(pngBytes, 'jpeg');
              },
              child: const Text('හරිද බලමු'),
            ),
          ),
        ],
      ),
    );
  }

  void saveFile(Uint8List bytes, String extension) async {
    if (kIsWeb) {
      html.AnchorElement(
          href: 'data:application/octet-stream;base64,${base64Encode(bytes)}')
        ..target = 'file'
        ..download = 'image.$extension'
        ..click();
    } else {
      await FileSaver.instance.saveFile(
        'FlutterLetsDraw-${DateTime.now().toIso8601String()}.$extension',
        bytes,
        extension,
        mimeType: extension == 'png' ? MimeType.PNG : MimeType.JPEG,
      );
    }
  }
}


class _CustomAppBar extends StatelessWidget {
  final AnimationController animationController;
  final Function getBytesCallback; // Callback function
const _CustomAppBar({
    Key? key,
    required this.animationController,
    required this.getBytesCallback, // Pass the callback function
  }) : super(key: key);


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
              'ද අකුර ලියමු 🧒',
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




   Future<void> sendImageToBackend(Uint8List imageBytes) async {
    final url = Uri.parse('http://192.168.101.88:8000/submit-char/');
    final request = http.MultipartRequest('POST', url);

    // Add the image file to the request
    final multipartFile = http.MultipartFile.fromBytes(
      'image',
      imageBytes,
      filename: 'image.jpeg', // Change the filename as needed
    );
    request.files.add(multipartFile);

    // Add the other data
     request.fields['image'] = 'image.jpeg';
    request.fields['original'] = 'අ';
   

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        // Request successful
        // Handle the response from the backend if needed
      } else {
        // Request failed
        // Handle errors
      }
    } catch (e) {
      // Handle exceptions
    }
  }
}


