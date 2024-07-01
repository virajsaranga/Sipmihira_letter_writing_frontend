import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:story_2/components/custom_text.dart';
import 'package:story_2/components/custom_textfield.dart';
import 'package:story_2/provider/auth/password_reset.dart';
import 'package:story_2/views/auth/login/login.dart';

import '../../../components/form_validation.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/assets.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
                width: 360,
                height: 800,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AssetsConstants.backgroundImage),
                      fit: BoxFit.fill),
                )),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 430,
                color: Colors.white,
              ),
            ),
            Positioned(
              top: 23,
              left: 10,
              child: Container(
                width: 138,
                height: 138,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AssetsConstants.circleImage),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Positioned(
              bottom: 0.29,
              left: 0.29,
              child: Container(
                width: 100,
                height: 138,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AssetsConstants.halfCircleImage),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 6,
              child: Container(
                width: 280,
                height: 280,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AssetsConstants.resetImage),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 350, right: 20, top: 60),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CustomText(
                      text: "Reset Password",
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.heading,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      hintText: 'Email',
                      controller: Provider.of<PasswordResetProvider>(context)
                          .emailController,
                      errorText: FormValidation().validateEmail(
                          Provider.of<PasswordResetProvider>(context)
                              .emailController
                              .text),
                      onChanged: (value) {
                        setState(() {
                          FormValidation().validateEmail(value);
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                ),
                            child: CustomText(
                                text: "Do you have an account?",
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.kAsh.withOpacity(0.9)))),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 480,
              top: 250,
              child: Consumer<PasswordResetProvider>(
                builder: (context, value, child) {
                  return IgnorePointer(
                    ignoring: value.loading,
                    child: GestureDetector(
                      onTap: () => value.startPasswordReset(context),
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
                                padding: EdgeInsets.only(top: 12, left: 40),
                                child: Text(
                                  'Reset Password',
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
