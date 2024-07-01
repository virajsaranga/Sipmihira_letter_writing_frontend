import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:story_2/controllers/storytelling/storytelling_controller.dart';
import 'package:story_2/models/objects.dart';

class StorytellingProvider extends ChangeNotifier {
  //FlutterTts instance
  FlutterTts tts = FlutterTts();

  //Storytelling model instance
  StorytellingModel? _storyModel;

  //get Storytelling model
  StorytellingModel? get storyModel => _storyModel;

  //-image picker instance
  final ImagePicker _picker = ImagePicker();

  //-------file object
  File _image = File("");

  //-getter for image
  File get image => _image;

  //---------loader state
  bool _isLoading = false;

  //----get loading state
  bool get loading => _isLoading;

  //-----change loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //------pick an image
  //-------function to pick file from gallery
  Future<void> selectImage() async {
    try {
      // Pick an image
      final XFile? pickFile =
          await _picker.pickImage(source: ImageSource.gallery);

      //-check if the user has pick a file or not
      if (pickFile != null) {
        //-assign to the file object
        _image = File(pickFile.path);

        //--------start uploading the image after picking
        uploadImage(_image);
        notifyListeners();
      } else {
        Logger().e("No image selected");
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  //--------upload image
  Future<void> uploadImage(File img) async {
    try {
      //----start the loader
      setLoading(true);

      //-----start uploading the image

      await StorytellingController()
          .uploadStorytellingImage(img)
          .then((value) => {
                if (value != null)
                  {
                    _storyModel = value,
                    notifyListeners(),
                    setLoading(false),
                  }
              });
    } catch (e) {
      Logger().e(e);
      setLoading(false);
    }
  }

  Future textToSpeech() async {

    String language = 'si-LK';
    tts.setLanguage(language);

    double rate = 0.35;
    tts.setSpeechRate(rate);

    tts.setPitch(1.0);

   tts.speak(_storyModel!.story);
  }

  Future stop() async {
    await tts.stop();
    // if (result == 1) tts.stop();
  }

  Future pause() async {
     await tts.pause();
    // if (result == 1) tts.pause();
  }
}
