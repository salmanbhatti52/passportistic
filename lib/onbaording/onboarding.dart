import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../auth/signIn.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  // Future<bool> checkLoginStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? savedEmail = prefs.getString('Email');
  //   String? savedPassword = prefs.getString('Password');
  //   return savedEmail != null && savedPassword != null;
  // }

  // void navigateToNextScreen() async {
  //   LoginModel loginModel = LoginModel();

  //   bool isLoggedIn = await checkLoginStatus();
  //   Navigator.of(context).pushReplacement(
  //     MaterialPageRoute(
  //       builder: (context) => isLoggedIn
  //           ? HomePage(
  //               firstName: loginModel.data?.firstName ?? "",
  //               profile: loginModel.data?.profilePic ?? "",
  //               lastName: "${loginModel.data?.lastName ?? ""}",
  //               userId: "${loginModel.data?.usersCustomersId ?? ""}",
  //               email: loginModel.data?.email ?? "",
  //               number: loginModel.data?.phone ?? "")
  //           : Login(
  //               login: 0,
  //             ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // Set the background color to transparent
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF00AEFF), Color(0xFFC6FFE7)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topLeft,
                  ),
                ),
                child: Column(
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        "assets/background.svg",
                        width: MediaQuery.of(context).size.width * 0.350,
                        height: 155,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: SvgPicture.asset(
                            "assets/log1.svg",
                            height: 55,
                            width: 219,
                          ),
                        ),
                        const Text(
                          'PassportTastic',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.09),
                        const Text(
                          "Explore the \nBeauty of the \nWorld with us",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              fontFamily: "Satoshi"),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "If you like to travel, this is your place! Here you \ncan travel without hassle and enjoy it.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Satoshi",
                              color: Colors.black),
                        )
                      ],
                    ),
                    const Spacer(),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const SignInPage()),
                                (Route<dynamic> route) => false,
                              );
                            },
                            child: Container(
                              height: 48,
                              width: MediaQuery.of(context).size.width * 0.92,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFF65734),
                                    Color(0xFFFF8D74)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Get Started",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Outfit",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
