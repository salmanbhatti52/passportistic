import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scanguard/Home/mainScreenHome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/signIn.dart';
import 'onbaording/onboarding.dart';

Future<void> main() async {

   //Stripe.publishableKey = 'pk_test_51NLlvKCCEPyXUeT4DjSVqVRbXaDMIhlfi4MaBvtJii1Dmy25jzJAm18CCXH99nSygrwrRHELnm2cmMsebhh6eo7K00WmUQYqVP';
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.blue
  //       .withOpacity(0.5), // Replace "Colors.blue" with your desired color
  //   // You can also customize other aspects of the status bar, such as status bar icons' color:
  //   //statusBarIconBrightness: Brightness.light, // For dark status bar icons
  //   statusBarIconBrightness: Brightness.dark, // For light status bar icons
  // ));
  WidgetsFlutterBinding.ensureInitialized();
  _prefs = await SharedPreferences.getInstance();
  bool shownOnboarding = _prefs?.getBool('shownOnboarding') ?? false;
  runApp(MyApp(shownOnboarding: shownOnboarding));
}

class MyApp extends StatefulWidget {
  final bool shownOnboarding;
  const MyApp({Key? key, required this.shownOnboarding}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    bool shownOnboarding = _prefs?.getBool('shownOnboarding') ?? false;

    if (!shownOnboarding) {
      // First-time launch, show onboarding screen
      await _prefs?.setBool('shownOnboarding', true);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00AEFF)),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

SharedPreferences? _prefs;
SharedPreferences? prefs;
String? userID;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // checkLoginStatus();

    _timer = Timer(Duration(seconds: 2), () {
      // Timer duration set to 2 seconds
      checkLoginStatus();
      if (userID == null) {
        Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context) {
            return Onboard();
          },
        ));
      } else {
        Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context) {
            return SignInPage();
          },
        ));
      }

      print("Hammad");
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('userID');
    print("userID Main Dart: ${userID}");
    if (userID != null) {
      Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) {
          return MainScreen();
        },
      ));
    } else {
      Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) {
          return SignInPage();
        },
      ));
    }
    // return userID != null;
  }

  // void navigateToNextScreen() async {
  //   // LoginUserModels loginModel = LoginUserModels();

  //   bool isLoggedIn = await checkLoginStatus();
  //   Navigator.of(context).pushReplacement(
  //     MaterialPageRoute(
  //       builder: (context) => isLoggedIn ? MainScreen() : SignInPage(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // Set the background color to transparent
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color(0xFF00AEFF),
            image: DecorationImage(
              image: AssetImage("assets/bg.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  "assets/Logo.svg",
                  width: MediaQuery.of(context).size.width * 0.277,
                  height: 111,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
