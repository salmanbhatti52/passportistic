import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/coverDesignModels.dart';
import '../Models/getGenderList.dart';
import '../Models/getProfileModels.dart';
import '../auth/signUpNextPage.dart';
import '../auth/signUpPage.dart';
import '../main.dart';
import 'editProfile.dart';

class ViewProfile extends StatefulWidget {
  final String? userId;
  const ViewProfile({super.key, this.userId});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  File? imagePathGallery;
  String? base64imgGallery;
  Future pickImageGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
      if (xFile == null) {
        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        // const NavBar()), (Route<dynamic> route) => false);
      } else {
        Uint8List imageByte = await xFile.readAsBytes();
        base64imgGallery = base64.encode(imageByte);
        print("base64img $base64imgGallery");

        final imageTemporary = File(xFile.path);

        setState(() {
          imagePathGallery = imageTemporary;
          print("newImage $imagePathGallery");
          print("newImage64 $base64imgGallery");
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => SaveImageScreen(
          //           image: imagePath,
          //           image64: "$base64img",
          //         )));
        });
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: ${e.toString()}');
    }
  }

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
        if (coverDesignDataModel.data != null) {
          for (int i = 0; i < coverDesignDataModel.data!.length; i++) {
            if (coverDesignDataModel.data![i].passportDesignId ==
                getProfileModels.data!.passportDesignId) {
              print(
                  "cover image ID: ${coverDesignDataModel.data![i].passportFrontCover}");
              setState(() {
                selectedOption =
                    coverDesignDataModel.data![i].passportFrontCover;
                selectedPassportCountry = coverDesignDataModel
                    .data![i].passportCountry
                    .toString(); // Store the passport country
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

  GetGenderListModels getGenderListModels = GetGenderListModels();
  genderid() async {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/get_gender_list";
    print("api: $apiUrl");

    setState(() {
      isLoading = true;
    });

    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": "${widget.userId} ?? $userID"
    });

    final responseString = response.body;
    print("responseCoverDesignApi: $responseString");
    print("status Code CoverDesign: ${response.statusCode}");
    print("in 200 signIn");

    if (response.statusCode == 200) {
      print("Successful");
      print("Cover Design Data: $responseString");
      setState(() {
        getGenderListModels = getGenderListModelsFromJson(responseString);
        if (getGenderListModels.data != null) {
          for (int i = 0; i < getGenderListModels.data!.length; i++) {
            if (getGenderListModels.data![i].genderId ==
                getProfileModels.data!.genderId) {
              print("genderId: ${getGenderListModels.data![i].genderId}");
              setState(() {
                selectedgenderId = getGenderListModels.data![i].gender;
                print("selectedgender $selectedgenderId");
              });
            }
          }
        }
        isLoading = false;
      });
    }
  }

  String? selectedgenderId;
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
      print("wudget UserId ${widget.userId}");
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
        await genderid();
        setState(() {});
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfile();
    print("selectedOption $selectedOption");
    print("selectedGenderId $selectedgenderId");
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFFF65734),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Profile",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Color(0xFF525252)),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFC6FFE7),
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditProfile(userId: "${widget.userId}")));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/edit.svg"),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFC6FFE7),
                  Color(0xFF00AEFF),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    pickImageGallery();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(64),
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: imagePathGallery != null
                          ? Image.file(imagePathGallery!)
                          : getProfileModels.data?.profilePicture != null
                              ? Image.network(
                                  "https://portal.passporttastic.com/public/${getProfileModels.data!.profilePicture}",
                                  fit: BoxFit.cover,
                                )
                              : Container(), // Empty container as a fallback
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Center(
                child: Text(
                  "${getProfileModels.data?.firstName ?? ''} ${getProfileModels.data?.lastName ?? ''}",
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF000000)),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/phone.svg',
                        color: const Color(0xFfFF8D74),
                      ),
                      const SizedBox(width: 8.0),
                      const Text(
                        'Mobile Number',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF525252)),
                      ),
                      const Spacer(),
                      Text(
                        getProfileModels.data?.phoneNumber ?? '',
                        style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF000000)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/sms.svg',
                        color: const Color(0xFfFF8D74),
                      ),
                      const SizedBox(width: 8.0),
                      const Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF525252)),
                      ),
                      const Spacer(),
                      Text(
                        getProfileModels.data?.email ?? '',
                        style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF000000)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/gender.svg',
                        color: const Color(0xFfFF8D74),
                      ),
                      const SizedBox(width: 8.0),
                      const Text(
                        'Gender',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF525252)),
                      ),
                      const Spacer(),
                      Text(
                        " ${selectedgenderId ?? ''} ",
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF000000),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/calendar.svg',
                        color: const Color(0xFfFF8D74),
                      ),
                      const SizedBox(width: 8.0),
                      const Text(
                        'Date of Birth',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF525252)),
                      ),
                      const Spacer(),
                      Text(
                        getProfileModels.data?.dob ?? '',
                        style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF000000)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/flag.svg',
                        color: const Color(0xFfFF8D74),
                      ),
                      const SizedBox(width: 8.0),
                      const Text(
                        'Nationality',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF525252)),
                      ),
                      const Spacer(),
                      Text(
                        getProfileModels.data?.nationality ?? '',
                        style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF000000)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/terms.svg',
                        color: const Color(0xFfFF8D74),
                      ),
                      const SizedBox(width: 8.0),
                      const Text(
                        'Passport Design',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF525252)),
                      ),
                      const Spacer(),
                      Text(
                        selectedPassportCountry,
                        style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF000000)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              selectedOption != null
                  ? Center(
                      child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.network(
                        "https://portal.passporttastic.com/public/$selectedOption",
                        width: 200,
                        height: 200,
                      ),
                    ))
                  : const SizedBox(),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
            ]),
          )),
        ),
      );
    }
  }

  // Widget getImageWidget(String selectedOption) {
  //   Datum selectedDatum;

  //   for (var datum in coverDesignDataModel.data!) {
  //     if (datum.passportDesignId == selectedOption) {
  //       print(datum.passportDesignId);
  //       print("selectedOption $selectedOption");
  //       selectedDatum = datum;
  //       break;
  //     }
  //   }

  //   if (selectedDatum != null) {
  //     String baseUrl = "https://portal.passporttastic.com/public/";
  //     String imageUrl = baseUrl +
  //         (selectedDatum.passportFrontCover ?? ''); // Use 'image' field

  //     // Print the complete image link before returning the Image widget
  //     print("Image Link: $imageUrl");

  //     return Image.network(
  //       imageUrl,
  //       width: 298,
  //       errorBuilder: (context, error, stackTrace) {
  //         return SvgPicture.asset(
  //           "assets/cover.svg",
  //           width: 298,
  //         );
  //       },
  //     );
  //   } else {
  //     // Print debug information when selectedOption is not found in the data
  //     print("Selected image ID not found in the data: $selectedOption");

  //     // Return a fallback image when selectedOption doesn't match any image IDs
  //     return SvgPicture.asset(
  //       "assets/cover.svg",
  //       width: 298,
  //     );
  //   }
  // }
}
