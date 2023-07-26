import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scanguard/auth/signupDetails.dart';

class AddPictureSignup extends StatefulWidget {
  const AddPictureSignup({super.key});

  @override
  State<AddPictureSignup> createState() => _AddPictureSignupState();
}

class _AddPictureSignupState extends State<AddPictureSignup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          "Add Picture",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: "Satoshi",
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Click on avatar to upload Image",
                  style: TextStyle(
                      fontFamily: "Satoshi",
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF222222).withOpacity(0.5)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 192,
                    width: 169,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xFFE0E0E5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Center(
                          child: SvgPicture.asset(
                            "assets/dimage.svg",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                  child: Text(
                "Default Image",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Satoshi"),
              )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 169,
                    width: 169,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xFFE0E0E5),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/account.svg",
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                  child: Text(
                "Select Image",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Satoshi"),
              )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/Line.svg",
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "OR",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Satoshi",
                        color: Color(0xFFF65734)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    "assets/Line.svg",
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/cam.svg",
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text("Take a Photo")
                ],
              ),
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
                            return SignupDetails();
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
                              "Next",
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
}
