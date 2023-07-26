import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'itineraryDetails.dart/accomodationDetails.dart';
import 'itineraryDetails.dart/activitiesDetails.dart';
import 'itineraryDetails.dart/displayDiray.dart';
import 'itineraryDetails.dart/travalDetails.dart';

class ItineraryTwo extends StatefulWidget {
  const ItineraryTwo({super.key});

  @override
  State<ItineraryTwo> createState() => _ItineraryTwoState();
}

class _ItineraryTwoState extends State<ItineraryTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Itinerary',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF004665),
            fontSize: 24,
            fontFamily: 'Satoshi',
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0,
        backgroundColor: Color(0xFFC6FFE7),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              "assets/arrowBack1.svg",
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset("assets/notification.svg"),
          )
        ],
      ),
      body: Column(children: [
        Expanded(
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.20, -0.98),
                end: Alignment(-0.2, 0.98),
                colors: [Color(0xFFC6FFE7), Color(0xFF00AEFF)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1),
              ),
            ),
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'UK 2023',
                  style: TextStyle(
                    color: Color(0xFF525252),
                    fontSize: 24,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) {
                      return TravelDetails();
                    },
                  ));
                },
                child: Container(
                  width: 294,
                  height: 60,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x0F312E23),
                        blurRadius: 16,
                        offset: Offset(0, 8),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Travel Details',
                          style: TextStyle(
                            color: Color(0xFF525252),
                            fontSize: 16,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SvgPicture.asset("assets/blueArrow.svg"),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) {
                      return AccommodationDetails();
                    },
                  ));
                },
                child: Container(
                  width: 294,
                  height: 60,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x0F312E23),
                        blurRadius: 16,
                        offset: Offset(0, 8),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Accommodation Details',
                          style: TextStyle(
                            color: Color(0xFF525252),
                            fontSize: 16,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SvgPicture.asset("assets/blueArrow.svg"),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ActivitiesDetails();
                    },
                  ));
                },
                child: Container(
                  width: 294,
                  height: 60,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x0F312E23),
                        blurRadius: 16,
                        offset: Offset(0, 8),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Activity Details',
                          style: TextStyle(
                            color: Color(0xFF525252),
                            fontSize: 16,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SvgPicture.asset("assets/blueArrow.svg"),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) {
                      return DisplayDiary();
                    },
                  ));
                },
                child: Container(
                  width: 294,
                  height: 60,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x0F312E23),
                        blurRadius: 16,
                        offset: Offset(0, 8),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.sp,
                      children: [
                        Text(
                          'Display Itinerary',
                          style: TextStyle(
                            color: Color(0xFF525252),
                            fontSize: 16,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SvgPicture.asset("assets/blueArrow.svg"),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        )
      ]),
    );
  }
}
