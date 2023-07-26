import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scanguard/Home/appDrawer.dart';

class DirayPage extends StatefulWidget {
  const DirayPage({super.key});

  @override
  State<DirayPage> createState() => _DirayPageState();
}

class _DirayPageState extends State<DirayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      // appBar: AppBar(
      //   elevation: 0,
      //   leading: Builder(builder: (context) {
      //     return GestureDetector(
      //       onTap: () {
      //         Scaffold.of(context).openDrawer();
      //       },
      //       child: Padding(
      //         padding: const EdgeInsets.only(top: 20, left: 8),
      //         child: SvgPicture.asset(
      //           "assets/menu.svg",
      //           fit: BoxFit.scaleDown,
      //         ),
      //       ),
      //     );
      //   }),
      //   actions: [
      //     GestureDetector(
      //       onTap: () {
      //         // Navigator.pushNamed(context, '/notification');
      //       },
      //       child: Padding(
      //         padding: const EdgeInsets.only(top: 20, right: 8),
      //         child: SvgPicture.asset(
      //           "assets/notification.svg",
      //           fit: BoxFit.scaleDown,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 10),
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
                padding: const EdgeInsets.only(top: 30, right: 10),
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
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
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
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {},
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Itinerary',
                    style: TextStyle(
                      color: Color(0xFF525252),
                      fontSize: 16,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 159),
                  Container(
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
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {},
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Travel Diary',
                    style: TextStyle(
                      color: Color(0xFF525252),
                      fontSize: 16,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 134),
                  Container(
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
