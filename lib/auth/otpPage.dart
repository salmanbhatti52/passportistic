import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'createPassword.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController _otp = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";
  // @override
  // void dispose() {
  //   errorController?.close();
  //   _otp.dispose();
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(children: [
            Center(
              child: SvgPicture.asset(
                "assets/slogo.svg",
                height: 107,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Center(
              child: SvgPicture.asset(
                "assets/password.svg",
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Center(
                child: SvgPicture.asset(
                  "assets/otp.svg",
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                child: PinCodeTextField(
                  textStyle: const TextStyle(
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
                  controller: _otp,
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
                      Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) {
                          return CreatePassword();
                        },
                      ));
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
                            "Confirm",
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
      ),
    );
  }
}
