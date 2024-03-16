import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  // final GetProfileModels profileData;
  final String? userId;
  const ProfilePage({
    super.key,
    this.userId,
    // required this.profileData,
  });

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

  bool validateInputs() {
    final currentPassword = currentPass.text;
    final newPassword = createPass.text;
    final confirmPassword = confirmPass.text;

    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
      return false;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password confirmation does not match.'),
        ),
      );
      return false;
    }

    // Additional validation checks can be added here if needed.

    return true; // If all validation checks pass.
  }

  bool _obscureText = true;
  bool _obscureText2 = true;
  bool _obscureText3 = true;

  void _toggle() {
    _obscureText = !_obscureText;
  }

  void _toggle2() {
    _obscureText2 = !_obscureText2;
  }

  void _toggle3() {
    _obscureText3 = !_obscureText3;
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
    createPass.dispose();
    currentPass.dispose();
    confirmPass.dispose();

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
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF65734)),
          ),
        ),
      );
    } else {
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
        ),
        body: Builder(builder: (context) {
          return SingleChildScrollView(
            child: Column(children: [
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
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
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
                      return ViewProfile(
                        userId: "${widget.userId}",
                      );
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
                  updatePasswordBottomSheet(
                      context, isFocused1, isFocused2, isFocused3);
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('No'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Yes'),
                            onPressed: () {
                              removeDataFormSharedPreferences();
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const SignInPage()),
                                (Route<dynamic> route) => false,
                              );
                            },
                          ),
                        ],
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
          );
        }),
      );
    }
  }

  Future<void> updatePasswordBottomSheet(
      BuildContext context, bool isFocused1, bool isFocused2, bool isFocused3) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter stateSetterObject) {
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
                            color: const Color(0xFF141111).withOpacity(0.5)),
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
                                  color: Color(0xFF000000), fontSize: 16),
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
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                hintText: "Current Password",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
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
                                    borderRadius: BorderRadius.circular(15)),
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
                              obscureText: _obscureText2,
                              style: const TextStyle(
                                  color: Color(0xFF000000), fontSize: 16),
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
                                        stateSetterObject(() {
                                          _toggle2();
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
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                hintText: "New Password",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
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
                                    borderRadius: BorderRadius.circular(15)),
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
                              obscureText: _obscureText3,
                              style: const TextStyle(
                                  color: Color(0xFF000000), fontSize: 16),
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
                                        stateSetterObject(() {
                                          _toggle3();
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
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                hintText: "Confirm Password",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
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
                                    borderRadius: BorderRadius.circular(15)),
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
                            Builder(builder: (context) {
                              return GestureDetector(
                                onTap: () async {
                                  print(createPass.text);
                                  print(currentPass.text);
                                  print(confirmPass.text);
                                  // Close the bottom sheet first
                                  // Navigator.pop(context);

                                  // Set isLoading to true
                                  stateSetterObject(() {
                                    isLoading = true;
                                  });

                                  // if (createPass.text.isEmpty) {
                                  //   // Validation error, show Snackbar and exit
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //     const SnackBar(
                                  //       content:
                                  //           Text("Please check your passwords"),
                                  //     ),
                                  //   );

                                  //   // Set isLoading to false
                                  //   stateSetterObject(() {
                                  //     isLoading = false;
                                  //   });

                                  //   return;
                                  // }

                                  // Attempt to update the password

                                  // Check if the widget is still mounted before showing the SnackBar
                                  if (createPass.text.isEmpty &&
                                      currentPass.text.isEmpty &&
                                      confirmPass.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text("Please check your passwords"),
                                      ),
                                    );
                                  } else {
                                    await updatePassword();
                                    if (updatePasswordModel.status ==
                                        "success") {
                                      Navigator.pop(context);
                                      // Password updated successfully, show success Snackbar
                                      createPass.clear();
                                      currentPass.clear();
                                      confirmPass.clear();
                                      Fluttertoast.showToast(
                                        msg: "Password Updated SuccessFully",
                                        toastLength: Toast
                                            .LENGTH_SHORT, // or Toast.LENGTH_LONG
                                        gravity: ToastGravity
                                            .CENTER, // You can change the position
                                        timeInSecForIosWeb:
                                            1, // This is the duration of the toast
                                        backgroundColor:
                                            const Color(0xFFF65734),
                                        // Background color of the toast
                                        textColor: Colors
                                            .white, // Text color of the toast message
                                        fontSize:
                                            16.0, // Font size of the toast message
                                      );
                                    } else {
                                      // Password update failed, show error Snackbar
                                      Fluttertoast.showToast(
                                        msg: updatePasswordModel.message
                                            .toString(),
                                        toastLength: Toast
                                            .LENGTH_SHORT, // or Toast.LENGTH_LONG
                                        gravity: ToastGravity
                                            .CENTER, // You can change the position
                                        timeInSecForIosWeb:
                                            1, // This is the duration of the toast
                                        backgroundColor:
                                            const Color(0xFFF65734),
                                        // Background color of the toast
                                        textColor: Colors
                                            .white, // Text color of the toast message
                                        fontSize:
                                            16.0, // Font size of the toast message
                                      );

                                      print("Hi Zain");
                                    }
                                  }

                                  // Set isLoading to false
                                  stateSetterObject(() {
                                    isLoading = false;
                                  });
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
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    isLoading
                                        ? const CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          )
                                        : const Text(
                                            "Update Password",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Satoshi",
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                  ],
                                ),
                              );
                            })
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
  }

  removeDataFormSharedPreferences() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.clear();
    setState(() {});
  }
}
