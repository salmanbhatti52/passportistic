import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/currencyModel.dart';
import '../../Models/getGenderList.dart';
import '../../Models/getProfileModels.dart';
import '../../auth/signUpNextPage.dart';
import '../../auth/signUpPage.dart';
import '../../main.dart';

class passportPage extends StatefulWidget {
  const passportPage({
    Key? key,
  }) : super(key: key);

  @override
  State<passportPage> createState() => _passportPageState();
}

class _passportPageState extends State<passportPage> {
  List<passportPage> passportPages = [];
  GetProfileModels getProfileModels = GetProfileModels();
  String? dateAdded;
  String? dobadded;
  getUserProfile() async {
    String apiUrl = "$baseUrl/get_profile";
    debugPrint("api: $apiUrl");
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
    debugPrint("getProfileModels Response: $responseString");
    debugPrint("status Code getProfileModels: ${response.statusCode}");

    if (response.statusCode == 200) {
      debugPrint("in 200 getProfileModels");
      debugPrint("SuucessFull");
      getProfileModels = getProfileModelsFromJson(responseString);
      if (!mounted) {
        return; // Check once more if the widget is still mounted before updating the state
      }

      debugPrint('getProfileModels status: ${getProfileModels.status}');
      await getCurrency();
      await genderid();
      String mrzDate = getProfileModels.data!.dateAdded!;
      String mrDate = getProfileModels.data!.dob!;
      int year = int.parse(mrzDate.substring(0, 2));
      int month = int.parse(mrzDate.substring(2, 4));
      int day = int.parse(mrzDate.substring(4, 6));
      int year1 = int.parse(mrDate.substring(0, 2));
      int month1 = int.parse(mrDate.substring(2, 4));
      int day1 = int.parse(mrDate.substring(4, 6));
      DateTime parsedDate = DateTime(2000 + year, month, day);
      DateTime parsedDate1 = DateTime(2000 + year1, month1, day1);
      dateAdded = DateFormat("yyyMMDD").format(parsedDate);
      dobadded = DateFormat("yyyyMMDD").format(parsedDate1);
      setState(() {
        isLoading = false;
      });
      debugPrint(dobadded);
      debugPrint(dateAdded);
    }
  }

  String? currencyName;

  CurrencyModel currencyModel = CurrencyModel();

  Future<void> getCurrency() async {
    String apiUrl = "$baseUrl/get_currency_list";
    debugPrint("api: $apiUrl");
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');

    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": "$userID"
    });
    final responseString = response.body;
    debugPrint("responsecurrencyModelApi: $responseString");
    debugPrint("status Code currencyModel : ${response.statusCode}");

    if (response.statusCode == 200) {
      debugPrint("SuucessFull");
      debugPrint("in 200 Currency list");
      currencyModel = currencyModelFromJson(response.body);
      if (currencyModel.data != null && getProfileModels.data != null) {
        if (currencyModel.data!.isNotEmpty) {
          for (int i = 0; i < currencyModel.data!.length; i++) {
            debugPrint(
                "Checking currencyId: ${currencyModel.data![i].currencyId}");
            if (currencyModel.data![i].currencyId ==
                getProfileModels.data!.currencyId) {
              debugPrint(
                  "Match found for currencyId: ${currencyModel.data![i].currencyId}");
              currencyName = currencyModel.data![i].currencyCode;
              debugPrint("currencyName $currencyName");
            }
          }
        } else {
          debugPrint("currencyModel.data is empty");
        }
      } else {
        debugPrint("currencyModel.data or getProfileModels.data is null");
      }

      debugPrint('currecnyModel status: ${currencyModel.status}');
    } else {
      debugPrint('Failed to load currency data');
    }
    setState(() {
      isLoading = false;
    });
  }

  GetGenderListModels getGenderListModels = GetGenderListModels();
  genderid() async {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/get_gender_list";
    debugPrint("api: $apiUrl");

    setState(() {
      isLoading = true;
    });

    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": " $userID"
    });

    final responseString = response.body;
    debugPrint("responseCoverDesignApi: $responseString");
    debugPrint("status Code CoverDesign: ${response.statusCode}");
    debugPrint("in 200 signIn");

    if (response.statusCode == 200) {
      debugPrint("Successful");
      debugPrint("Cover Design Data: $responseString");

      setState(() {
        getGenderListModels = getGenderListModelsFromJson(responseString);
        if (getGenderListModels.data != null && getProfileModels.data != null) {
          for (int i = 0; i < getGenderListModels.data!.length; i++) {
            if (getGenderListModels.data![i].genderId ==
                getProfileModels.data!.genderId) {
              debugPrint("genderId: ${getGenderListModels.data![i].genderId}");
              setState(() {
                genderName = getGenderListModels.data![i].gender;
                debugPrint("selectedgender $genderName");
              });
            }
          }
        }
        isLoading = false;
      });
    }
  }

  String? genderName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    if (isLoading) {
      return const Center(
          child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 2,
        backgroundColor: Color(0xFFF65734),
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ));
    } else {
      return isMobile
          ? Padding(
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
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
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
                                      getProfileModels.data!.profilePicture !=
                                          null
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
                            height: 55.98,
                            child: SizedBox(
                              width: 416.07,
                              child: getProfileModels.data != null
                                  ? Text(
                                      "S<${getProfileModels.data!.firstName}<<${getProfileModels.data!.middleName} ${getProfileModels.data!.lastName}<<<<<<<<<<<<<<<<<<<<<<<<<<<\n${getProfileModels.data!.passportNumber ?? "PA123456"}<<${currencyName ?? ""}<<$dobadded<<$dateAdded<<${getProfileModels.data!.numberOfPages}<<<",
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
                                SizedBox(
                                  width: double.infinity,
                                  height: 29.02,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: -0,
                                        top: 13.02,
                                        child: Text(
                                          currencyName != null ?  '$currencyName' : "",
                                          style: const TextStyle(
                                            color: Color(0xFF141010),
                                            fontSize: 13.87,
                                            fontFamily: 'OCR-B 10 BT',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      const Positioned(
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
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 76,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: -1,
                                                top: 11.02,
                                                child: getProfileModels.data !=
                                                        null
                                                    ? Text(
                                                        "${getProfileModels.data!.passportNumber ?? "PA123456"}",
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFF141010),
                                                          fontSize: 13.55,
                                                          fontFamily:
                                                              'OCR-B 10 BT',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      )
                                                    : const Text(""),
                                              ),
                                              const Positioned(
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
                                      'Name',
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
                                    padding: const EdgeInsets.only(
                                      top: 5.78,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 140,
                                          height: double.infinity,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 15.02,
                                                child: getProfileModels.data !=
                                                        null
                                                    ? Text(
                                                        " ${getProfileModels.data!.nationality}",
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFF141010),
                                                          fontSize: 12.87,
                                                          fontFamily:
                                                              'OCR-B 10 BT',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                              ),
                                              const Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Text(
                                                  'Nationality',
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
                                    padding: const EdgeInsets.only(
                                        top: 5.78, bottom: 6.80),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: double.infinity,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 0,
                                                  top: 13.02,
                                                  child: getProfileModels
                                                              .data !=
                                                          null
                                                      ? Text(
                                                          DateFormat(
                                                                  "d MMM yyyy")
                                                              .format(DateTime.parse(
                                                                  getProfileModels
                                                                      .data!
                                                                      .dob!)),
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFF141010),
                                                            fontSize: 13.87,
                                                            fontFamily:
                                                                'OCR-B 10 BT',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                                ),
                                                const Positioned(
                                                  left: 0,
                                                  top: 0,
                                                  child: Text(
                                                    'Date of Birth',
                                                    style: TextStyle(
                                                      color: Color(0xFF50A0FF),
                                                      fontSize: 9.25,
                                                      fontFamily: 'Open Sans',
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                    padding: const EdgeInsets.only(
                                        top: 5.78, bottom: 6.80),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          // color: Colors.black,
                                          width: 100,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: -0,
                                                top: 11.02,
                                                child: Text(
                                                  genderName != null ? '$genderName' : "",
                                                  style: const TextStyle(
                                                    color: Color(0xFF141010),
                                                    fontSize: 13.87,
                                                    fontFamily: 'OCR-B 10 BT',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              const Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Text(
                                                  'Gender',
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 133,
                                          height: double.infinity,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: -0,
                                                top: 15.02,
                                                child: getProfileModels.data !=
                                                        null
                                                    ? Text(
                                                        DateFormat("d MMM yyyy")
                                                            .format(DateTime.parse(
                                                                getProfileModels
                                                                    .data!
                                                                    .dateAdded!)),
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFF141010),
                                                          fontSize: 13.87,
                                                          fontFamily:
                                                              'OCR-B 10 BT',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                              ),
                                              const Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Text(
                                                  'Date of Issue',
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
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(38.0),
              child: RotatedBox(
                quarterTurns: 3,
                child: Center(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Container(
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFFFCF4),
                        // color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17.34),
                        ),
                      ),
                      width: 900, // Updated width
                      height: 700,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            width: 550.22,
                            height: 400.02,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 50,
                                left: 50,
                                right: 10,
                                bottom: 10,
                              ),
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
                                                getProfileModels
                                                        .data!.profilePicture !=
                                                    null
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
                                                "S<${getProfileModels.data!.firstName}<<${getProfileModels.data!.middleName} ${getProfileModels.data!.lastName}<<<<<<<<<<<<<<<<<<<<<<<<<<<\n${getProfileModels.data!.passportNumber ?? "PA123456"}<<${currencyName ?? ""}<<$dobadded<<$dateAdded<<${getProfileModels.data!.numberOfPages}<<<",
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                      padding:
                                          const EdgeInsets.only(right: 35.08),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                          SizedBox(
                                            width: double.infinity,
                                            height: 29.02,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: -0,
                                                  top: 13.02,
                                                  child: Text(
                                                    '$currencyName',
                                                    style: const TextStyle(
                                                      color: Color(0xFF141010),
                                                      fontSize: 13.87,
                                                      fontFamily: 'OCR-B 10 BT',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                const Positioned(
                                                  left: 0,
                                                  top: 0,
                                                  child: Text(
                                                    'Currency',
                                                    style: TextStyle(
                                                      color: Color(0xFF50A0FF),
                                                      fontSize: 9.25,
                                                      fontFamily: 'Open Sans',
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 76,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: -0,
                                                          top: 11.02,
                                                          child: getProfileModels
                                                                      .data !=
                                                                  null
                                                              ? Text(
                                                                  "${getProfileModels.data!.passportNumber ?? "PA123456"}",
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color(
                                                                        0xFF141010),
                                                                    fontSize:
                                                                        13.87,
                                                                    fontFamily:
                                                                        'OCR-B 10 BT',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                )
                                                              : const Text(""),
                                                        ),
                                                        const Positioned(
                                                          left: 0,
                                                          top: 0,
                                                          child: Text(
                                                            'Passport No.',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF50A0FF),
                                                              fontSize: 9.25,
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Name',
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
                                                        color:
                                                            Color(0xFF141010),
                                                        fontSize: 13.87,
                                                        fontFamily:
                                                            'OCR-B 10 BT',
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                              padding: const EdgeInsets.only(
                                                top: 5.78,
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 140,
                                                    height: double.infinity,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 0,
                                                          top: 15.02,
                                                          child: getProfileModels
                                                                      .data !=
                                                                  null
                                                              ? Text(
                                                                  " ${getProfileModels.data!.nationality}",
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color(
                                                                        0xFF141010),
                                                                    fontSize:
                                                                        12.87,
                                                                    fontFamily:
                                                                        'OCR-B 10 BT',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                )
                                                              : const SizedBox(),
                                                        ),
                                                        const Positioned(
                                                          left: 0,
                                                          top: 0,
                                                          child: Text(
                                                            'Nationality',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF50A0FF),
                                                              fontSize: 9.25,
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                                              padding: const EdgeInsets.only(
                                                  top: 5.78, bottom: 6.80),
                                              clipBehavior: Clip.antiAlias,
                                              decoration: const BoxDecoration(),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: SizedBox(
                                                      height: double.infinity,
                                                      child: Stack(
                                                        children: [
                                                          Positioned(
                                                            left: 0,
                                                            top: 13.02,
                                                            child: getProfileModels
                                                                        .data !=
                                                                    null
                                                                ? Text(
                                                                    DateFormat(
                                                                            "d MMM yyyy")
                                                                        .format(DateTime.parse(getProfileModels
                                                                            .data!
                                                                            .dob!)),
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Color(
                                                                          0xFF141010),
                                                                      fontSize:
                                                                          13.87,
                                                                      fontFamily:
                                                                          'OCR-B 10 BT',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  )
                                                                : const SizedBox(),
                                                          ),
                                                          const Positioned(
                                                            left: 0,
                                                            top: 0,
                                                            child: Text(
                                                              'Date of Birth',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFF50A0FF),
                                                                fontSize: 9.25,
                                                                fontFamily:
                                                                    'Open Sans',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
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
                                              padding: const EdgeInsets.only(
                                                  top: 5.78, bottom: 6.80),
                                              clipBehavior: Clip.antiAlias,
                                              decoration: const BoxDecoration(),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    // color: Colors.red,
                                                    width: 100,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: -0,
                                                          top: 11.02,
                                                          child: Text(
                                                            '$genderName' ?? "",
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xFF141010),
                                                              fontSize: 13.87,
                                                              fontFamily:
                                                                  'OCR-B 10 BT',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                        const Positioned(
                                                          left: 0,
                                                          top: 0,
                                                          child: Text(
                                                            'Gender',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF50A0FF),
                                                              fontSize: 9.25,
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                                                  top: 5.78,
                                                  right: 8.58,
                                                  bottom: 6.80),
                                              clipBehavior: Clip.antiAlias,
                                              decoration: const BoxDecoration(),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 133,
                                                    height: double.infinity,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: -0,
                                                          top: 15.02,
                                                          child: getProfileModels
                                                                      .data !=
                                                                  null
                                                              ? Text(
                                                                  DateFormat(
                                                                          "d MMM yyyy")
                                                                      .format(DateTime.parse(getProfileModels
                                                                          .data!
                                                                          .dateAdded!)),
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color(
                                                                        0xFF141010),
                                                                    fontSize:
                                                                        13.87,
                                                                    fontFamily:
                                                                        'OCR-B 10 BT',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                )
                                                              : const SizedBox(),
                                                        ),
                                                        const Positioned(
                                                          left: 0,
                                                          top: 0,
                                                          child: Text(
                                                            'Date of Issue',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF50A0FF),
                                                              fontSize: 9.25,
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                        ],
                      ),
                    );
                  }),
                ),
              ),
            );
    }
  }
}
