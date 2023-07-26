import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:scanguard/auth/signUpNextPage.dart';

class VerifyAccountPage extends StatefulWidget {
  final String? userId;
  final String? otp;
  const VerifyAccountPage({super.key, this.userId, this.otp});

  @override
  State<VerifyAccountPage> createState() => _VerifyAccountPageState();
}

class _VerifyAccountPageState extends State<VerifyAccountPage> {
  TextEditingController verifyOtp = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";
  // @override
  // void dispose() {
  //   // errorController?.close();
  //   verifyOtp == "";
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(""),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Center(
            child: SvgPicture.asset(
              "assets/slogo.svg",
              height: 107,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Center(
            child: SvgPicture.asset(
              "assets/Verify.svg",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Please enter 4-digit code that has been sent to \nyour email “Devteam@akodes.com” for account \nverification.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Satoshi",
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Color(0xFF222222).withOpacity(0.5),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
              child: PinCodeTextField(
                textStyle: TextStyle(
                  color: Color(0xFFA7A9B7),
                  fontSize: 16,
                ),
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.bold,
                ),
                length: 4,
                obscureText: false,
                obscuringCharacter: '*',

                blinkWhenObscuring: true,
                animationType: AnimationType.fade,
                validator: (v) {
                  if (v!.length < 3) {
                    return "";
                  } else {
                    return null;
                  }
                },
                pinTheme: PinTheme(
                  disabledColor: Colors.white,
                  inactiveColor: const Color(0xFFF3F3F3),
                  selectedColor: const Color(0xFFF3F3F3),
                  // inactiveFillColor: Color(0xFFF3F3F3),
                  //inactiveFillColor: Colors.white,
                  activeColor: const Color(0xFFF3F3F3),
                  shape: PinCodeFieldShape.box,

                  borderWidth: 2,
                  // activeFillColor: Colors.green.shade600,

                  //activeColor: Colors.green.shade600,

                  borderRadius: BorderRadius.circular(12),
                  fieldHeight: 52,
                  fieldWidth: 52,
                ),

                cursorColor: Colors.black,
                animationDuration: const Duration(milliseconds: 300),

                errorAnimationController: errorController,
                controller: verifyOtp,
                keyboardType: TextInputType.number,

                onCompleted: (v) {
                  debugPrint("Completed");
                },
                // onTap: () {
                //   print("Pressed");
                // },
                onChanged: (value) {
                  debugPrint(value);
                  setState(() {
                    currentText = value;
                  });
                },
                beforeTextPaste: (text) {
                  debugPrint("Allowing to paste $text");

                  return true;
                },
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (verifyOtp.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please Enter the OTP!"),
                        backgroundColor: Color(0xFF2B65EC),
                      ));
                    } else if (verifyOtp.value.text.length < 4) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please Enter Complete OTP!"),
                        backgroundColor: Color(0xFF2B65EC),
                      ));
                    } else if (verifyOtp.text.isNotEmpty) {
                      setState(() {
                        // Added this line
                        isLoading = true;
                      });
                      try {
                        if (widget.otp == verifyOtp.text) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context) {
                              return SignupNextPage(
                                userId: "${widget.userId}",
                              );
                            },
                          ));
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Error verifying OTP!"),
                          backgroundColor: Colors.red,
                        ));
                      } finally {
                        setState(() {
                          // Added this line
                          isLoading = false;
                        });
                      }
                    }
                  },
                  child: Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width * 0.94,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFF65734), Color(0xFFFF8D74)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Verify",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Satoshi",
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  bool isLoading = false;
}
