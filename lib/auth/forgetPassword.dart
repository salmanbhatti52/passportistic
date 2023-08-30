import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scanguard/auth/signUpNextPage.dart';
import 'package:scanguard/auth/signUpPage.dart';
import 'package:http/http.dart' as http;
import '../Models/forgetpassportModel.dart';
import 'otpPage.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController email = TextEditingController();
  ForgetPasswordModel forgetPasswordModel = ForgetPasswordModel();

  forgetPass() async {
    // try {

    String apiUrl = "$baseUrl/forgot_password";
    print("api: $apiUrl");
    print("email: ${email.text}");
    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "email": email.text,
    });
    final responseString = response.body;
    print("responseForgetPasswordApi: $responseString");
    print("status Code ForgetPassword: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 ForgetPassword");
      print("SuucessFull");
      forgetPasswordModel = forgetPasswordModelFromJson(responseString);
      setState(() {
        isLoading = false;
      });
      print('ForgetPasswordModel status: ${forgetPasswordModel.status}');
    }
  }

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isFocused = _focusNode.hasFocus;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
      ),
      body: SizedBox(
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
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    focusNode: _focusNode,
                    style:
                        const TextStyle(color: Color(0xFF000000), fontSize: 16),
                    cursorColor: const Color(0xFF000000),
                    controller: email,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/sms.svg',
                          color: isFocused
                              ? const Color(0xFFF65734)
                              : const Color(0xFFE0E0E5),
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFF65734)),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      // labelText: 'Email',
                      hintText: "Enter Your Email",
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
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (email.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Please Enter Email",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Satoshi",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        await forgetPass();
                        if (forgetPasswordModel.status == "success") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Email Sent Successfully",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Satoshi",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context) {
                              return OtpPage(
                                otp: forgetPasswordModel.data!.otp.toString(),
                                email: email.text,
                              );
                            },
                          ));
                        } else if (forgetPasswordModel.status != "success") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Email Not Found",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Satoshi",
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 48,
                          width: MediaQuery.of(context).size.width * 0.94,
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
                            : const Text(
                                "Send Code",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Satoshi",
                                    fontSize: 20,
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
      ),
    );
  }

  bool isValidEmail(String email) {
    String pattern =
        r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$'; // Email regex pattern
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }
}
