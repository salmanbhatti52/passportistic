// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/coverDesignModels.dart';
import '../Models/getGenderList.dart';
import '../Models/getProfileModels.dart';
import '../Models/selectCoverDesign.dart';
import '../Models/updateProfileModels.dart';
import '../auth/signUpNextPage.dart';
import '../auth/signUpPage.dart';
import '../main.dart';
import 'package:collection/collection.dart';

class EditProfile extends StatefulWidget {
  final String? userId;
  const EditProfile({super.key, this.userId});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _flag = TextEditingController();
  String? _slectedGenderId;
  String? selectedgenderId;
  Country? _selectedCountry;
  String? countryString;
  GetProfileModels getProfileModels = GetProfileModels();
  getUserProfile() async {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/get_profile";
    debugPrint("api: $apiUrl");

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
      debugPrint("getProfileModels Response: $responseString");
      debugPrint("status Code getProfileModels: ${response.statusCode}");

      if (response.statusCode == 200) {
        debugPrint("in 200 getProfileModels");
        debugPrint("SuccessFull");
        getProfileModels = getProfileModelsFromJson(responseString);

        if (getProfileModels.data != null) {
          _email.text = getProfileModels.data?.email ?? '';
          _mobileNumberController.text =
              getProfileModels.data?.phoneNumber ?? '';
          _firstNameController.text = getProfileModels.data?.firstName ?? '';
          _lastNameController.text = getProfileModels.data?.lastName ?? '';
          _middleNameController.text = getProfileModels.data?.middleName ?? '';
          _dob.text = getProfileModels.data?.dob ?? '';
          countryString = getProfileModels.data?.nationality ?? '';
          _slectedGenderId = getProfileModels.data?.genderId ?? "11";
          getProfileModels.data?.passportDesignId != null
              ? selectedOption = getProfileModels.data?.passportDesignId
              : "";

          // Load the passport image when the page is initially loaded
        }
        debugPrint("$countryString");

        setState(() {
          isLoading = false;
        });

        debugPrint('getProfileModels status: ${getProfileModels.status}');
      } else {
        debugPrint("Error: ${response.reasonPhrase}");
        // Handle error cases if needed
      }
    } catch (e) {
      debugPrint("Error during API request: $e");
      // Handle exception if needed
    }
  }

  UpdateProfileModels updateProfileModels = UpdateProfileModels();

  updateProfile() async {
    // try {

    String apiUrl = "$baseUrl/update_profile";
    debugPrint("api: $apiUrl");

    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": "$userID",
      "email": _email.text,
      "phone_number": _mobileNumberController.text,
      "first_name": _firstNameController.text,
      "middle_name": _middleNameController.text,
      "last_name": _lastNameController.text,
      "gender_id": "$_slectedGenderId",
      "dob": _dob.text,
      "nationality": countryString,
      "passport_design_id": selectedOption,
      "profile_picture": base64imgGallery ?? "",
    });
    final responseString = response.body;
    debugPrint("responseupdateProfileModelsAPI: $responseString");
    debugPrint("status Code updateProfileModels: ${response.statusCode}");

    if (response.statusCode == 200) {
      debugPrint("in 200 updateProfileModels");
      debugPrint("SuucessFull");
      updateProfileModels = updateProfileModelsFromJson(responseString);
      setState(() {
        isLoading = false;
      });
      debugPrint('updateProfileModels status: ${updateProfileModels.status}');
    }
  }

  GetGenderListModels getGenderListModels = GetGenderListModels();

  getGenderList() async {
    // try {
    String apiUrl = "$baseUrl/get_gender_list";
    debugPrint("api: $apiUrl");

    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": widget.userId,
    });
    final responseString = response.body;
    debugPrint("getGenderListModels: $responseString");
    debugPrint("status Code getGenderListModels : ${response.statusCode}");

    if (response.statusCode == 200) {
      debugPrint("SuucessFull");
      debugPrint("in 200 getGenderListModels list");
      getGenderListModels = getGenderListModelsFromJson(responseString);
      if (!mounted) {
        setState(() {
          isLoading = false;
        });
      }
      debugPrint('getGenderListModels status: ${getGenderListModels.status}');
    }
  }
  // genderid() async {
  //   String apiUrl = "$baseUrl/get_gender_list";
  //   debugPrint("api: $apiUrl");

  //   setState(() {
  //     isLoading = true;
  //   });

  //   final response = await http.post(Uri.parse(apiUrl), headers: {
  //     'Accept': 'application/json',
  //   }, body: {
  //     "passport_holder_id": "$userID"
  //   });

  //   final responseString = response.body;
  //   debugPrint("responseCoverDesignApi: $responseString");
  //   debugPrint("status Code CoverDesign: ${response.statusCode}");
  //   debugPrint("in 200 signIn");

  //   if (response.statusCode == 200) {
  //     debugPrint("Successful");
  //     debugPrint("Cover Design Data: $responseString");
  //     setState(() {
  //       getGenderListModels = getGenderListModelsFromJson(responseString);
  // if (getGenderListModels.data != null) {
  //   for (int i = 0; i < getGenderListModels.data!.length; i++) {
  //     if (getGenderListModels.data![i].genderId ==
  //         getProfileModels.data!.genderId) {
  //       debugPrint("genderId: ${getGenderListModels.data![i].genderId}");
  //       setState(() {
  //         selectedgenderId = getGenderListModels.data![i].gender;
  //         debugPrint("selectedgender $selectedgenderId");
  //       });
  //     }
  //   }
  // }
  //       isLoading = false;
  //     });
  //   }
  // }

  CoverDesignDataModel coverDesignDataModel = CoverDesignDataModel();
  SelectedCoverDesign selectedCoverDesign = SelectedCoverDesign();

  Future<void> coverDesign() async {
    String apiUrl = "$baseUrl/get_cover_design";
    debugPrint("api: $apiUrl");

    setState(() {
      isLoading = true;
    });

    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": "$userID",
    });

    final responseString = response.body;
    debugPrint("responseCoverDesignApi: $responseString");
    debugPrint("status Code CoverDesign: ${response.statusCode}");
    debugPrint("in 200 signIn");

    if (response.statusCode == 200) {
      debugPrint("Successful");
      debugPrint("Cover Design Data: $responseString");

      setState(() {
        coverDesignDataModel = coverDesignDataModelFromJson(responseString);
        isLoading = false;
      });

      debugPrint(
          "Cover Design Data Length: ${coverDesignDataModel.data?.length}");

      // Now, set the selectedCoverImage based on the initial data
      if (coverDesignDataModel.data != null && selectedOption != null) {
        selectedCoverImage = coverDesignDataModel.data
            ?.firstWhereOrNull(
              (data) => data.passportDesignId == selectedOption,
            )
            ?.passportFrontCover;
      }
    }
  }

  selectedDesign() async {
    String apiUrl = "$baseUrl/customer_design";
    debugPrint("api: $apiUrl");

    setState(() {
      isLoading = true;
    });

    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": widget.userId,
      "passport_design_id": selectedOption,
    });

    final responseString = response.body;
    debugPrint("responseSelectedDesignApi: $responseString");
    debugPrint("status Code SelectedDesign: ${response.statusCode}");
    debugPrint("in 200 signIn");

    if (response.statusCode == 200) {
      debugPrint("Successful");
      setState(() {
        selectedCoverDesign = selectedCoverDesignFromJson(responseString);
        isLoading = false;
      });
    }
  }

  String? selectedOption;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfile();
    getGenderList();
    coverDesign();
  }

  bool isMaleSelected = false;
  bool isFemaleSelected = false;
  bool isOtherSelected = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _gender = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2100),
    ).then((selectedDate) {
      if (selectedDate != null) {
        // Handle the selected date
        setState(() {
          // Date.text =
          // ? DateFormat.yMd().format(selectedDate);
          _dob.text = DateFormat('yyyy-MM-dd').format(selectedDate);
        });
      }
      return null;
    });

    if (picked != null) {
      _dob.text = picked.toString();
    }
  }

  File? imagePathGallery;
  String? base64imgGallery;
  Future pickImageGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
      if (xFile == null) {
        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        //  NavBar()), (Route<dynamic> route) => false);
      } else {
        Uint8List imageByte = await xFile.readAsBytes();
        base64imgGallery = base64.encode(imageByte);
        debugPrint("base64img $base64imgGallery");

        final imageTemporary = File(xFile.path);

        setState(() {
          imagePathGallery = imageTemporary;
          debugPrint("newImage $imagePathGallery");
          debugPrint("newImage64 $base64imgGallery");
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
      debugPrint('Failed to pick image: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  if (_email.text.isEmpty &&
                      _mobileNumberController.text.isEmpty &&
                      _firstNameController.text.isEmpty &&
                      _middleNameController.text.isEmpty &&
                      _lastNameController.text.isEmpty &&
                      _dob.text.isEmpty &&
                      _flag.text.isEmpty &&
                      selectedOption == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please fill all the fields"),
                      ),
                    );
                  }

                  // showDialog(
                  //   context: context,
                  //   barrierDismissible: false,
                  //   builder: (context) =>
                  //        ProgressDialog(), // Show the custom dialog
                  // );
                  await updateProfile();

                  // Close the dialog after update

                  if (updateProfileModels.status == "success") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return EditProfile(
                            userId: userID,
                          );
                        },
                      ),
                    );
                  } else if (updateProfileModels.status != "success") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(updateProfileModels.message.toString()),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Something Went Wrong"),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF525252),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: isMobile
            ? SingleChildScrollView(
                child: Center(
                  child: Container(
                    // height: MediaQuery.of(context).size.height,
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
                    child: Column(
                        children: [
                      Center(
                        child: Stack(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(64),
                            child: SizedBox(
                              height: 120,
                              width: 120,
                              child: imagePathGallery != null
                                  ? Image.file(imagePathGallery!,
                                      fit: BoxFit.cover)
                                  : getProfileModels.data?.profilePicture !=
                                          null
                                      ? Image.network(
                                          "https://portal.passporttastic.com/public/${getProfileModels.data!.profilePicture}",
                                          fit: BoxFit.cover,
                                        )
                                      : Container(), // Empty container as a fallback
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              pickImageGallery();
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                top: 80,
                                left: 90,
                              ),
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF8D74),
                                border: Border.all(
                                    width: 4, color: Colors.transparent),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: SvgPicture.asset(
                                'assets/cam2.svg',
                                width: 10,
                                height: 10,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/person.svg',
                                  color: const Color(0xFFFF8D74),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: TextFormField(
                                    controller: _firstNameController,
                                    decoration: InputDecoration(
                                      hintText: 'First Name',
                                      hintStyle: TextStyle(
                                        fontSize: isMobile
                                            ? 16
                                            : (isTablet ? 20 : 20),
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF525252),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontSize:
                                          isMobile ? 16 : (isTablet ? 20 : 20),
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF525252),
                                    ),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(
                                          12), // Limit to 11 characters
                                      // You can also add other formatters if needed
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                          Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/person.svg',
                                  color: const Color(0xFFFF8D74),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: TextFormField(
                                    controller: _middleNameController,
                                    decoration: InputDecoration(
                                      hintText: 'Middle Name',
                                      hintStyle: TextStyle(
                                        fontSize: isMobile
                                            ? 16
                                            : (isTablet ? 20 : 20),
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF525252),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontSize:
                                          isMobile ? 16 : (isTablet ? 20 : 20),
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF525252),
                                    ),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(
                                          12), // Limit to 11 characters
                                      // You can also add other formatters if needed
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/person.svg',
                                  color: const Color(0xFFFF8D74),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: TextFormField(
                                    controller: _lastNameController,
                                    decoration: InputDecoration(
                                      hintText: 'Last Name',
                                      hintStyle: TextStyle(
                                        fontSize: isMobile
                                            ? 16
                                            : (isTablet ? 20 : 20),
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF525252),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontSize:
                                          isMobile ? 16 : (isTablet ? 20 : 20),
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF525252),
                                    ),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(
                                          12), // Limit to 11 characters
                                      // You can also add other formatters if needed
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/phone.svg',
                                  color: const Color(0xFFFF8D74),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: TextFormField(
                                    controller: _mobileNumberController,
                                    decoration: InputDecoration(
                                      hintText: 'Mobile Number',
                                      hintStyle: TextStyle(
                                        fontSize: isMobile
                                            ? 16
                                            : (isTablet ? 20 : 20),
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF525252),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontSize:
                                          isMobile ? 16 : (isTablet ? 20 : 20),
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF525252),
                                    ),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(
                                          12), // Limit to 11 characters
                                      // You can also add other formatters if needed
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                          padding: const EdgeInsets.all(5.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/sms.svg',
                                  color: const Color(0xFFFF8D74),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: TextFormField(
                                    controller: _email,
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                        fontSize: isMobile
                                            ? 16
                                            : (isTablet ? 20 : 20),
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF525252),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontSize:
                                          isMobile ? 16 : (isTablet ? 20 : 20),
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF525252),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.all(3.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/gender.svg',
                                  color: const Color(0xFFFF8D74),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    iconDisabledColor: Colors.transparent,
                                    iconEnabledColor: Colors.transparent,
                                    value: _slectedGenderId,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _slectedGenderId = newValue;
                                        debugPrint(
                                            " _slectedGenderId $_slectedGenderId");
                                      });
                                    },
                                    items: (getGenderListModels.data ?? [])
                                            .isEmpty
                                        ? null // Set items to null when there's no data
                                        : (getGenderListModels.data ?? [])
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                            final gender = entry.value;
                                            final index = entry.key;
                                            final genderId = gender.genderId ??
                                                'Male_$index'; // Handle null or duplicate values
                                            return DropdownMenuItem<String>(
                                              value: genderId,
                                              child: Text(
                                                gender.gender ?? '',
                                                style: TextStyle(
                                                  fontSize: isMobile
                                                      ? 16
                                                      : (isTablet ? 20 : 20),
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xFF525252),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Gender',
                                      hintStyle: TextStyle(
                                        fontSize: isMobile
                                            ? 16
                                            : (isTablet ? 20 : 20),
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF525252),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                          padding: const EdgeInsets.all(5.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2100),
                                    ).then((selectedDate) {
                                      if (selectedDate != null) {
                                        // Handle the selected date
                                        setState(() {
                                          _dob.text = DateFormat('yyyy-MM-dd')
                                              .format(selectedDate);
                                          // Date.text = DateFormat.yMd().format(selectedDate);
                                        });
                                      }
                                    });
                                  },
                                  child: SvgPicture.asset(
                                    'assets/calendar.svg',
                                    color: const Color(0xFFFF8D74),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: TextFormField(
                                    controller: _dob,
                                    readOnly: true, // Prevent manual text input
                                    onTap: () {
                                      // Open the date picker when the field is tapped
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime(2100),
                                      ).then((selectedDate) {
                                        if (selectedDate != null) {
                                          // Handle the selected date
                                          setState(() {
                                            _dob.text = DateFormat('yyyy-MM-dd')
                                                .format(selectedDate);
                                            // Date.text = DateFormat.yMd().format(selectedDate);
                                          });
                                        }
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Date of Birth',
                                      hintStyle: TextStyle(
                                        fontSize: isMobile
                                            ? 16
                                            : (isTablet ? 20 : 20),
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF525252),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontSize:
                                          isMobile ? 16 : (isTablet ? 20 : 20),
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF525252),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                          padding: const EdgeInsets.all(5.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/flag.svg',
                                  color: const Color(0xFFFF8D74),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: TextFormField(
                                    // controller: _flag,

                                    readOnly: true,
                                    onTap: () {
                                      showCountryPicker(
                                        context: context,
                                        countryListTheme: CountryListThemeData(
                                          flagSize: 25,
                                          backgroundColor: Colors.white,
                                          textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.blueGrey),
                                          bottomSheetHeight: 500,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0),
                                          ),
                                          inputDecoration: InputDecoration(
                                            prefixIcon: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SvgPicture.asset(
                                                'assets/flag.svg',
                                              ),
                                            ),

                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color(0xFFF65734)),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            // labelText: 'Email',
                                            hintText: "Country Name",
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: const BorderSide(
                                                  color: Color(
                                                      0xFFF3F3F3)), // change border color
                                            ),
                                            labelStyle: const TextStyle(),
                                            hintStyle: const TextStyle(
                                                color: Color(0xFFA7A9B7),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                                fontFamily: "Satoshi"),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                          ),
                                        ),
                                        onSelect: (Country country) {
                                          setState(() {
                                            _selectedCountry = country;
                                            debugPrint(
                                                'Selected country: ${country.displayNameNoCountryCode}');
                                            countryString = country
                                                .displayNameNoCountryCode;
                                            debugPrint(
                                                "countryString: $countryString");
                                            debugPrint(
                                                _selectedCountry.toString());
                                          });
                                        },
                                      );
                                    },
                                    controller: TextEditingController(
                                      text: _selectedCountry != null
                                          ? _selectedCountry
                                              ?.displayNameNoCountryCode
                                          : '$countryString',
                                    ),

                                    decoration: InputDecoration(
                                      hintText: 'Nationality',
                                      hintStyle: TextStyle(
                                        fontSize: isMobile
                                            ? 16
                                            : (isTablet ? 20 : 20),
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF525252),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontSize:
                                          isMobile ? 16 : (isTablet ? 20 : 20),
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF525252),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                          padding: const EdgeInsets.all(3.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/terms.svg',
                                  color: const Color(0xFFFF8D74),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    iconDisabledColor: Colors.transparent,
                                    iconEnabledColor: Colors.transparent,
                                    value: selectedOption,
                                    decoration: InputDecoration(
                                      suffixIcon: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GestureDetector(
                                                onTap: () {},
                                                child: SvgPicture.asset(
                                                    "assets/arrowDown.svg"))
                                          ]),
                                      hintText: 'Change the Passport Design',
                                      hintStyle: TextStyle(
                                        fontSize: isMobile
                                            ? 16
                                            : (isTablet ? 20 : 20),
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF525252),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    items: coverDesignDataModel.data
                                            ?.map<DropdownMenuItem<String>>(
                                                (data) {
                                          return DropdownMenuItem<String>(
                                            value: data.passportDesignId ?? '',
                                            child: Text(
                                                data.passportCountry ?? ''),
                                          );
                                        }).toList() ??
                                        [],
                                    onChanged: (value) {
                                      setState(() {
                                        selectedOption = value;
                                        selectedCoverImage =
                                            coverDesignDataModel.data
                                                ?.firstWhereOrNull(
                                                  (data) =>
                                                      data.passportDesignId ==
                                                      value,
                                                )
                                                ?.passportFrontCover;
                                        debugPrint(
                                            "Selected Option: $selectedOption");
                                        debugPrint(
                                            "Selected Cover Image: $selectedCoverImage");
                                      });
                                    },
                                    style: TextStyle(
                                      fontSize:
                                          isMobile ? 16 : (isTablet ? 20 : 20),
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF525252),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 150,
                        height: 210,
                        decoration: BoxDecoration(
                          image: selectedCoverImage != null
                              ? DecorationImage(
                                  image: NetworkImage(
                                      "https://portal.passporttastic.com/public/$selectedCoverImage"),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ]),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Center(
                  child: Container(
                    // height: MediaQuery.of(context).size.height,
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
                      Center(
                        child: Stack(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(220),
                            child: SizedBox(
                              height: 220,
                              width: 220,
                              child: imagePathGallery != null
                                  ? Image.file(imagePathGallery!,
                                      fit: BoxFit.cover)
                                  : getProfileModels.data?.profilePicture !=
                                          null
                                      ? Image.network(
                                          "https://portal.passporttastic.com/public/${getProfileModels.data!.profilePicture}",
                                          fit: BoxFit.cover,
                                        )
                                      : Container(), // Empty container as a fallback
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              pickImageGallery();
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                top: 180,
                                left: 168,
                              ),
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF8D74),
                                border: Border.all(
                                    width: 4, color: Colors.transparent),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: SvgPicture.asset(
                                'assets/cam2.svg',
                                width: 10,
                                height: 10,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Container(
                          height: 72,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/person.svg',
                                  color: const Color(0xFFFF8D74),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: TextFormField(
                                    controller: _firstNameController,
                                    decoration: InputDecoration(
                                      hintText: 'First Name',
                                      hintStyle: TextStyle(
                                        fontSize: isMobile
                                            ? 16
                                            : (isTablet ? 20 : 20),
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF525252),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontSize:
                                          isMobile ? 16 : (isTablet ? 20 : 20),
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF525252),
                                    ),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(
                                          12), // Limit to 11 characters
                                      // You can also add other formatters if needed
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Container(
                          height: 72,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/person.svg',
                                  color: const Color(0xFFFF8D74),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: TextFormField(
                                    controller: _middleNameController,
                                    decoration: InputDecoration(
                                      hintText: 'Middle Name',
                                      hintStyle: TextStyle(
                                        fontSize: isMobile
                                            ? 16
                                            : (isTablet ? 20 : 20),
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF525252),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontSize:
                                          isMobile ? 16 : (isTablet ? 20 : 20),
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF525252),
                                    ),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(
                                          12), // Limit to 11 characters
                                      // You can also add other formatters if needed
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Container(
                          height: 72,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/person.svg',
                                  color: const Color(0xFFFF8D74),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: TextFormField(
                                    controller: _lastNameController,
                                    decoration: InputDecoration(
                                      hintText: 'Last Name',
                                      hintStyle: TextStyle(
                                        fontSize: isMobile
                                            ? 16
                                            : (isTablet ? 20 : 20),
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF525252),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontSize:
                                          isMobile ? 16 : (isTablet ? 20 : 20),
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF525252),
                                    ),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(
                                          12), // Limit to 11 characters
                                      // You can also add other formatters if needed
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Container(
                          height: 72,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/phone.svg',
                                  color: const Color(0xFFFF8D74),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: TextFormField(
                                    controller: _mobileNumberController,
                                    decoration: InputDecoration(
                                      hintText: 'Mobile Number',
                                      hintStyle: TextStyle(
                                        fontSize: isMobile
                                            ? 16
                                            : (isTablet ? 20 : 20),
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF525252),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontSize:
                                          isMobile ? 16 : (isTablet ? 20 : 20),
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF525252),
                                    ),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(
                                          12), // Limit to 11 characters
                                      // You can also add other formatters if needed
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          height: 72,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/sms.svg',
                                  color: const Color(0xFFFF8D74),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: TextFormField(
                                    controller: _email,
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                        fontSize: isMobile
                                            ? 16
                                            : (isTablet ? 20 : 20),
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF525252),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontSize:
                                          isMobile ? 16 : (isTablet ? 20 : 20),
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF525252),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Container(
                          height: 72,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.all(3.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/gender.svg',
                                  color: const Color(0xFFFF8D74),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    iconDisabledColor: Colors.transparent,
                                    iconEnabledColor: Colors.transparent,
                                    value: _slectedGenderId,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _slectedGenderId = newValue;
                                        debugPrint(
                                            " _slectedGenderId $_slectedGenderId");
                                      });
                                    },
                                    items: (getGenderListModels.data ?? [])
                                            .isEmpty
                                        ? null // Set items to null when there's no data
                                        : (getGenderListModels.data ?? [])
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                            final gender = entry.value;
                                            final index = entry.key;
                                            final genderId = gender.genderId ??
                                                'Male_$index'; // Handle null or duplicate values
                                            return DropdownMenuItem<String>(
                                              value: genderId,
                                              child: Text(
                                                gender.gender ?? '',
                                                style: TextStyle(
                                                  fontSize: isMobile
                                                      ? 16
                                                      : (isTablet ? 20 : 20),
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xFF525252),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Gender',
                                      hintStyle: TextStyle(
                                        fontSize: isMobile
                                            ? 16
                                            : (isTablet ? 20 : 20),
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF525252),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          height: 72,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2100),
                                    ).then((selectedDate) {
                                      if (selectedDate != null) {
                                        // Handle the selected date
                                        setState(() {
                                          _dob.text = DateFormat('yyyy-MM-dd')
                                              .format(selectedDate);
                                          // Date.text = DateFormat.yMd().format(selectedDate);
                                        });
                                      }
                                    });
                                  },
                                  child: SvgPicture.asset(
                                    'assets/calendar.svg',
                                    color: const Color(0xFFFF8D74),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: TextFormField(
                                    controller: _dob,
                                    readOnly: true, // Prevent manual text input
                                    onTap: () {
                                      // Open the date picker when the field is tapped
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime(2100),
                                      ).then((selectedDate) {
                                        if (selectedDate != null) {
                                          // Handle the selected date
                                          setState(() {
                                            _dob.text = DateFormat('yyyy-MM-dd')
                                                .format(selectedDate);
                                            // Date.text = DateFormat.yMd().format(selectedDate);
                                          });
                                        }
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Date of Birth',
                                      hintStyle: TextStyle(
                                        fontSize: isMobile
                                            ? 16
                                            : (isTablet ? 20 : 20),
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF525252),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontSize:
                                          isMobile ? 16 : (isTablet ? 20 : 20),
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF525252),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          height: 72,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/flag.svg',
                                  color: const Color(0xFFFF8D74),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: TextFormField(
                                    // controller: _flag,

                                    readOnly: true,
                                    onTap: () {
                                      showCountryPicker(
                                        context: context,
                                        countryListTheme: CountryListThemeData(
                                          flagSize: 25,
                                          backgroundColor: Colors.white,
                                          textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.blueGrey),
                                          bottomSheetHeight: 500,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0),
                                          ),
                                          inputDecoration: InputDecoration(
                                            prefixIcon: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SvgPicture.asset(
                                                'assets/flag.svg',
                                              ),
                                            ),

                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color(0xFFF65734)),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            // labelText: 'Email',
                                            hintText: "Country Name",
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: const BorderSide(
                                                  color: Color(
                                                      0xFFF3F3F3)), // change border color
                                            ),
                                            labelStyle: const TextStyle(),
                                            hintStyle: const TextStyle(
                                                color: Color(0xFFA7A9B7),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                                fontFamily: "Satoshi"),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                          ),
                                        ),
                                        onSelect: (Country country) {
                                          setState(() {
                                            _selectedCountry = country;
                                            debugPrint(
                                                'Selected country: ${country.displayNameNoCountryCode}');
                                            countryString = country
                                                .displayNameNoCountryCode;
                                            debugPrint(
                                                "countryString: $countryString");
                                            debugPrint(
                                                _selectedCountry.toString());
                                          });
                                        },
                                      );
                                    },
                                    controller: TextEditingController(
                                      text: _selectedCountry != null
                                          ? _selectedCountry
                                              ?.displayNameNoCountryCode
                                          : '$countryString',
                                    ),

                                    decoration: InputDecoration(
                                      hintText: 'Nationality',
                                      hintStyle: TextStyle(
                                        fontSize: isMobile
                                            ? 16
                                            : (isTablet ? 20 : 20),
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF525252),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontSize:
                                          isMobile ? 16 : (isTablet ? 20 : 20),
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF525252),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          height: 72,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.all(3.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/terms.svg',
                                  color: const Color(0xFFFF8D74),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    iconDisabledColor: Colors.transparent,
                                    iconEnabledColor: Colors.transparent,
                                    value: selectedOption,
                                    decoration: InputDecoration(
                                      suffixIcon: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GestureDetector(
                                                onTap: () {},
                                                child: SvgPicture.asset(
                                                    "assets/arrowDown.svg"))
                                          ]),
                                      hintText: 'Change the Passport Design',
                                      hintStyle: TextStyle(
                                        fontSize: isMobile
                                            ? 16
                                            : (isTablet ? 20 : 20),
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF525252),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    items: coverDesignDataModel.data
                                            ?.map<DropdownMenuItem<String>>(
                                                (data) {
                                          return DropdownMenuItem<String>(
                                            value: data.passportDesignId ?? '',
                                            child: Text(
                                                data.passportCountry ?? ''),
                                          );
                                        }).toList() ??
                                        [],
                                    onChanged: (value) {
                                      setState(() {
                                        selectedOption = value;
                                        selectedCoverImage =
                                            coverDesignDataModel.data
                                                ?.firstWhereOrNull(
                                                  (data) =>
                                                      data.passportDesignId ==
                                                      value,
                                                )
                                                ?.passportFrontCover;
                                        debugPrint(
                                            "Selected Option: $selectedOption");
                                        debugPrint(
                                            "Selected Cover Image: $selectedCoverImage");
                                      });
                                    },
                                    style: TextStyle(
                                      fontSize:
                                          isMobile ? 16 : (isTablet ? 20 : 20),
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF525252),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: 300,
                        height: 400,
                        decoration: BoxDecoration(
                          image: selectedCoverImage != null
                              ? DecorationImage(
                                  image: NetworkImage(
                                      "https://portal.passporttastic.com/public/$selectedCoverImage"),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
      );
    }
  }

  String? selectedCoverImage;
}

class ProgressDialog extends StatelessWidget {
  const ProgressDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 0,
      child: Container(
        height: 100,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(40),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
