import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scanguard/auth/signIn.dart';
import 'package:scanguard/auth/signUpNextPage.dart';
import 'package:scanguard/auth/signUpPage.dart';
import 'package:http/http.dart' as http;
import '../Models/resetPasswordModels.dart';

class CreatePassword extends StatefulWidget {
  final String? otp;
  final String? email;
  const CreatePassword({super.key, this.otp, this.email});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  TextEditingController createPass = TextEditingController();
  TextEditingController conPass = TextEditingController();

  ResetPasswordModel resetPasswordModel = ResetPasswordModel();
  resettPass() async {
    // try {

    String apiUrl = "$baseUrl/modify_password";
    print("api: $apiUrl");
    print(createPass.text);
    print(conPass.text);

    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "email": "${widget.email}",
      "otp": "${widget.otp}",
      "password": createPass.text,
      "confirm_password": conPass.text
    });
    final responseString = response.body;
    print("responseForgetPasswordApi: $responseString");
    print("status Code ForgetPassword: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 ForgetPassword");
      print("SuucessFull");
      resetPasswordModel = resetPasswordModelFromJson(responseString);
      setState(() {
        isLoading = false;
      });
      print('ForgetPasswordModel status: ${resetPasswordModel.status}');
    }
  }

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
    _focusNode2.removeListener(_onFocusChange);

    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isFocused1 = _focusNode1.hasFocus;
    bool isFocused2 = _focusNode2.hasFocus;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text(""),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 2,
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
            'Create your new password',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF141010),
              fontSize: 24.sp,
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            width: 330.w,
            child: Opacity(
              opacity: 0.50,
              child: Text(
                'Please create your new password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF222222),
                  fontSize: 16.sp,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w300,
                  height: 1.50,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  focusNode: _focusNode1,
                  obscureText: _obscureText,
                  style: TextStyle(
                      color: const Color(0xFF000000), fontSize: 16.sp),
                  cursorColor: const Color(0xFF000000),
                  controller: createPass,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/lock.svg',
                        width: 24.w,
                        height: 24.h,
                        color: isFocused1
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
                              width: 24.w,
                              height: 24.h,
                            ),
                          )
                        ]),

                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: "Create New Password",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
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
                  controller: conPass,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/lock.svg',
                        width: 24.w,
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
                              width: 24.w,
                              height: 24.h,
                            ),
                          )
                        ]),

                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: "Confirm Password",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (conPass.text.isEmpty && createPass.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please Enter Password"),
                        ),
                      );
                    } else {
                      await resettPass();
                      if (resetPasswordModel.status == "success") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Password Reset Successfully"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const SignInPage();
                          },
                        ));
                      } else if (resetPasswordModel.data != "success") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text(resetPasswordModel.message.toString()),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Something Went Wrong"),
                          ),
                        );
                      }
                    }
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
                              "Reset Password",
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
          ),
        ]),
      ),
    );
  }
}
