import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scanguard/Profile/viewProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Home/appDrawer.dart';
import '../Models/getProfileModels.dart';
import '../Models/updatePasswordModels.dart';
import '../auth/signIn.dart';
import '../auth/signUpNextPage.dart';
import '../auth/signUpPage.dart';
import '../main.dart';

class ProfilePage extends StatefulWidget {
  final String? userId;
  const ProfilePage({super.key, this.userId});

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

  GetProfileModels getProfileModels = GetProfileModels();
  getUserProfile() async {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/get_profile";
    print("api: $apiUrl");
    if (!mounted) {
      return; // Check if the widget is still mounted
    }
    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": "$userID"
    });
    if (!mounted) {
      return; // Check again if the widget is still mounted after the HTTP request
    }
    final responseString = response.body;
    print("getProfileModels Response: $responseString");
    print("status Code getProfileModels: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 getProfileModels");
      print("SuucessFull");
      getProfileModels = getProfileModelsFromJson(responseString);
      if (!mounted) {
        return; // Check once more if the widget is still mounted before updating the state
      }
      setState(() {
        isLoading = false;
      });
      print('getProfileModels status: ${getProfileModels.status}');
    }
  }

  UpdatePasswordModel updatePasswordModel = UpdatePasswordModel();
  updatePassword() async {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/change_password";
    print("api: $apiUrl");
    if (!mounted) {
      return; // Check if the widget is still mounted
    }
    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": "$userID",
      "old_password": currentPass.text,
      "password": createPass.text,
      "confirm_password": confirmPass.text
    });
    if (!mounted) {
      return; // Check again if the widget is still mounted after the HTTP request
    }
    final responseString = response.body;
    print("updatePasswordModel Response: $responseString");
    print("status Code updatePasswordModel: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 updatePasswordModel");
      print("SuucessFull");
      updatePasswordModel = updatePasswordModelFromJson(responseString);
      if (!mounted) {
        return; // Check once more if the widget is still mounted before updating the state
      }
      setState(() {
        isLoading = false;
      });
      print('updatePasswordModel status: ${updatePasswordModel.status}');
    }
  }

  bool _obscureText = true;

  void _toggle() {
    _obscureText = !_obscureText;
  }

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();

  @override
  void initState() {
    super.initState();
    getUserProfile();
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
      drawer: const AppDrawer(),
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
                      ? Image.file(imagePathGallery!, fit: BoxFit.cover)
                      : getProfileModels.data?.profilePicture != null
                          ? Image.network(
                              "https://portal.passporttastic.com/public/${getProfileModels.data!.profilePicture}",
                              fit: BoxFit.cover,
                            )
                          : Container(), // Empty container as a fallback
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
          Text(
            "${getProfileModels.data?.firstName ?? ''} ${getProfileModels.data?.lastName ?? ''}",
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/sms.svg",
                color: const Color(0xFFFF8D74),
                width: 15,
                height: 15,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                getProfileModels.data?.email ?? '', // Use ?. instead of !
                style: const TextStyle(
                  fontFamily: "Satoshi",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF9C9999),
                ),
              ),
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
                color: const Color(0xFFFF8D74),
                width: 15,
                height: 15,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                getProfileModels.data?.phoneNumber ?? '',
                style: const TextStyle(
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
                  return ViewProfile(userId: "${widget.userId}");
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
                shadows: const [
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
                  const Positioned(
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
                                const Text(
                                  "Change Your Password",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                      color: Color(0xFFF65734)),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Unlock a New Level of Security with a \nPassword Change.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF141111)
                                          .withOpacity(0.5)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: TextFormField(
                                        focusNode: _focusNode1,
                                        obscureText: _obscureText,
                                        style: const TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 16),
                                        cursorColor: const Color(0xFF000000),
                                        controller: currentPass,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                              'assets/lock.svg',
                                              color: isFocused1
                                                  ? const Color(0xFFF65734)
                                                  : const Color(0xFFE0E0E5),
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
                                            borderSide: const BorderSide(
                                                color: Color(0xFFF65734)),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          hintText: "Current Password",
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                              color: Color(0xFFE0E0E5),
                                            ),
                                          ),
                                          hintStyle: const TextStyle(
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
                                        style: const TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 16),
                                        cursorColor: const Color(0xFF000000),
                                        controller: createPass,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                              'assets/lock.svg',
                                              color: isFocused2
                                                  ? const Color(0xFFF65734)
                                                  : const Color(0xFFE0E0E5),
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
                                            borderSide: const BorderSide(
                                                color: Color(0xFFF65734)),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          hintText: "New Password",
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                              color: Color(0xFFE0E0E5),
                                            ),
                                          ),
                                          hintStyle: const TextStyle(
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
                                        style: const TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 16),
                                        cursorColor: const Color(0xFF000000),
                                        controller: confirmPass,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                              'assets/lock.svg',
                                              color: isFocused3
                                                  ? const Color(0xFFF65734)
                                                  : const Color(0xFFE0E0E5),
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
                                            borderSide: const BorderSide(
                                                color: Color(0xFFF65734)),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          hintText: "Confirm Password",
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                              color: Color(0xFFE0E0E5),
                                            ),
                                          ),
                                          hintStyle: const TextStyle(
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
                                        onTap: () async {
                                          if (createPass.text.isEmpty &&
                                              currentPass.text.isEmpty &&
                                              confirmPass.text.isEmpty) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Please enter new password")));
                                          } else {
                                            await updatePassword();
                                            if (updatePasswordModel.status ==
                                                "success") {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Password Updated Successfully")));
                                              Navigator.pop(context);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Password Not Updated")));
                                            }
                                          }
                                          // Perform your action here
                                          print('Update Password tapped');
                                        },
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              height: 48,
                                              width: 256,
                                              decoration: BoxDecoration(
                                                gradient: const LinearGradient(
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
                                            ),
                                            isLoading
                                                ? const CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Colors.white),
                                                  )
                                                : const Text(
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
                shadows: const [
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
                  const Positioned(
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
                MaterialPageRoute(builder: (context) => const SignInPage()),
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
                shadows: const [
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
                  const Positioned(
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
