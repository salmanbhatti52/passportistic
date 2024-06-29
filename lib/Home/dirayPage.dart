import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scanguard/Home/appDrawer.dart';
import 'package:scanguard/Home/shop.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../HomeButtons/TravelDairy2Page/travelDairyView.dart';
import '../HomeButtons/VeiwItinerary2Page/viewDetails.dart';
import '../Models/validationModelAPI.dart';
import '../main.dart';

class DirayPage extends StatefulWidget {
  const DirayPage({super.key});

  @override
  State<DirayPage> createState() => _DirayPageState();
}

class _DirayPageState extends State<DirayPage> {
  bool load = false;
  ValidationModelApi validationModelApi = ValidationModelApi();
  validation() async {
    setState(() {
      load = true;
    });
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    var headersList = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var url =
        Uri.parse('https://portal.passporttastic.com/api/getPackageDetails');

    var body = {"passport_holder_id": "$userID"};

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode == 200) {
      validationModelApi = validationModelApiFromJson(resBody);
      print(resBody);
    } else {
      print(res.reasonPhrase);
      validationModelApi = validationModelApiFromJson(resBody);
    }
    if (mounted) {
      setState(() {
        load = false;
      });
    }
  }

  checkValidation() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      title: "You Don't Have Access",
      desc: 'Click OK to go to the shop page and buy Package.',
      btnCancelOnPress: () {
        Navigator.pop(context);
        // Close the dialog
      },
      btnOkOnPress: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const StampPage()));
        // Close the dialog
        // Navigate to the shop page (replace 'ShopPage' with your actual route)
      },
    ).show();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    validation();
  }

  @override
  Widget build(BuildContext context) {
    if (load == true) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            backgroundColor: Color(0xFFF65734),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 2,
          ),
        ),
      );
    } else {
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
                if (validationModelApi.data!.itineraryAccess == true) {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const itineraryview(
                          //userId: widget.userId,
                          // itinid: desiredItineraryId,
                          // additinerarywidget: addItineray.text,
                          );
                    },
                  ));
                } else {
                  checkValidation();
                }
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
                if (validationModelApi.data!.diaryAccess == true) {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const TravelDairySecondPage(
                          //userId: widget.userId,
                          // itinid: desiredItineraryId,
                          // additinerarywidget: addItineray.text,
                          );
                    },
                  ));
                } else {
                  checkValidation();
                }
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
}
