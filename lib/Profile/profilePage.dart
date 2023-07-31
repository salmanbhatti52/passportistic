import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scanguard/Profile/viewProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Home/appDrawer.dart';
import '../auth/signIn.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController createPass = TextEditingController();
  final TextEditingController currentPass = TextEditingController();
  final TextEditingController confirmPass = TextEditingController();
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

  bool _obscureText = true;

  void _toggle() {
    _obscureText = !_obscureText;
  }

  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(_onFocusChange);
    _focusNode2.addListener(_onFocusChange);
    _focusNode3.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode1.removeListener(_onFocusChange);

    _focusNode2.removeListener(_onFocusChange);

    _focusNode3.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isFocused1 = _focusNode1.hasFocus;
    bool isFocused2 = _focusNode2.hasFocus;
    bool isFocused3 = _focusNode3.hasFocus;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        // backgroundColor: Colors.black,
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
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          // SizedBox(
          //   height: 10,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(top: 30, left: 10),
          //       child: Builder(builder: (context) {
          //         return GestureDetector(
          //           onTap: () {
          //             Scaffold.of(context).openDrawer();
          //           },
          //           child: SvgPicture.asset(
          //             "assets/menu.svg",
          //           ),
          //         );
          //       }),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(top: 30, right: 10),
          //       child: GestureDetector(
          //         onTap: () {
          //           // Navigator.pushNamed(context, '/notification');
          //         },
          //         child: SvgPicture.asset(
          //           "assets/notification.svg",
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(
            height: 10,
          ),
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
          const SizedBox(
            height: 10,
          ),
          const Text(
            "John Doe",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/sms.svg",
                color: Color(0xFFFF8D74),
                width: 15,
                height: 15,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "JhonDeo@gmail.com",
                style: TextStyle(
                    fontFamily: "Satoshi",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF9C9999)),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/phone.svg",
                color: Color(0xFFFF8D74),
                width: 15,
                height: 15,
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                "+92 9876543210",
                style: TextStyle(
                    fontFamily: "Satoshi",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF9C9999)),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return ViewProfile();
                },
              ));
            },
            child: Container(
              width: 294,
              height: 72,
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
              child: Stack(
                children: [
                  Positioned(
                    left: 16,
                    top: 25,
                    child: Text(
                      'View Profile',
                      style: TextStyle(
                        color: Color(0xFF525252),
                        fontSize: 16,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 238,
                    top: 16,
                    child: SvgPicture.asset(
                      "assets/arrow.svg",
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
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder:
                        (BuildContext context, StateSetter stateSetterObject) {
                      return SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Change Your Password",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                      color: Color(0xFFF65734)),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Unlock a New Level of Security with a \nPassword Change.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          Color(0xFF141111).withOpacity(0.5)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: TextFormField(
                                        focusNode: _focusNode1,
                                        obscureText: _obscureText,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 16),
                                        cursorColor: Color(0xFF000000),
                                        controller: currentPass,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                              'assets/lock.svg',
                                              color: isFocused1
                                                  ? Color(0xFFF65734)
                                                  : Color(0xFFE0E0E5),
                                            ),
                                          ),
                                          suffixIcon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  stateSetterObject(() {
                                                    _toggle();
                                                  });
                                                },
                                                icon: SvgPicture.asset(
                                                  'assets/eye.svg',
                                                ),
                                              )
                                            ],
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFF65734)),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          hintText: "Current Password",
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                              color: Color(0xFFE0E0E5),
                                            ),
                                          ),
                                          hintStyle: TextStyle(
                                              color: Color(0xFFA7A9B7),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                              fontFamily: "Satoshi"),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: TextFormField(
                                        focusNode: _focusNode2,
                                        obscureText: _obscureText,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 16),
                                        cursorColor: Color(0xFF000000),
                                        controller: createPass,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                              'assets/lock.svg',
                                              color: isFocused2
                                                  ? Color(0xFFF65734)
                                                  : Color(0xFFE0E0E5),
                                            ),
                                          ),
                                          suffixIcon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  _toggle();
                                                },
                                                icon: SvgPicture.asset(
                                                  'assets/eye.svg',
                                                ),
                                              )
                                            ],
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFF65734)),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          hintText: "New Password",
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                              color: Color(0xFFE0E0E5),
                                            ),
                                          ),
                                          hintStyle: TextStyle(
                                              color: Color(0xFFA7A9B7),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                              fontFamily: "Satoshi"),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: TextFormField(
                                        focusNode: _focusNode3,
                                        obscureText: _obscureText,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 16),
                                        cursorColor: Color(0xFF000000),
                                        controller: confirmPass,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                              'assets/lock.svg',
                                              color: isFocused3
                                                  ? Color(0xFFF65734)
                                                  : Color(0xFFE0E0E5),
                                            ),
                                          ),
                                          suffixIcon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  _toggle();
                                                },
                                                icon: SvgPicture.asset(
                                                  'assets/eye.svg',
                                                ),
                                              )
                                            ],
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFF65734)),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          hintText: "Confirm Password",
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                              color: Color(0xFFE0E0E5),
                                            ),
                                          ),
                                          hintStyle: TextStyle(
                                              color: Color(0xFFA7A9B7),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                              fontFamily: "Satoshi"),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // Perform your action here
                                          print('Update Password tapped');
                                        },
                                        child: Container(
                                          height: 48,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.84,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFFF65734),
                                                Color(0xFFFF8D74)
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Update Password",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Satoshi",
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
            child: Container(
              width: 294,
              height: 72,
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
              child: Stack(
                children: [
                  Positioned(
                    left: 16,
                    top: 25,
                    child: Text(
                      'Change Password',
                      style: TextStyle(
                        color: Color(0xFF525252),
                        fontSize: 16,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 238,
                    top: 16,
                    child: SvgPicture.asset(
                      "assets/arrow.svg",
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
              removeDataFormSharedPreferences();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => SignInPage()),
                (Route<dynamic> route) => false,
              );
            },
            child: Container(
              width: 294,
              height: 72,
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
              child: Stack(
                children: [
                  Positioned(
                    left: 16,
                    top: 25,
                    child: Text(
                      'Log Out',
                      style: TextStyle(
                        color: Color(0xFF525252),
                        fontSize: 16,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 238,
                    top: 16,
                    child: SvgPicture.asset(
                      "assets/arrow.svg",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  removeDataFormSharedPreferences() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.clear();
    setState(() {});
  }
}
