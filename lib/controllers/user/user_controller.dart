import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import "package:path/path.dart";
import 'package:story_2/services/network_service.dart';

import '../../models/objects.dart';

class UserController {
  var basePath = dotenv.env['BASE_PATH'];

  var client = http.Client();

  //---------------fetch user data
  Future<UserModel?> fetchUserData(String uid) async {
    try {
      String? token = await NetworkHandler.readToken();

      // retrieve user data
      var response = await client.get(
        Uri.parse('$basePath/users/$uid'),
        headers: {
          'authorization': "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        //------mapping fetch data to user model
        UserModel model = UserModel.fromJson(data);

        Logger().i(model.email);

        return model;
      }

      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  //-----------update user function---
  Future<UserModel?> updateUser(
    String userId,
    String name,
  ) async {
    try {
      String? token = await NetworkHandler.readToken();

      var response = await client.put(
        Uri.parse(
          "$basePath/users/$userId",
        ),
        headers: {
          'authorization': "Bearer $token",
        },
        body: {"displayName": name},
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        //------mapping fetch data to user model
        UserModel model = UserModel.fromJson(data);

        Logger().i(model.email);

        Logger().w(response.body);

        return model;
      }
      Logger().w(response.body);

      return null;
    } catch (e) {
      Logger().e(e);

      return null;
    }
  }

  Future<void> updateUserPhoto(String userId, File img) async {
    try {
      String? token = await NetworkHandler.readToken();

      var request = http.MultipartRequest(
          'PUT', Uri.parse('$basePath/users/upload/$userId'));

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

      if (response.statusCode == 200) {
        var responsed = await http.Response.fromStream(response);
        Logger().w(responsed);

        String responseData = Uri.decodeFull(responsed.body);

        Logger().w(responseData);
      }
    } catch (e) {
      Logger().e(e);
    }
  }
}
