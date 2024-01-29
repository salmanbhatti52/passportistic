import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scanguard/Home/shop.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../HomeButtons/addItinerary.dart';
import '../HomeButtons/arrivalDetails.dart';
import '../HomeButtons/depature.dart';
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
  GetProfileModels getProfileModels = GetProfileModels();
  getUserProfile() async {
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
      return Scaffold(
        backgroundColor: Colors.white,
        drawer: const AppDrawer(),
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(70),
        //   child: AppBar(
        //       flexibleSpace: Container(
        //         height: 70,
        //         decoration: BoxDecoration(
        //           gradient: LinearGradient(
        //             colors: [
        //               Color(0xFFC6FFE7),
        //               Color.fromARGB(255, 198, 255, 247),
        //             ],
        //             begin: Alignment.topLeft,
        //             end: Alignment.centerRight,
        //           ),
        //         ),
        //       ),
        //       leading: Builder(builder: (context) {
        //         return GestureDetector(
        //           onTap: () {
        //             Scaffold.of(context).openDrawer();
        //           },
        //           child: Padding(
        //             padding: const EdgeInsets.only(top: 20.0, left: 8),
        //             child: SvgPicture.asset(
        //               "assets/menu.svg",
        //               width: 40,
        //               height: 40,
        //               fit: BoxFit.scaleDown,
        //             ),
        //           ),
        //         );
        //       }),
        //       actions: [
        //         Padding(
        //           padding: const EdgeInsets.only(top: 20.0, right: 8),
        //           child: SvgPicture.asset(
        //             "assets/notification.svg",
        //             width: 40,
        //             height: 40,
        //             fit: BoxFit.scaleDown,
        //           ),
        //         )
        //       ]),
        // ),

        // backgroundColor: Color(0xFF00AEFF),
        body: Builder(builder: (context) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      // height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        color: Color(0xFF00AEFF),
                        image: DecorationImage(
                          image: AssetImage("assets/bg.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            left: 4,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Builder(builder: (context) {
                                    return GestureDetector(
                                      onTap: () {
                                        Scaffold.of(context).openDrawer();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                          "assets/menu.svg",
                                        ),
                                      ),
                                    );
                                  }),
                                  Center(
                                    child: SvgPicture.asset(
                                      "assets/log1.svg",
                                      height: 35.h,
                                      width: 108.w,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.pushNamed(context, '/notification');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                        "assets/notification.svg",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 15),
                                      child: getProfileModels
                                                  .data?.profilePicture !=
                                              null
                                          ? Container(
                                              child: CircleAvatar(
                                                radius: 25,
                                                backgroundImage: NetworkImage(
                                                    "https://portal.passporttastic.com/public/${getProfileModels.data!.profilePicture}"),
                                              ),
                                            )
                                          : const SizedBox(
                                              child: CircularProgressIndicator(
                                                color: Color(0xFFF65734),
                                              ),
                                            ), // Don't render anything if profilePicture is null
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Welcome Home",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF73848C),
                                            ),
                                          ),
                                          Text(
                                            "${getProfileModels.data?.firstName ?? ''} ${getProfileModels.data?.lastName ?? ''}",
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF452933),
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
                                  // height:
                                  //     207, // Adjust the fit as per your requirement
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return const DepatureDetails();
                                      },
                                    ));
                                  },
                                  child: Container(
                                    width: 294,
                                    height: 72,
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
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 16,
                                          top: 12,
                                          child: Text(
                                            'Stamp Passport',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 16,
                                              fontFamily: 'Satoshi',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        const Positioned(
                                          left: 16,
                                          top: 38,
                                          child: Text(
                                            'Departure',
                                            style: TextStyle(
                                              color: Color(0xFFF65734),
                                              fontSize: 16,
                                              fontFamily: 'Satoshi',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 238,
                                          top: 16,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
                                                  return DepatureDetails(
                                                    userId: userID,
                                                  );
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
                                        return const ArrivalDetails();
                                      },
                                    ));
                                  },
                                  child: Container(
                                    width: 294,
                                    height: 72,
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
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 16,
                                          top: 12,
                                          child: Text(
                                            'Stamp Passport',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 16,
                                              fontFamily: 'Satoshi',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        const Positioned(
                                          left: 16,
                                          top: 38,
                                          child: Text(
                                            'Arrival ',
                                            style: TextStyle(
                                              color: Color(0xFFF65734),
                                              fontSize: 16,
                                              fontFamily: 'Satoshi',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 238,
                                          top: 16,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
                                                  return const ArrivalDetails();
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
                                        return const ViewPassport();
                                      },
                                    ));
                                  },
                                  child: Container(
                                    width: 294,
                                    height: 72,
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
                                    child: Stack(
                                      children: [
                                        const Positioned(
                                          left: 16,
                                          top: 25,
                                          child: Text(
                                            'View Passport',
                                            style: TextStyle(
                                              color: Color(0xFFF65734),
                                              fontSize: 16,
                                              fontFamily: 'Satoshi',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 238,
                                          top: 16,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
                                                  return const ViewPassport();
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
                                        return const StampPage();
                                      },
                                    ));
                                  },
                                  child: Container(
                                    width: 294,
                                    height: 72,
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
                                    child: Stack(
                                      children: [
                                        const Positioned(
                                          left: 16,
                                          top: 25,
                                          child: Text(
                                            'Shop',
                                            style: TextStyle(
                                              color: Color(0xFFF65734),
                                              fontSize: 16,
                                              fontFamily: 'Satoshi',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 238,
                                          top: 16,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
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
                                    width: 294,
                                    height: 72,
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
                                    child: Stack(
                                      children: [
                                        const Positioned(
                                          left: 16,
                                          top: 14,
                                          child: Text(
                                            'Add/Edit itinerary or \nTravel Diary ',
                                            style: TextStyle(
                                              color: Color(0xFFF65734),
                                              fontSize: 16,
                                              fontFamily: 'Satoshi',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 238,
                                          top: 16,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
                                                  return AddItineray(
                                                    userId: userID,
                                                  );
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
                                  height: 7,
                                ),
                              ]),
                            ],
                          ),
                        ),
                      )),
                ),
              ],
            ),
          );
        }),
      );
    }
  }
}
