import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AppDrawerButtons/aboutUs.dart';
import '../AppDrawerButtons/contact.dart';
import '../AppDrawerButtons/faq.dart';
import '../AppDrawerButtons/privaacy.dart';
import '../AppDrawerButtons/terms.dart';
import '../auth/signIn.dart';
import 'mainScreenHome.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: IconTheme(
          data: const IconThemeData(), // Change this to the desired color
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Color(0xFF00AEFF),
              image: DecorationImage(
                image: AssetImage("assets/bg.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: SvgPicture.asset(
                            "assets/log1.svg",
                            height: 35.h,
                            width: 120.w,
                          ),
                        ),
                        Text(
                          'PassportTastic',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: const Color(0xFF565656),
                              fontSize: 31.sp,
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5),
                        ),
                      ],
                    ),
                  ],
                ), // Add your drawer header here
                Builder(
                  builder: (context) {
                    return ListTile(
                      leading: SvgPicture.asset(
                        "assets/home1.svg",
                        color: Colors.black,
                      ),
                      title: const Text(
                        'Home',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const MainScreen()),
                        );
                        // Close the drawer using openEndDrawer()
                        // Do something
                      },
                    );
                  },
                ),
                // ListTile(
                //   leading: SvgPicture.asset(
                //     "assets/bn.svg",
                //     color: Colors.black,
                //   ),
                //   title: const Text(
                //     'Notifications',
                //     style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 20,
                //       fontFamily: 'Satoshi',
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                //   onTap: () {
                //     Scaffold.of(context)
                //         .openEndDrawer(); // Close the drawer using openEndDrawer()
                //     // Do something
                //   },
                // ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/info.svg",
                    color: Colors.black,
                  ),
                  title: const Text(
                    'About',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const AboutUs();
                      },
                    ));
                    // Close the drawer using openEndDrawer()
                    // Do something
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/at.svg",
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Contact Us',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const ContactUs();
                      },
                    ));
                    // Close the drawer using openEndDrawer()
                    // Do something
                  },
                ),
                // ListTile(
                //   leading: SvgPicture.asset(
                //     "assets/payment.svg",
                //     color: Colors.black,
                //   ),
                //   title: const Text(
                //     'Payment',
                //     style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 20,
                //       fontFamily: 'Satoshi',
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                //   onTap: () {
                //     Navigator.push(context, MaterialPageRoute(
                //       builder: (BuildContext context) {
                //         return const GpayAPay();
                //       },
                //     ));
                //     // Close the drawer using openEndDrawer()
                //     // Do something
                //   },
                // ),
                // ListTile(
                //   leading: SvgPicture.asset(
                //     "assets/star.svg",
                //     color: Colors.black,
                //   ),
                //   title: const Text(
                //     'Rate Our App',
                //     style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 20,
                //       fontFamily: 'Satoshi',
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                //   onTap: () {
                //     Scaffold.of(context)
                //         .openEndDrawer(); // Close the drawer using openEndDrawer()
                //     // Do something
                //   },
                // ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/fqa.svg",
                    color: Colors.black,
                  ),
                  title: const Text(
                    "FQA's",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const FAQ();
                      },
                    ));
                    // Close the drawer using openEndDrawer()
                    // Do something
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/terms.svg",
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Terms & Conditions',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const TermsConditions();
                      },
                    ));
                    // Close the drawer using openEndDrawer()
                    // Do something
                  },
                ),

                ListTile(
                  leading: SvgPicture.asset(
                    "assets/pp.svg",
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Privacy Policy',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const PrivacyPolicy();
                      },
                    ));
                    // Close the drawer using openEndDrawer()
                    // Do something
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/logOut.svg",
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    removeDataFormSharedPreferences();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const SignInPage()),
                      (Route<dynamic> route) => false,
                    );
                    // Close the drawer using openEndDrawer()
                    // Do something
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  removeDataFormSharedPreferences() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.clear();
    setState(() {});
  }
}
