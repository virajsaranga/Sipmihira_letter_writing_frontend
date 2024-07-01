import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import "package:path/path.dart";
import 'package:story_2/models/objects.dart';
import 'package:story_2/services/network_service.dart';

class StorytellingController{

  var basePath = dotenv.env['BASE_PATH'];

  var client = http.Client();


  Future<StorytellingModel?> uploadStorytellingImage(File img) async {
    try {
      String? token = await NetworkHandler.readToken();

      var request = http.MultipartRequest(
          'POST', Uri.parse('$basePath/stories'));

      if (img.path.isNotEmpty) {
        request.headers.addAll({
          "authorization": "Bearer $token",
          "Content-Type": "multipart/form-data"
        });

        request.files.add(await http.MultipartFile.fromPath('file', img.path));
      }

      Logger().i("Image path: ${img.path}");

      Logger().w("File is sending...");

      var response = await request.send();

      Logger().w(response.statusCode);

      if (response.statusCode == 201) {
        var responsed = await http.Response.fromStream(response);

        Logger().w(responsed);
        

        var responseData = json.decode(responsed.body);

        Logger().w(responseData);

        StorytellingModel model = StorytellingModel.fromJson(responseData);

        return model;
      }
      return null;
    } catch (e) {
      Logger().e(e);

      return null;
    }
  }
}