import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_2/provider/auth/user_provider.dart';

import 'package:story_2/utils/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

 @override
 void initState() {
  super.initState();

  Provider.of<UserProvider>(context, listen: false).initializeUser(context);
 }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
                decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AssetsConstants.backgroundImage),
                  fit: BoxFit.fill),
            )),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 370,
                color: Colors.white,
              ),
            ),
            Container(
              width: 430,
              height: 400,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AssetsConstants.splashImage),
                    fit: BoxFit.fill),
              ),
            ),
            Positioned(
              left: 480,
              top: 250,
              child: Container(
                width: 220,
                height: 80,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AssetsConstants.button),
                      fit: BoxFit.fill),
                ),
                child: const Padding(
                  padding:
                    EdgeInsets.symmetric(horizontal: 57, vertical: 18),
                  child: Text(
                    'පටන් ගන්න',
                    style: TextStyle(
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
