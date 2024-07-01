import 'package:flutter/material.dart';
import 'package:story_2/components/custom_text.dart';

import '../utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hintText,
    this.isObscure = false,
    this.controller,
    this.errorText = "",
    this.onChanged,
    this.enabled = true,
  }) : super(key: key);

  final String hintText;
  final bool isObscure;
  final TextEditingController? controller;
  final String errorText;
  final void Function(String)? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(39, 146, 254, 1).withOpacity(0.15),
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: TextField(
            controller: controller,
            obscureText: isObscure,
            onChanged: onChanged,
            enabled: enabled,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: hintText,
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 164, 152, 152)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: const BorderSide(color: AppColors.kWhite),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: const BorderSide(color: AppColors.heading),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: const BorderSide(color: AppColors.kRed),
                )),
          ),
        ),
        if (errorText != "")
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: CustomText(
                text: errorText,
                color: Colors.red,
                fontSize: 10,
              ),
            ),
          ),
      ],
    );
  }
}
