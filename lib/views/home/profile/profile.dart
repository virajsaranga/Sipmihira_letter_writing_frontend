import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:story_2/controllers/auth/auth_controller.dart';
import 'package:story_2/provider/auth/user_provider.dart';

import '../../../components/custom_text.dart';
import '../../../components/custom_textfield.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/assets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isShow = false;
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AssetsConstants.backgroundImage,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 40,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60, left: 50),
              child: Consumer<UserProvider>(
                builder: (context, value, child) {
                  return value.loading
                      ? const SpinKitRotatingCircle(
                          color: AppColors.heading,
                          size: 40.0,
                        )
                      : InkWell(
                        onTap: () => value.selectImage(),
                        child: Image.network(
                            value.userModel.photoUrl,
                            width: 250,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                      );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 290, left: 2),
              child: IconButton(
                onPressed: () {
                  AuthController().signout();
                },
                icon: const Icon(
                  Icons.login_outlined,
                  size: 65,
                  color: AppColors.kRed,
                ),
                tooltip: "Logout",
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 430,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 350, right: 20, top: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text:
                                "Hello\n${Provider.of<UserProvider>(context).nameController.text}",
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppColors.heading),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            isShow == false
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isShow = true;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: AppColors.heading,
                                      size: 30,
                                    ),
                                    tooltip: "Edit Profile",
                                  )
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isShow = false;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.cancel_outlined,
                                      color: AppColors.kRed,
                                      size: 30,
                                    ),
                                    tooltip: "Cancel",
                                  ),
                          ],
                        ),
                      ],
                    ),
                    Consumer<UserProvider>(
                      builder: (context, value, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            isShow == true
                                ? CustomTextField(
                                    hintText: 'Email',
                                    controller: value.emailController,
                                    enabled: false,
                                  )
                                : CustomText(
                                    text: value.userModel.email,
                                    textAlign: TextAlign.start,
                                  ),
                            const SizedBox(height: 10),
                            isShow
                                ? CustomTextField(
                                    hintText: 'Name',
                                    controller: value.nameController,
                                  )
                                : CustomText(
                                    text: value.userModel.name,
                                  ),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 480,
              top: 265,
              child: Consumer<UserProvider>(
                builder: (context, value, child) {
                  return IgnorePointer(
                    ignoring: value.loading,
                    child: GestureDetector(
                      onTap: () =>
                          value.updateUser(context, value.userModel.userId),
                      child: value.loading
                          ? const SpinKitRotatingCircle(
                              color: AppColors.heading,
                              size: 40.0,
                            )
                          : Container(
                              width: 220,
                              height: 80,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(AssetsConstants.button),
                                    fit: BoxFit.fill),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(top: 12, left: 86),
                                child: Text(
                                  'Update',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
