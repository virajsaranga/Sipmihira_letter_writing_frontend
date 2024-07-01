import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_2/components/notification_dialog_box.dart';
import 'package:story_2/controllers/user/user_controller.dart';
import 'package:story_2/utils/assets.dart';
import 'package:story_2/views/auth/login/login.dart';
import 'package:story_2/views/home/start/start.dart';

import '../../components/dialog_box_container.dart';
import '../../models/objects.dart';
import '../../services/network_service.dart';
import '../../utils/util_function.dart';

class UserProvider extends ChangeNotifier {
  //---------User Model
  late UserModel _userModel;

  //--------get user model
  UserModel get userModel => _userModel;

  //---------loader state
  bool _isLoading = false;

  bool _isEmailVerified = false;

  //-------email text controller
  final _emailController = TextEditingController();

  //-------password text controller
  final _passwordController = TextEditingController();

  //-------name text controller
  final _nameController = TextEditingController();

  //----get loading state
  bool get loading => _isLoading;

  bool get isEmailVerified => _isEmailVerified;

  bool _emailVerificationDialogShown = false;

  //----getter for email controller
  TextEditingController get emailController => _emailController;

  //----getter for password controller
  TextEditingController get passwordController => _passwordController;

  //----getter for name controller
  TextEditingController get nameController => _nameController;

  //-image picker instance
  final ImagePicker _picker = ImagePicker();

  //-------file object
  File _image = File("");

  //-getter for image
  File get image => _image;

  //-----change loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setEmailVerified(bool value) {
    _isEmailVerified = value;
    notifyListeners();
  }

  //------------fetch single user
  Future<void> fetchUser(String id) async {
    try {
      //-start the loader
      setLoading(true);

      await UserController().fetchUserData(id).then((value) {
        if (value != null) {
          Logger().w(value.email);

          _userModel = value;

          _nameController.text = value.name;
          _emailController.text = value.email;

          notifyListeners();

          setLoading(false);
        }
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> initializeUser(BuildContext context) async {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        if (user == null) {
          Logger().i("User signed out !");

          // ignore: use_build_context_synchronously
          UtilFunction.navigator(context, const LoginScreen());
        } else {
          await FirebaseAuth.instance.currentUser?.reload();
          Logger().w("Initialize User : $user");

          IdTokenResult idTokenResult =
              await FirebaseAuth.instance.currentUser!.getIdTokenResult();
          String? idToken = idTokenResult.token;

          Logger().w("ID Token: $idToken");

          await NetworkHandler.storeToken(idToken);

          setEmailVerified(user.emailVerified);

          if (!_emailVerificationDialogShown && !_isEmailVerified) {
            // ignore: use_build_context_synchronously
            UtilFunction.navigator(context, const LoginScreen());

            // ignore: use_build_context_synchronously
            await _showEmailVerificationDialog(context);
          } else {
            await FirebaseAuth.instance.currentUser?.reload();

            if (user.uid != null) {
              await fetchUser(user.uid);
            }
            
            // ignore: use_build_context_synchronously
            UtilFunction.navigator(context, const StartScreen());
          }
        }
      });
    } catch (error) {
      Logger().e(error);
    }
  }

  Future<void> _showEmailVerificationDialog(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool dialogShown = prefs.getBool('emailVerificationDialogShown') ?? false;

    if (!dialogShown) {
      _emailVerificationDialogShown = true;

      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return DialogBoxContainer(
              isverified: _isEmailVerified,
            );
          });

      // Save the flag in shared preferences
      await prefs.setBool('emailVerificationDialogShown', true);
    }
  }

  //---------start signup process
  Future<void> updateUser(BuildContext context, String userId) async {
    try {
      setLoading(true);

      if (_nameController.text.isNotEmpty) {
        await UserController()
            .updateUser(userId, _nameController.text)
            .then((value) async {
          await showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) {
                return NotificationDialogBox(
                  text: _nameController.text,
                  image: value!.name == _nameController.text
                      ? AssetsConstants.successImage
                      : AssetsConstants.errorImage,
                );
              });

          await fetchUser(value!.userId);
        });

        //stop the loader
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
      await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return const NotificationDialogBox(
              text: "",
              image: AssetsConstants.errorImage,
            );
          });
      Logger().e(e);
    }
  }

  //-----------pick upload and update and user profile image
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
        updateProfileImage(_image);
        notifyListeners();
      } else {
        Logger().e("No image selected");
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  //--------upload and update profile image
  Future<void> updateProfileImage(File img) async {
    try {
      //----start the loader
      setLoading(true);

      //-----start uploading the image

      await UserController()
          .updateUserPhoto(_userModel.userId, img)
          .then((_) async => {
                await fetchUser(_userModel.userId),
                notifyListeners(),
                //-stop the loader
                setLoading(false),
              });
    } catch (e) {
      Logger().e(e);
      setLoading(false);
    }
  }
}
