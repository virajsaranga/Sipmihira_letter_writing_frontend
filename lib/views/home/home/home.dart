import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:story_2/components/custom_text.dart';
import 'package:story_2/provider/common/start_image_provider.dart';
import 'package:story_2/utils/app_colors.dart';
import 'package:story_2/utils/util_function.dart';
import 'package:story_2/views/home/profile/profile.dart';
import 'package:story_2/views/home/storytelling/Home/storytelling.dart';
import 'package:story_2/views/home/letterWritting/letterWritingHome.dart';

import '../../../utils/assets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              padding: const EdgeInsets.only(top: 10, left: 700),
              child: InkWell(
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()),
                      ),
                  child: const Icon(Icons.settings,
                      color: AppColors.kBlack, size: 50)),
            ),
            Consumer<StartImageProvider>(
              builder: (context, value, child) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: value.index == 0
                      ? Container(
                          width: 200,
                          height: 200,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                AssetsConstants.girlImage,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 200,
                          height: 200,
                          child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(math.pi),
                              child: Image.asset(AssetsConstants.boyImage)),
                        ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 250),
              child: Row(
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StoryHomeScreen()),
                        ),
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                AssetsConstants.storyImage,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const CustomText(
                        text: 'කතන්දර අහමු',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Column(
                    children: [
                      // Add space between buttons
                      InkWell(
                        onTap: () {
                          // Navigate to the new screen when the button is tapped
                          // Replace NewScreen() with the actual screen you want to navigate to
                          UtilFunction.navigator(context, letterWritingHome());
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                AssetsConstants
                                    .letterWrite, // Replace with your image asset
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const CustomText(
                        text: 'අකුරු ලියමුද',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
