import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DisplayDiary extends StatefulWidget {
  @override
  _DisplayDiaryState createState() => _DisplayDiaryState();
}

class _DisplayDiaryState extends State<DisplayDiary> {
  File? imagePathGallery;
  String? base64imgGallery;
  File? imagePathGallery1;
  String? base64imgGallery1;

  Future pickImageGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
      if (xFile == null) {
        // Handle if no image is selected
      } else {
        Uint8List imageBytes = await xFile.readAsBytes();
        base64imgGallery = base64.encode(imageBytes);
        print("base64img $base64imgGallery");

        final imageTemporary = File(xFile.path);

        setState(() {
          imagePathGallery = imageTemporary;
          print("newImage $imagePathGallery");
          print("newImage64 $base64imgGallery");
        });
      }
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageGallery1() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
      if (xFile == null) {
        // Handle if no image is selected
      } else {
        Uint8List imageBytes = await xFile.readAsBytes();
        base64imgGallery1 = base64.encode(imageBytes);
        print("base64img $base64imgGallery1");

        final imageTemporary = File(xFile.path);

        setState(() {
          imagePathGallery1 = imageTemporary;
          print("newImage $imagePathGallery1");
          print("newImage64 $base64imgGallery1");
        });
      }
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  TextEditingController comments = TextEditingController();

  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'UK 2023',
          style: TextStyle(
            color: Color(0xFF525252),
            fontSize: 24,
            fontFamily: 'Satoshi',
            fontWeight: FontWeight.w900,
          ),
        ),
        elevation: 0,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TableCalendar(
                  headerStyle: HeaderStyle(
                    headerPadding: EdgeInsets.all(8),
                    titleCentered: true,
                    formatButtonVisible: false, // Hide the format button
                    titleTextFormatter: (date, _) =>
                        DateFormat.MMMM().format(date) +
                        ' ' +
                        DateFormat.y()
                            .format(date), // Format the month and year
                    titleTextStyle: TextStyle(
                      color: Color(0xFF525252),
                      fontSize: 16,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w700,
                    ),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Color(0xFFF65734),
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Color(0xFFF65734),
                    ),
                  ),
                  // daysOfWeekStyle: DaysOfWeekStyle(
                  //     weekdayStyle: TextStyle(
                  //         letterSpacing: 0.4, color: Color(0xFFE0E0E5))),
                  calendarStyle: CalendarStyle(
                    todayTextStyle: TextStyle(color: Colors.black),
                    selectedDecoration: BoxDecoration(
                        color: Color(0xFFF65734), // Color of the selected day
                        borderRadius: BorderRadius.circular(
                            10) // Shape of the selected day
                        ),
                    todayDecoration: BoxDecoration(
                      color: Colors.transparent, // Color of the today day
                      shape: BoxShape.rectangle, // Shape of the today day
                    ),
                  ),
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = selectedDay;
                      _calendarFormat = CalendarFormat.week;
                      print(_selectedDay);
                    });
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
              ),
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    maxLines: null,
                    style:
                        const TextStyle(color: Color(0xFF000000), fontSize: 16),
                    cursorColor: const Color(0xFF000000),
                    controller: comments,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          "assets/edit1.svg",
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFF65734)),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      // labelText: 'Email',
                      hintText: "Comments",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            color: Color(0xFFF3F3F3)), // change border color
                      ),
                      labelStyle: const TextStyle(),
                      hintStyle: const TextStyle(
                          color: Color(0xFFA7A9B7),
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Satoshi"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 10),
              child: Row(
                children: [
                  Text(
                    'Upload Pictures',
                    style: TextStyle(
                      color: Color(0xFFF65734),
                      fontSize: 16,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: Center(
                      child: imagePathGallery != null
                          ? Image.memory(
                              imagePathGallery!.readAsBytesSync(),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      pickImageGallery();
                                    },
                                    child: SvgPicture.asset("assets/addP.svg"))
                              ],
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: Center(
                      child: imagePathGallery1 != null
                          ? Image.memory(
                              imagePathGallery1!.readAsBytesSync(),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      pickImageGallery1();
                                    },
                                    child: SvgPicture.asset("assets/addP.svg"))
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 330,
                height: 48,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [Color(0xFFFF8D74), Color(0xFFF65634)],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Display Travel Diary',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Shared with',
                    style: TextStyle(
                      color: Color(0xFFF65734),
                      fontSize: 16,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/16377866/pexels-photo-16377866/free-photo-of-woman-wearing-dress-on-meadow.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load"),
                              fit: BoxFit.fill,
                            ),
                            shape: OvalBorder(),
                          ),
                        ),
                        Text(
                          'Eleanor Pena',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/14142370/pexels-photo-14142370.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                              fit: BoxFit.fill,
                            ),
                            shape: OvalBorder(),
                          ),
                        ),
                        Text(
                          'Bella Adison',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/17309792/pexels-photo-17309792/free-photo-of-woman-with-red-roses-posing-in-nature.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                              fit: BoxFit.fill,
                            ),
                            shape: OvalBorder(),
                          ),
                        ),
                        Text(
                          'Cameron \nWilliamson',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/17253417/pexels-photo-17253417/free-photo-of-light-fashion-people-woman.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                              fit: BoxFit.fill,
                            ),
                            shape: OvalBorder(),
                          ),
                        ),
                        Text(
                          'Brooklyn \nSimmons',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/17585373/pexels-photo-17585373.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                              fit: BoxFit.fill,
                            ),
                            shape: OvalBorder(),
                          ),
                        ),
                        Text(
                          'Ralph \nEdwards',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/6640696/pexels-photo-6640696.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                              fit: BoxFit.fill,
                            ),
                            shape: OvalBorder(),
                          ),
                        ),
                        Text(
                          'Floyd Miles',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 300,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'Share Using',
                                style: TextStyle(
                                  color: Color(0xFFF65734),
                                  fontSize: 24,
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildSocialIcon(iconData: Icons.facebook),
                                  buildSocialIcon(
                                      iconData: Icons.picture_in_picture_sharp),
                                  buildSocialIcon(iconData: Icons.whatshot),
                                  buildSocialIcon(iconData: Icons.link),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: 330,
                  height: 48,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.50, color: Color(0xFFFF8D74)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Share Details',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFFF8D74),
                          fontSize: 20,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSocialIcon({required IconData iconData}) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.withOpacity(0.2),
      ),
      child: Icon(
        iconData,
        size: 40,
        color: Colors.black,
      ),
    );
  }
}
