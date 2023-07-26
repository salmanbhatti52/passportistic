import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
    print("in 200 signIn");
    if (response.statusCode == 200) {
      print("SuucessFull");
      loginUserModels = loginUserModelsFromJson(responseString);
      setState(() {
        isLoading = false;
      });
      print('signInModel status: ${loginUserModels.status}');
    }
  }

  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();

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
              "assets/slogo.svg",
              height: 107,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Center(
            child: SvgPicture.asset(
              "assets/welcome.svg",
              height: 58,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  focusNode: _focusNode1,
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
                        color:
                            isFocused1 ? Color(0xFFF65734) : Color(0xFFE0E0E5),
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
          const SizedBox(
            height: 10,
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
                  style:
                      const TextStyle(color: Color(0xFF000000), fontSize: 16),
                  cursorColor: const Color(0xFF000000),
                  controller: password,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/lock.svg',
                        color:
                            isFocused2 ? Color(0xFFF65734) : Color(0xFFE0E0E5),
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
                            ),
                          )
                        ]),

                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: "Enter Your Password",
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
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      bottom: 2.0), // Add some spacing below the text
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) {
                          return ForgetPassword();
                        },
                      ));
                    },
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFFF65734),
                        fontFamily: "Satoshi",
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
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
                  } else if (email.text.isNotEmpty &&
                      password.text.isNotEmpty) {
                    if (loginUserModels.status == "success")
                      print("successful");

                    await signinUser();
                    prefs = await SharedPreferences.getInstance();
                    await prefs?.setString(
                        'userID', "${loginUserModels.data?.usersCustomersId}");
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return MainScreen(
                          firstname: "${loginUserModels.data?.firstName}",
                          lastname: "${loginUserModels.data?.lastName}",
                          profile: "${loginUserModels.data?.profilePicture}",
                          userId: "${loginUserModels.data?.usersCustomersId}",
                          email: "${loginUserModels.data?.email}",
                          phone: "${loginUserModels.data?.phoneNumber}",
                        );
                      },
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Color(0xFFF65734),
                        content: Text(
                          'Something Went Wrong!',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Satoshi",
                          ),
                        ),
                      ),
                    );
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
                        "Sign In",
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                text: "Doesn't have an account? ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: "Sign Up",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFF65734),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return SignUpPage();
                          },
                        ));
                      },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          )
        ]),
      ),
    );
  }

  LoginUserModels loginUserModels = LoginUserModels();
  // SharedPreferences? prefs;
}
