import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:story_2/components/custom_text.dart';
import 'package:story_2/components/custom_textfield.dart';
import 'package:story_2/provider/auth/login_provider.dart';
import 'package:story_2/views/auth/reset_password/reset_password.dart';
import '../../../components/form_validation.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/assets.dart';
import '../signup/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              top: 8,
              left: 20,
              child: Container(
                width: 340,
                height: 340,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AssetsConstants.loginImage),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 320, left: 470),
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ResetPasswordScreen()),
                ),
                child: CustomText(
                  text: "Can not remember the password?",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kAsh.withOpacity(0.9),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 350, right: 20, top: 40),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CustomText(
                        text: "Login",
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.heading),
                    CustomTextField(
                      hintText: 'Email',
                      controller:
                          Provider.of<LoginProvider>(context).emailController,
                      onChanged: (value) {
                        setState(() {
                          FormValidation().validateEmail(value);
                        });
                      },
                      errorText: FormValidation().validateEmail(
                          Provider.of<LoginProvider>(context)
                              .emailController
                              .text),
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      hintText: 'Password',
                      isObscure: true,
                      controller: Provider.of<LoginProvider>(context)
                          .passwordController,
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        ),
                        child: CustomText(
                          text: "Do not have an account?",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.kAsh.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 480,
              top: 250,
              child: Consumer<LoginProvider>(
                builder: (context, value, child) {
                  return IgnorePointer(
                    ignoring: value.loading,
                    child: GestureDetector(
                      onTap: () => value.startLogin(context),
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
                                  'Login',
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
