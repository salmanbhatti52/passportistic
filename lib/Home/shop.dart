import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scanguard/Home/mainScreenHome.dart';
import 'Shop/buyPassportPages.dart';
import 'Shop/buyStamps.dart';
import 'appDrawer.dart';

class StampPage extends StatefulWidget {
  const StampPage({Key? key}) : super(key: key);

  @override
  _StampPageState createState() => _StampPageState();
}

class _StampPageState extends State<StampPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = ScreenUtil().screenWidth;
    int crossAxisCount;

    // Determine the appropriate crossAxisCount based on screen width
    if (screenWidth <= 320) {
      crossAxisCount = 2;
    } else if (screenWidth <= 640) {
      crossAxisCount = 3;
    } else if (screenWidth <= 960) {
      crossAxisCount = 4;
    } else {
      crossAxisCount = 5;
    }
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          forceMaterialTransparency: true,
          centerTitle: true,
          title: const Text(
            'Shop',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFF65734),
              fontSize: 24,
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: Builder(builder: (context) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const MainScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  "assets/arrowBack1.svg",
                ),
              ),
            );
          }),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: SvgPicture.asset(
                "assets/notification.svg",
                // fit: BoxFit.scaleDown,
              ),
            ),
          ],
          // backgroundColor: const Color(0xFFF65734).withOpacity(0.90),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 327,
                height: 50,
                // height: height * 0.075,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16),
                  color: const Color.fromRGBO(248, 249, 251, 1),
                ),
                child: TabBar(
                  // physics: const AlwaysScrollableScrollPhysics(),
                  // controller: _tabController,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  labelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor: const Color(0xffA7A9B7),
                  //isScrollable: true,
                  dividerColor: const Color.fromRGBO(248, 249, 251, 1),
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: "Outfit",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  indicatorColor: Colors.pink,
                  //
                  indicator: BoxDecoration(
                    // border: Border(top: 10, left: 10, right: 10, bottom: ),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFF65734),
                  ),
                  tabs: [
                    Container(
                      width: 160,
                      height: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        // color: Color.fromRGBO(248, 249, 251, 1),
                      ),
                      child: const Tab(
                        text: "Stamps",
                      ),
                    ),
                    Container(
                      width: 160,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(16),
                        // color: Color.fromRGBO(248, 249, 251, 1),
                      ),
                      child: const Tab(
                        text: "Others",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
              child: TabBarView(
                physics: ScrollPhysics(),
                //physics: NeverScrollableScrollPhysics(),
                // physics: AlwaysScrollableScrollPhysics(),
                // controller: _tabController,
                children: [
                  BuyStamps(),
                  BuyPassportPages(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
