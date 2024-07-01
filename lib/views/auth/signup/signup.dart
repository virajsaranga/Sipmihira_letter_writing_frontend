import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:story_2/components/form_validation.dart';
import 'package:story_2/provider/auth/signup_provider.dart';
import 'package:story_2/views/auth/login/login.dart';

import '../../../components/custom_text.dart';
import '../../../components/custom_textfield.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/assets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
              top: 20,
              left: 40,
              child: Container(
                width: 300,
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AssetsConstants.signupImage),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 350, right: 20, top: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CustomText(
                        text: "Signup",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.heading),
                    CustomTextField(
                      hintText: 'Name',
                      controller:
                          Provider.of<SignupProvider>(context).nameController,
                      onChanged: (value) {
                        setState(() {
                          FormValidation().validateName(value);
                        });
                      },
                      errorText: FormValidation().validateName(
                          Provider.of<SignupProvider>(context)
                              .nameController
                              .text),
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      hintText: 'Email',
                      controller:
                          Provider.of<SignupProvider>(context).emailController,
                      onChanged: (value) {
                        setState(() {
                          FormValidation().validateEmail(value);
                        });
                      },
                      errorText: FormValidation().validateEmail(
                          Provider.of<SignupProvider>(context)
                              .emailController
                              .text),
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      hintText: 'Password',
                      isObscure: true,
                      controller: Provider.of<SignupProvider>(context)
                          .passwordController,
                      onChanged: (value) {
                        setState(() {
                          FormValidation().validatePassword(value);
                        });
                      },
                      errorText: FormValidation().validatePassword(
                          Provider.of<SignupProvider>(context)
                              .passwordController
                              .text),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        ),
                        child: CustomText(
                          text: "Already have an account?",
                          fontSize: 12,
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
              top: 290,
              child: Consumer<SignupProvider>(
                builder: (context, value, child) {
                  return IgnorePointer(
                    ignoring: value.loading,
                    child: GestureDetector(
                      onTap: () => value.startSignup(context),
                      child: value.loading ? 
                        const SpinKitRotatingCircle(
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
                          padding: EdgeInsets.only(top: 15, left: 86),
                          child: Text(
                                  'Signup',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                        ),
                      ) ,
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
