import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:story_2/provider/auth/login_provider.dart';
import 'package:story_2/provider/auth/password_reset.dart';
import 'package:story_2/provider/auth/signup_provider.dart';
import 'package:story_2/provider/auth/user_provider.dart';
import 'package:story_2/provider/common/start_image_provider.dart';
import 'package:story_2/provider/storytelling/storytelling_provider.dart';
import 'package:story_2/views/splash/splash.dart';
import 'package:flutter/services.dart';  

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then(
    (value) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => LoginProvider()),
          ChangeNotifierProvider(create: (context) => SignupProvider()),
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => PasswordResetProvider()),
          ChangeNotifierProvider(create: (context) => StorytellingProvider()),
          ChangeNotifierProvider(create: (context) => StartImageProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );

  await dotenv.load(fileName: ".env");
}

const Color kCanvasColor = Color(0xfff2f3f7);
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
    );
  }
}
