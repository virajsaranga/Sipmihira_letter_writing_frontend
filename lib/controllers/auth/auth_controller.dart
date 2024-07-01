import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:story_2/services/network_service.dart';
import 'package:story_2/utils/assets.dart';

class AuthController {
  //------Firebase auth instance
  final FirebaseAuth auth = FirebaseAuth.instance;

  var client = http.Client();

  var basePath = dotenv.env['BASE_PATH'];
  var apiKey = dotenv.env['API_KEY'];

  //-----------register user function---
  Future<void> registerUser(
    String userId,
    String email,
    String name,
  ) async {
    try {
      String? token = await NetworkHandler.readToken();

      var response = await client.post(
          Uri.parse(
            "$basePath/users/$userId",
          ),
          headers: {
            'authorization': "Bearer $token",
          },
          body: {
            "displayName": name,
            "email": email,
            "photoUrl": AssetsConstants.profileimgurl,
          });

      Logger().w(response.body);
    } catch (e) {
      Logger().e(e);
    }
  }

  //-----------signup function---
  Future<void> signupUser(String email, String password, String name) async {
    try {

      var queryParameters = {
      'key': apiKey,
    };

      var response = await http.post(Uri.https("identitytoolkit.googleapis.com", "/v1/accounts:signUp",
        queryParameters
      ), 
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, dynamic>{
          "email": email,
          "password": password,
          "returnSecureToken": true
        }));

      if(response.statusCode == 200){

        var data = json.decode(response.body);

        Logger().i(data);

        await NetworkHandler.storeToken(data["idToken"]);

        await registerUser(data["localId"], email, name);

        NetworkHandler.storeRefreshToken(data["refreshToken"]);

      }
      else{
        Logger().e(response);
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<UserCredential?> signinUser(
    String email,
    String password,
  ) async {
        try{
          final AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

          UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

          return userCredential;
        }
        catch(e){
           Logger().e(e);
           return null;
        }
  }

  //-------reset password
  Future<void> resetPassword(String email) async {
    try {
      await client
          .post(Uri.parse("$basePath/auth/reset"), body: {"email": email});
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> signout() async {
    await auth.signOut();
  }

  Future<void> reauthenticateUser(String email, String password) async {
    // Create a credential
    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);

    // Reauthenticate
    await auth.currentUser!.reauthenticateWithCredential(credential);
  }
}
