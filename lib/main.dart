import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:scanguard/Home/mainScreenHome.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Utils/keys.dart';
import 'onbaording/onboarding.dart';

class AppBloc {
  final _onboardingController = StreamController<bool>.broadcast();

  Stream<bool> get onboardingStream => _onboardingController.stream;

  void checkOnboardingStatus() async {
    _prefs = await SharedPreferences.getInstance();
    bool shownOnboarding = _prefs?.getBool('shownOnboarding') ?? true;
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');

    if (shownOnboarding) {
      if (userID != null) {
        _onboardingController.sink.add(true); // User is logged in
      } else {
        _onboardingController.sink.add(false); // User is not logged in
      }
    } else {
      _onboardingController.sink.add(false); // Onboarding not shown
    }
  }

  void dispose() {
    _onboardingController.close();
  }
}

final appBloc = AppBloc();

SharedPreferences? _prefs;
SharedPreferences? prefs;
String? userID;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize(appId);
  String? token;
  var ID4 = OneSignal.User.pushSubscription.id;
  print("ID4 $ID4");

  token = OneSignal.User.pushSubscription.id;
  print("token: $token");
// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);
  _prefs = await SharedPreferences.getInstance();
  bool shownOnboarding = _prefs?.getBool('shownOnboarding') ?? false;
  Stripe.publishableKey = stripeTestKey;
  await Stripe.instance.applySettings();
  runApp(MyApp(shownOnboarding: shownOnboarding));
  // runApp(
  //   DevicePreview(
  //     enabled: true,
  //     builder: (context) => MyApp(shownOnboarding: shownOnboarding),
  //   ),
  // );
}

class MyApp extends StatefulWidget {
  final bool shownOnboarding;
  const MyApp({Key? key, required this.shownOnboarding}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final bool _splitScreenMode = false;
  @override
  void initState() {
    super.initState();
    appBloc.checkOnboardingStatus();
  }

  @override
  void dispose() {
    appBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: _splitScreenMode,
      child: Builder(builder: (BuildContext context) {
        return Screenshot(
          controller: screenshotController,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: const Color(0xFF00AEFF)),
              useMaterial3: true,
            ),
            home: StreamBuilder<bool>(
              stream: appBloc.onboardingStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == true) {
                    return const MainScreen();
                  } else {
                    return const Onboard();
                  }
                } else {
                  return const SplashScreen();
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
ScreenshotController screenshotController = ScreenshotController();
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), () {
      appBloc.checkOnboardingStatus();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
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
        ],
      ),
    );
  }
}

