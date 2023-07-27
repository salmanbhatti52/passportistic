import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scanguard/Home/stampPage.dart';

import 'dirayPage.dart';
import 'homePage.dart';
import 'navbar.dart';
import '../Profile/profilePage.dart';

class MainScreen extends StatefulWidget {
  final String? userId;
  final String? email;
  final String? phone;
  final String? firstname;
  final String? lastname;
  final String? profile;

  
  const MainScreen({super.key, this.userId, this.email, this.phone, this.firstname, this.lastname, this.profile});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFF00AEFF),

      bottomNavigationBar: NavBar(),
    );
  }

  getbody() {
    List<Widget> pages = [
      HomePage(),
      DirayPage(),
      StampPage(),
      ProfilePage(),
    ];
    return IndexedStack(
      index: pageindex,
      children: pages,
    );
  }

  Widget bottombar() {
    List bottemitems = [
      pageindex == 0 ? "assets/home2.svg" : "assets/home1.svg",
      pageindex == 1 ? "assets/note2.svg" : "assets/notes1.svg",
      pageindex == 2 ? "assets/stamp2.svg" : "assets/stamp1.svg",
      pageindex == 3 ? "assets/account2.svg" : "assets/account1.svg",
    ];
    List bottomText = [
      "Home",
      "  Itinerary &\nTravel Diary",
      "Purchase \n  Stamp",
      "Account",
    ];
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                  bottemitems.length,
                  (index) => InkWell(
                        onTap: () {
                          selectedTab(index);
                        },
                        child: SvgPicture.asset(
                          bottemitems[index],
                        ),
                      )),
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                bottomText.length,
                (index) => InkWell(
                    onTap: () {
                      selectedTab(index);
                    },
                    child: Text(
                      bottomText[index],
                      style: TextStyle(
                        fontFamily: "Outfit",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: pageindex == index
                            ? Colors.black
                            : Color(0xFFC1C1C1),
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getAppBar() {
    if (pageindex == 0) {
    } else if (pageindex == 1) {
      return AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
              // Add your onPressed code here
            },
          );
        }),
        automaticallyImplyLeading: false,
        title: const Text(
          "Chat",
          style: TextStyle(
              fontFamily: "Outfit",
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w400),
        ),
        backgroundColor: const Color(0xFF2B65EC),
        centerTitle: true,
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: SvgPicture.asset(
          //     "assets/notification1.svg",
          //     width: 20,
          //     height: 20,
          //     color: Colors.white,
          //   ),
          // ),
        ],
      );
    } else if (pageindex == 2) {
      return AppBar(
        backgroundColor: const Color(0xFF2B65EC),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
              // Add your onPressed code here
            },
          );
        }),
        automaticallyImplyLeading: false,
        title: const Text(
          "Wallet",
          style: TextStyle(
              fontFamily: "Outfit",
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      );
    } else {
      return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          // IconButton(
          //   onPressed: () {
          //     // Navigator.push(context, MaterialPageRoute<void>(
          //     //   builder: (BuildContext context) {
          //     //     return UpdateProfie(
          //     //       userId: userID ?? "${widget.userId}",
          //     //     );
          //     //   },
          //     // ));
          //   },
          //   icon: SvgPicture.asset(
          //     "assets/edit.svg",
          //     width: 20,
          //     height: 20,
          //   ),
          // ),
        ],
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
              // Add your onPressed code here
            },
          );
        }),
        automaticallyImplyLeading: false,
        title: const Text(
          "Profile",
          style: TextStyle(
              fontFamily: "Outfit",
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      );
    }
  }

  selectedTab(index) {
    setState(() {
      pageindex = index;
    });
  }

  int pageindex = 0;
  bool exit = false;
}
