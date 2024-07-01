import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'custom_text.dart';

class NotificationDialogBox extends StatelessWidget {
  const NotificationDialogBox({super.key, this.image, required this.text});

  final String text;
  final String? image;

  @override
  Widget build(BuildContext context) {
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
                  child: Stack(
                    children: <Widget>[
                      Image.asset(image!),
                      const SizedBox(height: 23),
                      Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Center(
                          child: CustomText(
                            textAlign: TextAlign.center,
                            text: text,
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
  }
}
