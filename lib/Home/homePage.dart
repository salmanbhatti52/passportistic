import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scanguard/Home/stampPage.dart';

import '../HomeButtons/addItinerary.dart';
import '../HomeButtons/arrivalDetails.dart';
import '../HomeButtons/depature.dart';
import '../HomeButtons/passport.dart';
import 'appDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: AppDrawer(),
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
        backgroundColor: Colors.white,
        // backgroundColor: Color(0xFF00AEFF),
        body: Builder(builder: (context) {
          return Column(
            children: [
              Expanded(
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
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 1, left: 10, right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 30, left: 10),
                                  child: Builder(builder: (context) {
                                    return GestureDetector(
                                      onTap: () {
                                        Scaffold.of(context).openDrawer();
                                      },
                                      child: SvgPicture.asset(
                                        "assets/menu.svg",
                                      ),
                                    );
                                  }),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 30, right: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Navigator.pushNamed(context, '/notification');
                                    },
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
                                    child: Container(
                                      // margin: EdgeInsets.only(top: 80, right: 210, left: 20),
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage(
                                            "https://images.pexels.com/photos/17457999/pexels-photo-17457999/free-photo-of-a-garbage-collector.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Welcome Home",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF73848C),
                                          ),
                                        ),
                                        Text(
                                          "John Doe",
                                          style: TextStyle(
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
                                      return DepatureDetails();
                                    },
                                  ));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.0001,
                                  ),
                                  height:
                                      MediaQuery.of(context).size.width * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Stamp Passport",
                                              style: TextStyle(
                                                fontFamily: "Satoshi",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFF000000)
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              " Departure",
                                              style: TextStyle(
                                                fontFamily: "Satoshi",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFFF65734),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: SvgPicture.asset(
                                            "assets/arrow.svg",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return ArrivalDetails();
                                    },
                                  ));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.0001,
                                  ),
                                  height:
                                      MediaQuery.of(context).size.width * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Stamp Passport",
                                              style: TextStyle(
                                                fontFamily: "Satoshi",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFF000000)
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              " Arrival",
                                              style: TextStyle(
                                                fontFamily: "Satoshi",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFFF65734),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: SvgPicture.asset(
                                            "assets/arrow.svg",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return ViewPassport();
                                    },
                                  ));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.0001,
                                  ),
                                  height:
                                      MediaQuery.of(context).size.width * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              " View Passport",
                                              style: TextStyle(
                                                fontFamily: "Satoshi",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFFF65734),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: SvgPicture.asset(
                                            "assets/arrow.svg",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return StampPage();
                                    },
                                  ));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.0001,
                                  ),
                                  height:
                                      MediaQuery.of(context).size.width * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              " Purchase Stamps",
                                              style: TextStyle(
                                                fontFamily: "Satoshi",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFFF65734),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: SvgPicture.asset(
                                            "assets/arrow.svg",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return AddItineray();
                                    },
                                  ));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.0001,
                                  ),
                                  height:
                                      MediaQuery.of(context).size.width * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Add/Edit itinerary or \nTravel Diary ",
                                              style: TextStyle(
                                                fontFamily: "Satoshi",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFFF65734),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: SvgPicture.asset(
                                            "assets/arrow.svg",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                            ]),
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          );
        }),
      ),
    );
  }
}
