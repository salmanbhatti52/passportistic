import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scanguard/Home/mainScreenHome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'auth/signIn.dart';
import 'onbaording/onboarding.dart';

SharedPreferences? _prefs;
SharedPreferences? prefs;
String? userID;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _prefs = await SharedPreferences.getInstance();
  bool shownOnboarding = _prefs?.getBool('shownOnboarding') ?? false;
  runApp(MyApp(shownOnboarding: shownOnboarding));
}

class MyApp extends StatefulWidget {
  final bool shownOnboarding;

  const MyApp({Key? key, required this.shownOnboarding}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: Builder(builder: (BuildContext context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFF00AEFF)),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        );
      }),
    );
  }
}

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
    _timer = Timer(const Duration(seconds: 2), () {
      checkOnboardingStatus();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void checkOnboardingStatus() async {
    _prefs = await SharedPreferences.getInstance();
    bool shownOnboarding =
        _prefs?.getBool('shownOnboarding') ?? true; // Use true as default

    prefs = await SharedPreferences.getInstance();
    // bool shownOnboarding = prefs?.getBool('shownOnboarding') ?? true; // Use true as default
    userID = prefs?.getString('userID'); // Use prefs here

    print("Onboarding Status: $shownOnboarding");
    print("User ID: $userID");

    if (shownOnboarding) {
      if (userID != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const MainScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const SignInPage()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const Onboard()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
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
                  "assets/log1.svg",
                  height: 55.h,
                  width: 219.w,
                ),
              ),
              Text(
                'PassportTastic',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40.sp,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
