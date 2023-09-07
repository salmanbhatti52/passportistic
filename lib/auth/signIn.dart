// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scanguard/auth/signUpNextPage.dart';
import 'package:scanguard/auth/signUpPage.dart';
import 'package:http/http.dart' as http;
import 'package:scanguard/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Home/mainScreenHome.dart';
import '../Models/LoginModels.dart';
import 'forgetPassword.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  signinUser() async {
    // try {

    String apiUrl = "$baseUrl/login";
    print("api: $apiUrl");
    print("email: ${email.text}");
    print("password: ${password.text.trim()}");
    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "email": email.text,
      "password": password.text,
    });
    final responseString = response.body;
    print("responseSignInApi: $responseString");
    print("status Code SignIn: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 signIn");
      print("SuucessFull");
      loginUserModels = loginUserModelsFromJson(responseString);
      setState(() {
        isLoading = false;
      });
      print('signInModel status: ${loginUserModels.status}');
    }
  }

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(_onFocusChange);
    _focusNode2.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode1.removeListener(_onFocusChange);
    _focusNode1.dispose();
    _focusNode2.removeListener(_onFocusChange);
    _focusNode2.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  bool isValidEmail(String email) {
    String pattern =
        r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$'; // Email regex pattern
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    bool isFocused1 = _focusNode1.hasFocus;
    bool isFocused2 = _focusNode2.hasFocus;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Center(
            child: SvgPicture.asset(
              "assets/log1.svg",
              height: 70.h,
              width: 219.w,
              color: const Color(0xFFF65734),
            ),
          ),
          Text(
            'PassportTastic',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: const Color(0xFF565656),
                fontSize: 31.sp,
                fontFamily: 'Satoshi',
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Text(
            'Welcome',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFFF65734),
              fontSize: 24.sp,
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.w700,
            ),
          ),
          Opacity(
            opacity: 0.40,
            child: Text(
              'Sign In to get started',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF141010),
                fontSize: 16.sp,
                fontFamily: 'Satoshi',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08.h,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  focusNode: _focusNode1,
                  style: TextStyle(
                      color: const Color(0xFF000000), fontSize: 16.sp),
                  cursorColor: const Color(0xFF000000),
                  controller: email,
                  // keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0).r,
                      child: SvgPicture.asset(
                        'assets/sms.svg',
                        width: 24.h,
                        height: 24.h,
                        color: isFocused1
                            ? const Color(0xFFF65734)
                            : const Color(0xFFE0E0E5),
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0).w,
                    ),
                    // labelText: 'Email',
                    hintText: "Enter Your Email",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15).w,
                      borderSide: const BorderSide(
                          color: Color(0xFFF3F3F3)), // change border color
                    ),

                    hintStyle: TextStyle(
                        color: const Color(0xFFA7A9B7),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Satoshi"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter your email address';
                    } else if (isValidEmail(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    email = value!.trim() as TextEditingController;
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  focusNode: _focusNode2,
                  obscureText: _obscureText,
                  style: TextStyle(
                      color: const Color(0xFF000000), fontSize: 16.sp),
                  cursorColor: const Color(0xFF000000),
                  controller: password,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0).r,
                      child: SvgPicture.asset(
                        'assets/lock.svg',
                        width: 24.h,
                        height: 24.h,
                        color: isFocused2
                            ? const Color(0xFFF65734)
                            : const Color(0xFFE0E0E5),
                      ),
                    ),
                    suffixIcon: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              _toggle();
                            },
                            icon: SvgPicture.asset(
                              'assets/eye.svg',
                              width: 24.h,
                              height: 24.h,
                            ),
                          )
                        ]),

                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0).w,
                    ),
                    // labelText: 'Email',
                    hintText: "Enter Your Password",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15).w,
                      borderSide: const BorderSide(
                          color: Color(0xFFF3F3F3)), // change border color
                    ),
                    labelStyle: const TextStyle(),
                    hintStyle: TextStyle(
                        color: const Color(0xFFA7A9B7),
                        fontSize: 16.sp,
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
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      bottom: 2.0), // Add some spacing below the text
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const ForgetPassword();
                        },
                      ));
                    },
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                        color: const Color(0xFFF65734),
                        fontFamily: "Satoshi",
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  print("Pressed");
                  if (email.text.isEmpty && password.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Color(0xFFF65734),
                        content: Text(
                          'Please Enter Email and Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Satoshi",
                          ),
                        ),
                      ),
                    );
                  } else {
                    setState(() {
                      isLoading = true;
                    });
                    await signinUser();
                    if (loginUserModels.status == "success") {
                      print("successful");

                      prefs = await SharedPreferences.getInstance();
                      // await prefs?.setString('userID',
                      //     "${loginUserModels.data?.passportHolderId}");
                      String userID =
                          loginUserModels.data?.passportHolderId ?? "";
                      await prefs?.setString('userID', userID);

                      print("Sign in userID$userID");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return MainScreen(
                              userId: userID,
                            );
                          },
                        ),
                      );
                    } else if (loginUserModels.status != "success") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: const Color(0xFFF65734),
                          content: Text(
                            loginUserModels.message.toString(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w300,
                              fontFamily: "Satoshi",
                            ),
                          ),
                        ),
                      );
                    }
                  }

                  setState(() {
                    isLoading = false;
                  });
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 48.h,
                      width: 340.w,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFF65734), Color(0xFFFF8D74)],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    isLoading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Satoshi",
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700),
                          ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0).w,
            child: RichText(
              text: TextSpan(
                text: "Doesn't have an account? ",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: "Sign Up",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFF65734),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const SignUpPage();
                          },
                        ));
                      },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          )
        ]),
      ),
    );
  }

  LoginUserModels loginUserModels = LoginUserModels();
  // SharedPreferences? prefs;
}
