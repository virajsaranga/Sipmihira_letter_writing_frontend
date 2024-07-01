import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:story_2/components/notification_dialog_box.dart';
import 'package:story_2/utils/assets.dart';
import 'package:story_2/views/auth/login/login.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../utils/util_function.dart';

class PasswordResetProvider extends ChangeNotifier {
  //-------email text controller
  final _emailController = TextEditingController();

  //----getter for email controller
  TextEditingController get emailController => _emailController;

  //---------loader state
  bool _isLoading = false;

  //----get loading state
  bool get loading => _isLoading;

  //-----change loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //---------start signup process
  Future<void> startPasswordReset(BuildContext context) async {
    try {
      //start the loader
      setLoading(true);

      if (_emailController.text.isNotEmpty) {
        await AuthController()
            .resetPassword(_emailController.text)
            .then((value) async => {
                  await showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return const NotificationDialogBox(
                          text: "Please check your email",
                          image: AssetsConstants.mailImage,
                        );
                      }),
                  UtilFunction.navigator(context, const LoginScreen())
                });

        //clear text field
        _emailController.clear();

        //stop the loader
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
      Logger().e(e);
    }
  }
}
