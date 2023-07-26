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
    );
  }
}
