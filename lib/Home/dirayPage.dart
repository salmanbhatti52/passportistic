import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scanguard/Home/appDrawer.dart';

import '../HomeButtons/addItinerary2.dart';
import '../HomeButtons/AdditineraryDetails/displayDiray.dart';

class DirayPage extends StatefulWidget {
  const DirayPage({super.key});

  @override
  State<DirayPage> createState() => _DirayPageState();
}

class _DirayPageState extends State<DirayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        elevation: 0,
        leading: Builder(builder: (context) {
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
        actions: [
          GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, '/notification');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                "assets/notification.svg",
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  "Itinerary & Travel Diary",
                  style: TextStyle(
                      fontFamily: "Satoshi",
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF525252)),
                ),
              ),
            ],
          ),
          Center(
              child: Image.asset(
            "assets/art.png",
            width: 190,
            height: 200,
          )),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return const ItineraryTwo(
                      //userId: widget.userId,
                      // itinid: desiredItineraryId,
                      // additinerarywidget: addItineray.text,
                      );
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
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Itinerary',
                    style: TextStyle(
                      color: Color(0xFF525252),
                      fontSize: 16,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 159),
                  SizedBox(
                    width: 40,
                    height: 41,
                    child: Stack(
                      children: [
                        SvgPicture.asset("assets/blueArrow.svg"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return DisplayDiary(
                      //userId: widget.userId,
                      // itinid: desiredItineraryId,
                      // additinerarywidget: addItineray.text,
                      );
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
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Travel Diary',
                    style: TextStyle(
                      color: Color(0xFF525252),
                      fontSize: 16,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 134),
                  SizedBox(
                    width: 40,
                    height: 41,
                    child: Stack(
                      children: [
                        SvgPicture.asset("assets/blueArrow.svg"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
