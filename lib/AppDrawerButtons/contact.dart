import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Models/contactUsModels.dart';
import '../Models/getProfileModels.dart';
import '../auth/signUpNextPage.dart';
import '../auth/signUpPage.dart';
import '../main.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final name = TextEditingController();
  final email = TextEditingController();
  final comments = TextEditingController();

  GetProfileModels getProfileModels = GetProfileModels();
  getUserProfile() async {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/get_profile";
    print("api: $apiUrl");

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(Uri.parse(apiUrl), headers: {
        'Accept': 'application/json',
      }, body: {
        "passport_holder_id": "$userID"
      });

      final responseString = response.body;
      print("getProfileModels Response: $responseString");
      print("status Code getProfileModels: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("in 200 getProfileModels");
        print("SuccessFull");
        getProfileModels = getProfileModelsFromJson(responseString);

        if (getProfileModels.data != null) {
          email.text = getProfileModels.data?.email ?? '';
          name.text = getProfileModels.data?.firstName ?? '';

          // Load the passport image when the page is initially loaded
        }
        print("");

        setState(() {
          isLoading = false;
        });

        print('getProfileModels status: ${getProfileModels.status}');
      } else {
        print("Error: ${response.reasonPhrase}");
        // Handle error cases if needed
      }
    } catch (e) {
      print("Error during API request: $e");
      // Handle exception if needed
    }
  }

  ContactUsModels contactUsModels = ContactUsModels();
  contactUs() async {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/contact_us";
    print("api: $apiUrl");

    setState(() {
      isLoading = true;
    });

    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": "$userID",
      "first_name": name.text,
      "email": email.text,
      "comments": comments.text,
    });

    final responseString = response.body;
    print("contactUsModels Response: $responseString");
    print("status Code contactUsModels: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 contactUsModels");
      print("SuccessFull");
      contactUsModels = contactUsModelsFromJson(responseString);

      if (contactUsModels.status == "success") {
        print("Success");

        setState(() {
          isLoading = false;
        });

        print('contactUsModels status: ${contactUsModels.status}');
      } else {
        print("Error: ${response.reasonPhrase}");
        // Handle error cases if needed
      }
    }
  }

  @override
  void initState() {
    getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFFF65634),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          centerTitle: true,
          title: const Text(
            'Contact Us',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF141010),
              fontSize: 20,
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(14.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset("assets/menub.svg")),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Center(
              child: SvgPicture.asset(
                "assets/log1.svg",
                height: 35.h,
                width: 108.w,
                color: const Color(0xFFF65734),
              ),
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
                    controller: name,
                    style:
                        const TextStyle(color: Color(0xFF000000), fontSize: 16),
                    cursorColor: const Color(0xFF000000),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset("assets/person.svg"),
                            ),
                          ]),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFF65734)),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      // labelText: 'Email',
                      hintText: "First Name",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color(0xFFF3F3F3),
                        ),
                      ),
                      hintStyle: const TextStyle(
                        color: Color(0xFFA7A9B7),
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Satoshi",
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
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
                    controller: email,
                    style:
                        const TextStyle(color: Color(0xFF000000), fontSize: 16),
                    cursorColor: const Color(0xFF000000),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset("assets/sms.svg"),
                            ),
                          ]),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFF65734)),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      // labelText: 'Email',
                      hintText: "Email",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color(0xFFF3F3F3),
                        ),
                      ),
                      hintStyle: const TextStyle(
                        color: Color(0xFFA7A9B7),
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Satoshi",
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
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
                    maxLines: null,
                    controller: comments,
                    style:
                        const TextStyle(color: Color(0xFF000000), fontSize: 16),
                    cursorColor: const Color(0xFF000000),
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      prefixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                "assets/edit1.svg",
                                color: const Color(0xFFF65734),
                              ),
                            ),
                          ]),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFF65734)),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      // labelText: 'Email',
                      hintText: "Write Comments here",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color(0xFFF3F3F3),
                        ),
                      ),
                      hintStyle: const TextStyle(
                        color: Color(0xFFA7A9B7),
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Satoshi",
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  if (comments.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please enter comments',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    await contactUs();
                    comments.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Thank you for your feedback',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
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
                            "Submit",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Satoshi",
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700),
                          ),
                  ],
                ),
              ),
            ),
            // Spacer(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.085,
            ),
            SvgPicture.asset("assets/women.svg"),
          ]),
        ),
      );
    }
  }
}
