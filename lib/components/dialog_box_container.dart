import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_2/utils/assets.dart';

import '../provider/auth/user_provider.dart';
import '../utils/app_colors.dart';
import 'custom_text.dart';

class DialogBoxContainer extends StatefulWidget {
  DialogBoxContainer({
    Key? key,
    this.isverified = false,
  }) : super(key: key);

  bool isverified;

  @override
  State<DialogBoxContainer> createState() => _DialogBoxContainerState();
}

class _DialogBoxContainerState extends State<DialogBoxContainer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        if (value.isEmailVerified) {
          Navigator.pop(context);
        }
        return ElasticIn(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.kWhite,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 10),
                            blurRadius: 20,
                            color: AppColors.kAsh.withOpacity(0.4),
                          )
                        ],
                      ),
                      child: value.isEmailVerified
                          ? Stack(
                              children: <Widget>[
                                Image.asset(AssetsConstants.mailVerifiedImage),
                                const SizedBox(height: 23),
                                const Padding(
                                  padding: EdgeInsets.only(top: 100),
                                  child: Center(
                                    child: CustomText(
                                      textAlign: TextAlign.center,
                                      text: 'Thank You !',
                                      color: AppColors.primaryColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Stack(
                              children: <Widget>[
                                Image.asset(AssetsConstants.mailImage),
                                const SizedBox(height: 23),
                                const Padding(
                                  padding: EdgeInsets.only(top: 100),
                                  child: Center(
                                    child: CustomText(
                                      textAlign: TextAlign.center,
                                      text: 'Please verify\n your email!',
                                      color: AppColors.primaryColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                )
                              ],
                            )),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
