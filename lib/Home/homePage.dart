import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:passport_stamp/feature/stamp/presentation/stamp.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:scanguard/Home/shop.dart';
import 'package:http/http.dart' as http;
import 'package:scanguard/Utils/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../HomeButtons/addItinerary.dart';
import '../HomeButtons/PassportSection/passport.dart';
import '../Models/getProfileModels.dart';
import '../auth/signUpNextPage.dart';
import '../auth/signUpPage.dart';
import '../main.dart';
import 'appDrawer.dart';

class HomePage extends StatefulWidget {
  final String? userId;
  const HomePage({
    super.key,
    this.userId,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var logger = Logger();

  String? token;
  one() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.initialize(appId);

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.Notifications.requestPermission(true);

    token = OneSignal.User.pushSubscription.id ?? "123";
    print('token Response: $token');
    setState(() {});
  }

  GetProfileModels getProfileModels = GetProfileModels();
  getUserProfile() async {
    await one();
    String apiUrl = "$baseUrl/get_profile";
    print("api: $apiUrl");
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    if (!mounted) {
      return; // Check if the widget is still mounted
    }
    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": "$userID"
    });
    if (!mounted) {
      return; // Check again if the widget is still mounted after the HTTP request
    }
    final responseString = response.body;
    print("getProfileModels Response: $responseString");
    print("status Code getProfileModels: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 getProfileModels");
      print("SuucessFull");
      getProfileModels = getProfileModelsFromJson(responseString);
      if (!mounted) {
        return; // Check once more if the widget is still mounted before updating the state
      }
      setState(() {
        isLoading = false;
      });
      print('getProfileModels status: ${getProfileModels.status}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
            backgroundColor: Color(0xFFF65734),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      );
    } else {
      return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFFC6FFE7),
          // backgroundColor: const Color(0xFF00AEFF),
          drawer: const AppDrawer(),
          appBar: AppBar(
            backgroundColor: const Color(0xFFC6FFE7),
            forceMaterialTransparency: true,
            elevation: 0,
            centerTitle: true,
            title: Padding(
              padding: EdgeInsets.only(
                top: isMobile
                    ? 6.0
                    : (isTablet
                        ? 8.0
                        : 10.0), // Adjust padding for responsiveness
                // Adjust padding for responsiveness
              ),
              child: SvgPicture.asset(
                "assets/log1.svg",
                width: isMobile
                    ? 25
                    : (isTablet ? 35 : 40), // Adjust size based on screen type
                height: isMobile
                    ? 25
                    : (isTablet ? 35 : 40), // Adjust size based on screen type
                fit: BoxFit.scaleDown,
              ),
            ),
            leading: Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: isMobile
                          ? 6.0
                          : (isTablet
                              ? 8.0
                              : 10.0), // Adjust padding for responsiveness
                      left: isMobile
                          ? 8.0
                          : (isTablet
                              ? 10.0
                              : 12.0), // Adjust padding for responsiveness
                    ),
                    child: SvgPicture.asset(
                      "assets/menu.svg",
                      width: isMobile
                          ? 30
                          : (isTablet ? 35 : 40), // Adjust icon size
                      height: isMobile
                          ? 30
                          : (isTablet ? 35 : 40), // Adjust icon size
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                );
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(0.20, -0.98),
                  end: Alignment(-0.2, 0.98),
                  colors: [Color(0xFFC6FFE7), Color(0xFF00AEFF)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              child: Column(children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: isMobile ? 10 : (isTablet ? 12 : 15),
                        left: isMobile ? 15 : (isTablet ? 18 : 20),
                      ), // Adjust padding based on the screen size
                      child: getProfileModels.data?.profilePicture != null
                          ? CircleAvatar(
                              radius: isMobile
                                  ? 25
                                  : (isTablet ? 30 : 35), // Adjust avatar size
                              backgroundImage: NetworkImage(
                                "https://portal.passporttastic.com/public/${getProfileModels.data!.profilePicture}",
                              ),
                            )
                          : const SizedBox(
                              child: CircularProgressIndicator(
                                color: Color(0xFFF65734),
                              ),
                            ), // CircularProgressIndicator when profilePicture is null
                    ),
                    SizedBox(
                      width: isMobile
                          ? 10
                          : (isTablet
                              ? 15
                              : 20), // Adjust space between avatar and text
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: isMobile ? 20 : (isTablet ? 22 : 25),
                      ), // Adjust padding for text block
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Home",
                            style: TextStyle(
                              fontSize: isMobile ? 12 : (isTablet ? 15 : 18),
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF73848C),
                            ),
                          ),
                          Text(
                            "${getProfileModels.data?.firstName ?? ''} ${getProfileModels.data?.lastName ?? ''}",
                            style: TextStyle(
                              fontSize: isMobile
                                  ? 20
                                  : (isTablet
                                      ? 22
                                      : 24), // Adjust name text size
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF452933),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  "assets/Zain.svg",
                  fit: BoxFit.cover,
                  height: isMobile ? 150 : (isTablet ? 300 : 300),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return StampScreen();
                      },
                    ));
                  },
                  child: Container(
                    width: isMobile
                        ? 294
                        : (isTablet
                            ? 400
                            : 500), // Adjust width for tablet and desktop
                    height: isMobile ? 60 : (isTablet ? 80 : 100),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x0F312E23),
                          blurRadius: 16,
                          offset: Offset(0, 8),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            top: isMobile ? 10 : (isTablet ? 20 : 20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Stamp Passport',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize:
                                      isMobile ? 16 : (isTablet ? 20 : 20),
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '   Departure/Arrival',
                                style: TextStyle(
                                  color: const Color(0xFFF65734),
                                  fontSize:
                                      isMobile ? 16 : (isTablet ? 20 : 20),
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            right: 16,
                            top: isMobile ? 0 : (isTablet ? 6 : 6),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return StampScreen();
                                    },
                                  ));
                                  // Navigator.push(context, MaterialPageRoute(
                                  //   builder: (BuildContext context) {
                                  //     return DepatureDetails(
                                  //       userId: userID,
                                  //     );
                                  //   },
                                  // ));
                                },
                                child: SvgPicture.asset(
                                  "assets/arrow.svg",
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // const SizedBox(
                //   height: 8,
                // ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(context, MaterialPageRoute(
                //       builder: (BuildContext context) {
                //         return StampScreen();
                //       },
                //     ));
                //   },
                //   child: Container(
                //     width: 294,
                //     height: 72,
                //     decoration: ShapeDecoration(
                //       color: Colors.white,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(16),
                //       ),
                //       shadows: const [
                //         BoxShadow(
                //           color: Color(0x0F312E23),
                //           blurRadius: 16,
                //           offset: Offset(0, 8),
                //           spreadRadius: 0,
                //         )
                //       ],
                //     ),
                //     child: Stack(
                //       children: [
                //         Positioned(
                //           left: 16,
                //           top: 12,
                //           child: Text(
                //             'Stamp Passport',
                //             style: TextStyle(
                //               color: Colors.black.withOpacity(0.5),
                //               fontSize: 16,
                //               fontFamily: 'Satoshi',
                //               fontWeight: FontWeight.w400,
                //             ),
                //           ),
                //         ),
                //         const Positioned(
                //           left: 16,
                //           top: 38,
                //           child: Text(
                //             'Arrival ',
                //             style: TextStyle(
                //               color: Color(0xFFF65734),
                //               fontSize: 16,
                //               fontFamily: 'Satoshi',
                //               fontWeight: FontWeight.w700,
                //             ),
                //           ),
                //         ),
                //         Positioned(
                //           left: 238,
                //           top: 16,
                //           child: GestureDetector(
                //             onTap: () {
                //               Navigator.push(context, MaterialPageRoute(
                //                 builder: (BuildContext context) {
                //                   return StampScreen();
                //                 },
                //               ));
                //             },
                //             child: SvgPicture.asset(
                //               "assets/arrow.svg",
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const ViewPassport();
                      },
                    ));
                  },
                  child: Container(
                    width: isMobile
                        ? 294
                        : (isTablet
                            ? 400
                            : 500), // Adjust width for tablet and desktop
                    height: isMobile ? 60 : (isTablet ? 80 : 100),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x0F312E23),
                          blurRadius: 16,
                          offset: Offset(0, 8),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: isMobile ? 20 : (isTablet ? 28 : 28)),
                          child: Text(
                            'View Passport',
                            style: TextStyle(
                              color: const Color(0xFFF65734),
                              fontSize: isMobile ? 16 : (isTablet ? 20 : 20),
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const ViewPassport();
                              },
                            ));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: isMobile ? 16 : (isTablet ? 28 : 28),
                            ),
                            child: SvgPicture.asset(
                              "assets/arrow.svg",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const StampPage();
                      },
                    ));
                  },
                  child: Container(
                    width: isMobile
                        ? 294
                        : (isTablet
                            ? 400
                            : 500), // Adjust width for tablet and desktop
                    height: isMobile ? 60 : (isTablet ? 80 : 100),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x0F312E23),
                          blurRadius: 16,
                          offset: Offset(0, 8),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: isMobile ? 20 : (isTablet ? 28 : 28)),
                          child: Text(
                            'Shop',
                            style: TextStyle(
                              color: const Color(0xFFF65734),
                              fontSize: isMobile ? 16 : (isTablet ? 20 : 20),
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            right: isMobile ? 16 : (isTablet ? 28 : 28),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const StampPage();
                                },
                              ));
                            },
                            child: SvgPicture.asset(
                              "assets/arrow.svg",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const AddItineray();
                      },
                    ));
                  },
                  child: Container(
                    width: isMobile
                        ? 294
                        : (isTablet
                            ? 400
                            : 500), // Adjust width for tablet and desktop
                    height: isMobile ? 60 : (isTablet ? 80 : 100),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x0F312E23),
                          blurRadius: 16,
                          offset: Offset(0, 8),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: isMobile ? 20 : (isTablet ? 28 : 28)),
                          child: Text(
                            'Add/Edit itinerary or \nTravel Diary ',
                            style: TextStyle(
                              color: const Color(0xFFF65734),
                              fontSize: isMobile ? 16 : (isTablet ? 20 : 20),
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                                return AddItineray(
                                  userId: userID,
                                );
                              },
                            ));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: isMobile ? 16 : (isTablet ? 28 : 28),
                            ),
                            child: SvgPicture.asset(
                              "assets/arrow.svg",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                const Spacer()
              ]),
            ),
          ),
        ),
      );
    }
  }
}
