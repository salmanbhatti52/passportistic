import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dirayPage.dart';
import 'homePage.dart';
import '../Profile/profilePage.dart';
import 'stampPage.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index = 0;
  final screens = const [
    HomePage(),
    DirayPage(),
    StampPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    Color scaffoldColor = index == 0 ? Color(0xFF00AEFF) : Colors.white;
    return WillPopScope(
      onWillPop: () async {
        // When the back button is pressed, exit the app
        SystemNavigator.pop();
        return false;
      },
      child: Padding(
        padding: EdgeInsets.only(top: 28),
        child: Scaffold(
          backgroundColor: scaffoldColor,
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black.withOpacity(0.5),
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 10,
              unselectedFontSize: 10,
              currentIndex: index,
              onTap: (int newIndex) {
                setState(() {
                  index = newIndex;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/home1.svg'),
                  activeIcon: SvgPicture.asset('assets/home2.svg'),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/notes1.svg'),
                  activeIcon: SvgPicture.asset('assets/note2.svg'),
                  label: ' Itinerary &\nTravel Diary',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/stamp1.svg'),
                  activeIcon: SvgPicture.asset('assets/stamp2.svg'),
                  label: 'Stamp',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/account1.svg'),
                  activeIcon: SvgPicture.asset('assets/account2.svg'),
                  label: 'Profile',
                ),
              ],
            ),
          ),
          body: screens[index],
        ),
      ),
    );
  }

  getAppBar() {
    if (index == 0) {
    } else if (index == 1) {
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
    } else if (index == 2) {
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
      index = index;
    });
  }

  bool exit = false;
}
