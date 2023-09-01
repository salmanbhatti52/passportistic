import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Models/getProfileModels.dart';
import '../auth/signUpNextPage.dart';
import '../auth/signUpPage.dart';
import '../main.dart';

class ViewPassport extends StatefulWidget {
  const ViewPassport({super.key});

  @override
  State<ViewPassport> createState() => _ViewPassportState();
}

class _ViewPassportState extends State<ViewPassport> {
  int currentPageIndex = 0;
  List<Widget> customPages = []; // To store custom pages

  void goToNextPage() {
    if (currentPageIndex < customPages.length) {
      setState(() {
        currentPageIndex++;
      });
    }
  }

  void createNewPage() {
    setState(() {
      customPages.add(
        const CustomPage(), // Replace this with your custom page widget
      );
    });
  }

  void deletePage() {
    if (customPages.isNotEmpty) {
      setState(() {
        customPages.removeLast();
        if (currentPageIndex >= customPages.length) {
          currentPageIndex = customPages.length - 1;
        }
      });
    }
  }

  final PageController pageController = PageController();

  GetProfileModels getProfileModels = GetProfileModels();
  getUserProfile() async {
    String apiUrl = "$baseUrl/get_profile";
    print("api: $apiUrl");
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
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

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00AEFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00AEFF),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              "assets/arrowLeft.svg",
              width: 20,
              height: 20,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              "assets/notification.svg",
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          // Expanded(
          //   flex: 7,
          //   child: PageView.builder(
          //     controller: pageController,
          //     itemCount: customPages.length,
          //     scrollDirection: Axis.horizontal,
          //     onPageChanged: (index) {
          //       setState(() {
          //         currentPageIndex = index;
          //       });
          //     },
          //     itemBuilder: (context, index) {
          //       return customPages[index];
          //     },
          //   ),
          // ),
          const passportPage(),
          const Spacer(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 188,
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                'View Pages',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFF65734),
                  fontSize: 24,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (currentPageIndex > 0) {
                          currentPageIndex--;
                        }
                      });
                    },
                    child: SvgPicture.asset("assets/arrowRoundLeft.svg"),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: deletePage,
                    child: SvgPicture.asset("assets/minus.svg"),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: createNewPage,
                    child: SvgPicture.asset("assets/add.svg"),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: goToNextPage,
                    child: SvgPicture.asset("assets/arrowRight.svg"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: const ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFFFF8D74), Color(0xFFF65634)],
                      ),
                      shape: OvalBorder(),
                    ),
                    child: Center(child: SvgPicture.asset("assets/share1.svg")),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 72,
                    height: 72,
                    decoration: const ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFFFF8D74), Color(0xFFF65634)],
                      ),
                      shape: OvalBorder(),
                    ),
                    child: Center(child: SvgPicture.asset("assets/import.svg")),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 72,
                    height: 72,
                    decoration: const ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFFFF8D74), Color(0xFFF65634)],
                      ),
                      shape: OvalBorder(),
                    ),
                    child: Center(child: SvgPicture.asset("assets/print1.svg")),
                  ),
                ],
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class passportPage extends StatefulWidget {
  const passportPage({
    super.key,
  });

  @override
  State<passportPage> createState() => _passportPageState();
}

class _passportPageState extends State<passportPage> {
  GetProfileModels getProfileModels = GetProfileModels();
  getUserProfile() async {
    String apiUrl = "$baseUrl/get_profile";
    print("api: $apiUrl");
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
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
      String mrzDate = getProfileModels
          .data!.dateAdded!; // Replace with your MRZ date string
      String mrDate = getProfileModels.data!.dob!;

// Extract year, month, and day from MRZ date string
      int year = int.parse(mrzDate.substring(0, 2));
      int month = int.parse(mrzDate.substring(2, 4));
      int day = int.parse(mrzDate.substring(4, 6));

// Create a DateTime object from extracted components
      DateTime parsedDate = DateTime(2000 + year, month, day);

// Now you can format the parsedDate as needed
      String dateAdded = DateFormat("yyyMMDD").format(parsedDate);
      String dobadded = DateFormat("yyyyMMDD").format(parsedDate);
      print(dobadded);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RotatedBox(
        quarterTurns: 3,
        child: Container(
          decoration: ShapeDecoration(
            color: const Color(0xFFFFFCF4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17.34),
            ),
          ),
          width: 450.22,
          height: 300.02,
          child: Stack(
            children: [
              Positioned(
                left: 15,
                top: 60.85,
                child: Container(
                    width: 100,
                    height: 130,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: getProfileModels.data != null &&
                            getProfileModels.data!.profilePicture != null
                        ? Image.network(
                            "https://portal.passporttastic.com/public/${getProfileModels.data!.profilePicture}",
                            fit: BoxFit.fill,
                          )
                        : const SizedBox()),
              ),
              Positioned(
                left: 11.16,
                top: 222.03,
                child: SizedBox(
                  width: 416.07,
                  height: 50.98,
                  child: SizedBox(
                    width: 416.07,
                    child: getProfileModels.data != null
                        ? Text(
                            "S<${getProfileModels.data!.firstName}<<${getProfileModels.data!.middleName} ${getProfileModels.data!.lastName}<<<<<<<<<<<<<<<<<<<\nPA1234567<<AUD<<20230601<<20230601<<48<<<",
                            // 'S<AUDBURKE<<GARY<JOHN JOE<<<<<<<<<<<<<<<<<<<\nPA1234567<<AUD<<19590526<<20230601<<48<<<<<<',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF141010),
                              fontSize: 13.87,
                              fontFamily: 'OCR-B 10 BT',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.69,
                            ),
                          )
                        : const SizedBox(),
                  ),
                ),
              ),
              Positioned(
                left: 5,
                top: 0,
                child: Container(
                  width: 100.08,
                  height: 36.98,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'PASSPORT',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.18,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 212.66,
                top: 5,
                child: Container(
                  width: 145.08,
                  height: 49.18,
                  padding: const EdgeInsets.only(right: 35.08),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getProfileModels.data != null
                          ? Text(
                              "${getProfileModels.data!.nationality}",
                              style: const TextStyle(
                                color: Color(0xFF00247D),
                                fontSize: 11.56,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 0.76),
                      const SizedBox(
                        width: double.infinity,
                        height: 29.02,
                        child: Stack(
                          children: [
                            Positioned(
                              left: -0,
                              top: 13.02,
                              child: Text(
                                'AUD',
                                style: TextStyle(
                                  color: Color(0xFF141010),
                                  fontSize: 13.87,
                                  fontFamily: 'OCR-B 10 BT',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Text(
                                'Currency',
                                style: TextStyle(
                                  color: Color(0xFF50A0FF),
                                  fontSize: 9.25,
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 1.16,
                top: 0,
                child: SizedBox(
                  width: 420.07,
                  height: 42.18,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 318.98,
                        top: 0,
                        child: Container(
                          width: 97.08,
                          height: 36.98,
                          padding: const EdgeInsets.only(
                            top: 5.78,
                            right: 21.08,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 76,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: -0,
                                      top: 11.02,
                                      child: Text(
                                        'PA1234567',
                                        style: TextStyle(
                                          color: Color(0xFF141010),
                                          fontSize: 13.87,
                                          fontFamily: 'OCR-B 10 BT',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Text(
                                        'Passport No.',
                                        style: TextStyle(
                                          color: Color(0xFF50A0FF),
                                          fontSize: 9.25,
                                          fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 124.82,
                top: 60.85,
                child: SizedBox(
                  width: 292.40,
                  height: 143.31,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Name/Nom',
                            style: TextStyle(
                              color: Color(0xFF50A0FF),
                              fontSize: 9.25,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2.02),
                          getProfileModels.data != null
                              ? Text(
                                  "${getProfileModels.data!.firstName} ${getProfileModels.data!.middleName} \n ${getProfileModels.data!.lastName}",
                                  style: const TextStyle(
                                    color: Color(0xFF141010),
                                    fontSize: 13.87,
                                    fontFamily: 'OCR-B 10 BT',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      Positioned(
                        left: 0,
                        top: 50.85,
                        child: Container(
                          width: 141.58,
                          height: 41.61,
                          padding:
                              const EdgeInsets.only(top: 5.78, right: 38.58),
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 103,
                                height: double.infinity,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 15.02,
                                      child: getProfileModels.data != null
                                          ? Text(
                                              " ${getProfileModels.data!.nationality}",
                                              style: const TextStyle(
                                                color: Color(0xFF141010),
                                                fontSize: 13.87,
                                                fontFamily: 'OCR-B 10 BT',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          : const SizedBox(),
                                    ),
                                    const Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Text(
                                        'Nationality/Nationalite ',
                                        style: TextStyle(
                                          color: Color(0xFF50A0FF),
                                          fontSize: 9.25,
                                          fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 101.71,
                        child: Container(
                          width: 141.58,
                          height: 46.61,
                          padding:
                              const EdgeInsets.only(top: 5.78, bottom: 6.80),
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: double.infinity,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 13.02,
                                        child: getProfileModels.data != null
                                            ? Text(
                                                DateFormat("d MMM yyyy").format(
                                                    DateTime.parse(
                                                        getProfileModels
                                                            .data!.dob!)),
                                                style: const TextStyle(
                                                  color: Color(0xFF141010),
                                                  fontSize: 13.87,
                                                  fontFamily: 'OCR-B 10 BT',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            : const SizedBox(),
                                      ),
                                      const Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Text(
                                          'Date of Birth/Date de naissance ',
                                          style: TextStyle(
                                            color: Color(0xFF50A0FF),
                                            fontSize: 9.25,
                                            fontFamily: 'Open Sans',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 150.82,
                        top: 0,
                        child: Container(
                          width: 141.58,
                          height: 41.61,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                        ),
                      ),
                      Positioned(
                        left: 150.82,
                        top: 50.85,
                        child: Container(
                          width: 130.58,
                          height: 41.61,
                          padding:
                              const EdgeInsets.only(top: 5.78, bottom: 6.80),
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 50,
                                height: double.infinity,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: -0,
                                      top: 15.02,
                                      child: Text(
                                        'M',
                                        style: TextStyle(
                                          color: Color(0xFF141010),
                                          fontSize: 13.87,
                                          fontFamily: 'OCR-B 10 BT',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Text(
                                        'Sex/Sexe',
                                        style: TextStyle(
                                          color: Color(0xFF50A0FF),
                                          fontSize: 9.25,
                                          fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 150.82,
                        top: 101.71,
                        child: Container(
                          width: 141.58,
                          height: 46.61,
                          padding: const EdgeInsets.only(
                              top: 5.78, right: 8.58, bottom: 6.80),
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 133,
                                height: double.infinity,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: -0,
                                      top: 15.02,
                                      child: getProfileModels.data != null
                                          ? Text(
                                              DateFormat("d MMM yyyy").format(
                                                  DateTime.parse(
                                                      getProfileModels
                                                          .data!.dateAdded!)),
                                              style: const TextStyle(
                                                color: Color(0xFF141010),
                                                fontSize: 13.87,
                                                fontFamily: 'OCR-B 10 BT',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          : const SizedBox(),
                                    ),
                                    const Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Text(
                                        'Date of Issue/Date d’emission',
                                        style: TextStyle(
                                          color: Color(0xFF50A0FF),
                                          fontSize: 9.25,
                                          fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomPage extends StatelessWidget {
  const CustomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: ShapeDecoration(
              color: const Color(0xFFFFFCF4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17.34),
              ),
            ),
            height: MediaQuery.of(context).size.height / 2,
            child: const Center(
              child: Text(
                'Custom Page',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
