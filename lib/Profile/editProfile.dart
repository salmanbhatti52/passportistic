import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _flag = TextEditingController();
  TextEditingController _passportDesign = TextEditingController();



  bool isMaleSelected = false;
  bool isFemaleSelected = false;
  bool isOtherSelected = false;
  TextEditingController _email = TextEditingController();
  TextEditingController _gender = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    // final DateTime? picked = await showDatePicker(
    //   context: context,
    //   initialDate: DateTime.now(),
    //   firstDate: DateTime(1900),
    //   lastDate: DateTime.now(),
    //    // Set mode to only select the date
    // );
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2100),
    ).then((selectedDate) {
      if (selectedDate != null) {
        // Handle the selected date
        setState(() {
          // Date.text =
          // DateFormat.yMd().format(selectedDate);
          _dob.text = DateFormat('yyyy-MM-dd').format(selectedDate);
        });
      }
      return null;
    });

    if (picked != null) {
      _dob.text = picked.toString();
    }
  }

  File? imagePathGallery;
  String? base64imgGallery;
  Future pickImageGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
      if (xFile == null) {
        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        // const NavBar()), (Route<dynamic> route) => false);
      } else {
        Uint8List imageByte = await xFile.readAsBytes();
        base64imgGallery = base64.encode(imageByte);
        print("base64img $base64imgGallery");

        final imageTemporary = File(xFile.path);

        setState(() {
          imagePathGallery = imageTemporary;
          print("newImage $imagePathGallery");
          print("newImage64 $base64imgGallery");
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => SaveImageScreen(
          //           image: imagePath,
          //           image64: "$base64img",
          //         )));
        });
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: ${e.toString()}');
    }
  }

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
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Save",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF525252)),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          // height: MediaQuery.of(context).size.height,
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
            Center(
              child: Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(64),
                  child: SizedBox(
                    height: 120,
                    width: 120,
                    child: imagePathGallery != null
                        ? Image.file(imagePathGallery!)
                        : Image.network(
                            "https://images.pexels.com/photos/17457999/pexels-photo-17457999/free-photo-of-a-garbage-collector.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                            fit: BoxFit.cover),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    pickImageGallery();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 80,
                      left: 90,
                    ),
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF8D74),
                      border: Border.all(width: 4, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SvgPicture.asset(
                      'assets/cam2.svg',
                      width: 10,
                      height: 10,
                    ),
                  ),
                ),
              ]),
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
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/phone.svg',
                        color: Color(0xFFFF8D74),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: TextFormField(
                          controller: _mobileNumberController,
                          decoration: InputDecoration(
                            hintText: 'Mobile Number',
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF525252),
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF525252),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/sms.svg',
                        color: Color(0xFFFF8D74),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF525252),
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF525252),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/gender.svg',
                        color: Color(0xFFFF8D74),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: TextFormField(
                          controller: _gender,
                          decoration: InputDecoration(
                            hintText: 'Gender',
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF525252),
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF525252),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: SvgPicture.asset(
                          'assets/calendar.svg',
                          color: Color(0xFFFF8D74),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: TextFormField(
                          controller: _dob,
                          decoration: InputDecoration(
                            hintText: 'Date of Birth',
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF525252),
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF525252),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/flag.svg',
                        color: Color(0xFFFF8D74),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: TextFormField(
                          controller: _flag,
                          decoration: InputDecoration(
                            hintText: 'Nationality',
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF525252),
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF525252),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/terms.svg',
                        color: Color(0xFFFF8D74),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: TextFormField(
                          controller: _passportDesign,
                          decoration: InputDecoration(
                            suffixIcon: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                      onTap: () {},
                                      child: SvgPicture.asset(
                                          "assets/arrowDown.svg"))
                                ]),
                            hintText: 'Change the Passport Design',
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF525252),
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF525252),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(child: Image.asset("assets/passport.png")),
            SizedBox(
              height: 10,
            ),
          ]),
        ),
      ),
    );
  }
}
