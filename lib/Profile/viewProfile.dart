import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'editProfile.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Color(0xFF525252)),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFC6FFE7),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              "assets/arrowLeft.svg",
              width: 20,
              height: 20,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset("assets/edit.svg"),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFC6FFE7),
                Color(0xFF00AEFF),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network(
                      "https://images.pexels.com/photos/17457999/pexels-photo-17457999/free-photo-of-a-garbage-collector.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                      fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Center(
              child: Text(
                "Jhon Deo",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF000000)),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/phone.svg',
                      color: Color(0xFfFF8D74),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Mobile Number',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF525252)),
                    ),
                    Spacer(),
                    Text(
                      '(209) 456-7890',
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF000000)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/sms.svg',
                      color: Color(0xFfFF8D74),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Email',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF525252)),
                    ),
                    Spacer(),
                    Text(
                      "JhonDeo@gmail.com",
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF000000)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/gender.svg',
                      color: Color(0xFfFF8D74),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Gender',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF525252)),
                    ),
                    Spacer(),
                    Text(
                      "Male",
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF000000)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/calendar.svg',
                      color: Color(0xFfFF8D74),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Date of Birth',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF525252)),
                    ),
                    Spacer(),
                    Text(
                      "19/08/1990",
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF000000)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/flag.svg',
                      color: Color(0xFfFF8D74),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Nationality',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF525252)),
                    ),
                    Spacer(),
                    Text(
                      'USA',
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF000000)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/terms.svg',
                      color: Color(0xFfFF8D74),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Change Passport Design',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF525252)),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .12,
            ),
            // Spacer(),
            Center(child: Image.asset("assets/passport.png"))
          ]),
        )),
      ),
    );
  }
}
