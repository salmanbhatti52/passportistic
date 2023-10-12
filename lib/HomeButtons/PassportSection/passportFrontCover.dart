import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/coverDesignModels.dart';
import '../../Models/getProfileModels.dart';
import '../../auth/signUpNextPage.dart';
import '../../auth/signUpPage.dart';
import '../../main.dart';

class FrontCover extends StatefulWidget {
  const FrontCover({super.key});

  @override
  State<FrontCover> createState() => _FrontCoverState();
}

class _FrontCoverState extends State<FrontCover> {
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
          setState(() {
            isLoading = false;
          });
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
        if (coverDesignDataModel.data != null) {
          final selectedPassportDesignId =
              getProfileModels.data?.passportDesignId;
          if (selectedPassportDesignId != null) {
            for (int i = 0; i < coverDesignDataModel.data!.length; i++) {
              if (coverDesignDataModel.data![i].passportDesignId ==
                  selectedPassportDesignId) {
                print(
                    "cover image ID: ${coverDesignDataModel.data![i].passportFrontCover}");
                setState(() {
                  selectedOption =
                      coverDesignDataModel.data![i].passportFrontCover;
                  print("selectedOptionCoverDesign $selectedOption");
                });
              }
            }
          } else {
            // Handle the case where passportDesignId is null in getProfileModels.data
            print("Passport Design ID is null in getProfileModels.data");
            // You can add specific error handling or set a default value here if needed
          }
        }

        isLoading = false;
      });

      print("Cover Design Data Length: ${coverDesignDataModel.data?.length}");
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
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    } else {
      return selectedOption != null
          ? Center(
              child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                "https://portal.passporttastic.com/public/$selectedOption",
                width: MediaQuery.of(context).size.width,
                height: 488,
              ),
            ))
          : const SizedBox();
    }
  }
}
