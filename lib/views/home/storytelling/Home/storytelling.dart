import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:story_2/components/custom_text.dart';
import 'package:story_2/provider/storytelling/storytelling_provider.dart';

import '../../../../provider/common/start_image_provider.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/assets.dart';

class StoryHomeScreen extends StatefulWidget {
  const StoryHomeScreen({super.key});

  @override
  State<StoryHomeScreen> createState() => _StoryHomeScreenState();
}

class _StoryHomeScreenState extends State<StoryHomeScreen> {
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
            Consumer<StartImageProvider>(
              builder: (context, value, child) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: value.index == 0
                      ? Container(
                          width: 150,
                          height: 150,
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
                          width: 150,
                          height: 150,
                          child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(math.pi),
                              child: Image.asset(AssetsConstants.boyImage)),
                        ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 220),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 4),
                    Consumer<StorytellingProvider>(
                      builder: (context, value, child) {
                        return value.loading
                            ? const SpinKitRotatingCircle(
                                color: AppColors.kWhite,
                                size: 40.0,
                              )
                            : InkWell(
                                onTap: () => value.selectImage(),
                                child: value.storyModel == null
                                    ? Container(
                                        width: 370,
                                        height: 270,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                              AssetsConstants.placeholderImage1,
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      )
                                    : Image.network(
                                        value.storyModel!.imageUrl,
                                        width: 370,
                                        height: 270,
                                        fit: BoxFit.cover,
                                      ),
                              );
                      },
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 500,
              top: 300,
              child: 
              Consumer<StorytellingProvider>(
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButtonColumn(Colors.green, Colors.greenAccent,
                          Icons.play_arrow, 'PLAY', value.textToSpeech),
                      _buildButtonColumn(Colors.red, Colors.redAccent,
                          Icons.stop, 'STOP', value.stop),
                      _buildButtonColumn(Colors.blue, Colors.blueAccent,
                          Icons.pause, 'PAUSE', value.pause),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, Function func) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            icon: Icon(icon),
            iconSize: 50,
            color: color,
            splashColor: splashColor,
            onPressed: () => func()),
        Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 12.0, fontWeight: FontWeight.w400, color: color),
          ),
        )
      ],
    );
  }
}
