import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Models/coverDesignModels.dart';
import '../../Models/getProfileModels.dart';
import '../../auth/signUpNextPage.dart';
import '../../auth/signUpPage.dart';
import '../../main.dart';

class PassportLegalNoticePage extends StatefulWidget {
  const PassportLegalNoticePage({super.key});

  @override
  State<PassportLegalNoticePage> createState() =>
      _PassportLegalNoticePageState();
}

class _PassportLegalNoticePageState extends State<PassportLegalNoticePage> {
// Your existing code...
  GetProfileModels getProfileModels = GetProfileModels();
  getUserProfile() async {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/get_profile";
    print("api: $apiUrl");
    if (!mounted) {
      return; // Check if the widget is still mounted
    }
    setState(() {
      isLoading = true;
      print("SharedPred UserId $userID");
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": " $userID"
    });
    if (!mounted) {
      return; // Check again if the widget is still mounted after the HTTP request
    }
    final responseString = response.body;
    print("getProfileModels Response: $responseString");
    print("status Code getProfileModels: ${response.statusCode}");

    if (response.statusCode == 200) {
      // After getting the user's profile data
      print("in 200 getProfileModels");
      print("SuucessFull");
      getProfileModels = getProfileModelsFromJson(responseString);
      if (getProfileModels.data != null) {
        await coverDesign();

        if (!mounted) {
          setState(() {});
        }
      } else {
        // Handle the case when user profile data is null
        print("User profile data is null");
      }
      if (!mounted) {
        return; // Check once more if the widget is still mounted before updating the state
      }
      setState(() {
        isLoading = false;
      });
      print('getProfileModels status: ${getProfileModels.status}');
    }
  }

  String? selectedOption;
  CoverDesignDataModel coverDesignDataModel = CoverDesignDataModel();

  String selectedPassportCountry = ""; // Variable to store the passport country

  coverDesign() async {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/get_cover_design";
    print("api: $apiUrl");

    setState(() {
      isLoading = true;
    });

    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": "$userID",
    });

    final responseString = response.body;
    print("responseCoverDesignApi: $responseString");
    print("status Code CoverDesign: ${response.statusCode}");
    print("in 200 signIn");

    if (response.statusCode == 200) {
      print("Successful");
      print("Cover Design Data: $responseString");

      setState(() {
        coverDesignDataModel = coverDesignDataModelFromJson(responseString);

        if (coverDesignDataModel.data != null &&
            getProfileModels.data != null) {
          for (int i = 0; i < coverDesignDataModel.data!.length; i++) {
            if (coverDesignDataModel.data![i].passportDesignId ==
                getProfileModels.data!.passportDesignId) {
              print(
                  "cover image ID: ${coverDesignDataModel.data![i].passportFrontCover}");

              print(" ${coverDesignDataModel.data![i].legalNotice}");
              setState(() {
                selectedOption =
                    coverDesignDataModel.data![i].passportFrontCover;
                selectedPassportCountry = coverDesignDataModel
                    .data![i].passportCountry
                    .toString(); // Store the passport country
                legalnotice = coverDesignDataModel.data![i].legalNotice;
                print("selectedOptionCoverDeign $selectedOption");
                print("selectedPassportCountry $selectedPassportCountry");
              });
            }
          }
        }
        isLoading = false;
      });

      print("Cover Design Data Length: ${coverDesignDataModel.data?.length}");
    }
  }

  String? legalnotice;
  @override
  void initState() {
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
          width: 453,
          height: 314,
          padding: const EdgeInsets.only(
            top: 35,
            left: 18.49,
            right: 18.49,
            bottom: 34.01,
          ),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: const Color(0xFFFFFCF5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17.33),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 416.02,
                height: 36.98,
                padding: const EdgeInsets.only(top: 7.51, bottom: 7.47),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: const Center(
                  child: Text(
                    'Legal notices',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF50A0FF),
                      fontSize: 16.18,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: 420.02,
                    height: 200.14,
                    padding: const EdgeInsets.only(bottom: 2.14),
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    child: legalnotice != null
                        ? Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: legalnotice!.toUpperCase() ??
                                      '', // Set the legal notice text here
                                  style: const TextStyle(
                                    color: Color(0xFF141010),
                                    fontSize: 9.24,
                                    fontFamily: 'OCR-B 10 BT',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.justify,
                          )
                        : const Text(""),
                  ),
                  if (isLoading) // Show circular progress indicator when isLoading is true
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
