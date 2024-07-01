import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../components/dialog_box_container.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../utils/util_function.dart';
import '../../views/auth/login/login.dart';

class SignupProvider extends ChangeNotifier {
  //-------email text controller
  final _emailController = TextEditingController();

  //-------password text controller
  final _passwordController = TextEditingController();

  //-------name text controller
  final _nameController = TextEditingController();

  //---------loader state
  bool _isLoading = false;

  //----getter for email controller
  TextEditingController get emailController => _emailController;

  //----getter for password controller
  TextEditingController get passwordController => _passwordController;

  //----getter for name controller
  TextEditingController get nameController => _nameController;

  //----get loading state
  bool get loading => _isLoading;

  //-----change loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //---------start signup process
  Future<void> startSignup(BuildContext context) async {
    try {
      setLoading(true);

      if (_emailController.text.isNotEmpty &&
          _nameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        await AuthController()
            .signupUser(
          _emailController.text,
          _passwordController.text,
          _nameController.text,
        )
            .then((value) async {
          await showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) {
                return DialogBoxContainer(
                  isverified: false,
                );
              });

          // ignore: use_build_context_synchronously
          UtilFunction.navigator(context, const LoginScreen());
        });

        //clear text field
        _emailController.clear();
        _nameController.clear();
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
