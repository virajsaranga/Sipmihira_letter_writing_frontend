import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:story_2/components/custom_text.dart';
import 'package:story_2/provider/common/start_image_provider.dart';
import 'package:story_2/views/home/home/home.dart';
import '../../../utils/assets.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
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
                width: 470,
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
              top: 60,
              left: 6,
              child: Container(
                width: 280,
                height: 280,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetsConstants.startImage),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 300, top: 30),
              child: Row(
                children: [
                  Column(
                    children: [
                      const CustomText(
                        text: 'දුව',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      Consumer<StartImageProvider>(
                        builder: (context, value, child) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: GestureDetector(
                              onTap: () => setState(() {
                                value.setIndex(0);
                              }),
                              child: Container(
                                width: 200,
                                height: 200,
                                color: value.index == 0
                                    ? Color.fromARGB(255, 255, 123, 226)
                                    : Colors.transparent,
                                child: Image.asset(AssetsConstants.girlImage),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(width: 4),
                  Column(
                    children: [
                      const CustomText(
                        text: 'පුතා',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      Consumer<StartImageProvider>(
                        builder: (context, value, child) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: GestureDetector(
                              onTap: () => setState(() {
                                value.setIndex(1);
                              }),
                              child: Container(
                                width: 200,
                                height: 200,
                                color: value.index == 1
                                    ? Color.fromARGB(255, 177, 232, 255)
                                    : Colors.transparent,
                                child: Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.rotationY(math.pi),
                                  child: Image.asset(AssetsConstants.boyImage)),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              left: 500,
              top: 300,
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                ),
                child: Container(
                  width: 220,
                  height: 80,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AssetsConstants.button),
                        fit: BoxFit.fill),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 15, left: 86),
                    child: CustomText(
                      text: 'ඊළඟ',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
