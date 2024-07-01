import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:story_2/provider/auth/user_provider.dart';

import 'package:story_2/utils/util_function.dart';
import 'package:story_2/views/home/start/start.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../services/network_service.dart';

class LoginProvider extends ChangeNotifier {
  User? user;
  //-------email text controller
  final _emailController = TextEditingController();

  //-------password text controller
  final _passwordController = TextEditingController();

  //----getter for email controller
  TextEditingController get emailController => _emailController;

  //----getter for password controller
  TextEditingController get passwordController => _passwordController;

  //---------loader state
  bool _isLoading = false;

  //----get loading state
  bool get loading => _isLoading;

  User? get currentUser => user;

  //-----change loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //---------start signup process
  Future<void> startLogin(BuildContext context) async {
    try {
      //start the loader
      setLoading(true);

      if (_emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        await AuthController()
            .signinUser(_emailController.text, _passwordController.text)
            .then((value) async => {
                  user = value!.user,
                  Logger().e(user!.emailVerified),
                  NetworkHandler.storeRefreshToken(user!.refreshToken),
                  if (user != null && user!.emailVerified)
                    {
                      await UserProvider().fetchUser(user!.uid),
                      UtilFunction.navigator(context, const StartScreen())
                    },
                  Logger().w("Login Provider : $user"),
                });

        //clear text field
        _emailController.clear();
        _passwordController.clear();

        //stop the loader
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
      Logger().e(e);
    }
  }
}
