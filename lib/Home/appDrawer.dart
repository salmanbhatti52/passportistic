import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AppDrawerButtons/aboutUs.dart';
import '../AppDrawerButtons/contact.dart';
import '../AppDrawerButtons/gPayApay.dart';
import '../AppDrawerButtons/privaacy.dart';
import '../AppDrawerButtons/terms.dart';
import '../auth/signIn.dart';

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
            decoration: BoxDecoration(
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
                        SizedBox(
                          height: 50,
                        ),
                        SvgPicture.asset(
                          "assets/Logo.svg",
                          width: 80,
                          height: 80,
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
                      title: Text(
                        'Home',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Scaffold.of(context)
                            .openEndDrawer(); // Close the drawer using openEndDrawer()
                        // Do something
                      },
                    );
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/bn.svg",
                    color: Colors.black,
                  ),
                  title: Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Scaffold.of(context)
                        .openEndDrawer(); // Close the drawer using openEndDrawer()
                    // Do something
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/info.svg",
                    color: Colors.black,
                  ),
                  title: Text(
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
                        return AboutUs();
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
                  title: Text(
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
                        return ContactUs();
                      },
                    ));
                    // Close the drawer using openEndDrawer()
                    // Do something
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/payment.svg",
                    color: Colors.black,
                  ),
                  title: Text(
                    'Payment',
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
                        return GpayAPay();
                      },
                    ));
                    // Close the drawer using openEndDrawer()
                    // Do something
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/star.svg",
                    color: Colors.black,
                  ),
                  title: Text(
                    'Rate Our App',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Scaffold.of(context)
                        .openEndDrawer(); // Close the drawer using openEndDrawer()
                    // Do something
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/fqa.svg",
                    color: Colors.black,
                  ),
                  title: Text(
                    "FQA's",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Scaffold.of(context)
                        .openEndDrawer(); // Close the drawer using openEndDrawer()
                    // Do something
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/terms.svg",
                    color: Colors.black,
                  ),
                  title: Text(
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
                        return TermsConditions();
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
                  title: Text(
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
                        return PrivacyPolicy();
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
                  title: Text(
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
                      MaterialPageRoute(builder: (context) => SignInPage()),
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
