import 'dart:convert';
import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
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
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _flag = TextEditingController();
  final TextEditingController _passportDesign = TextEditingController();

  GetProfileModels getProfileModels = GetProfileModels();
  getUserProfile() async {
    // try {

    String apiUrl = "$baseUrl/get_profile";
    print("api: $apiUrl");
    setState(() {
      isLoading = true;
    });
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
      print("SuucessFull");
      getProfileModels = getProfileModelsFromJson(responseString);
      setState(() {
        isLoading = false;
      });
      print('getProfileModels status: ${getProfileModels.status}');
    }
  }

  UpdateProfileModels updateProfileModels = UpdateProfileModels();

  updateProfile() async {
    // try {

    String apiUrl = "$baseUrl/update_profile";
    print("api: $apiUrl");

    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": "$userID",
      "email": _email.text,
      "phone_number": _mobileNumberController.text,
      "gender_id": "$_slectedGenderId",
      "dob": _dob.text,
      "nationality": _flag.text,
      "passport_design_id": selectedOption,
      "profile_picture": base64imgGallery
    });
    final responseString = response.body;
    print("responseupdateProfileModelsAPI: $responseString");
    print("status Code updateProfileModels: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 updateProfileModels");
      print("SuucessFull");
      updateProfileModels = updateProfileModelsFromJson(responseString);
      setState(() {
        isLoading = false;
      });
      print('updateProfileModels status: ${updateProfileModels.status}');
    }
  }

  String? _slectedGenderId;

  GetGenderListModels getGenderListModels = GetGenderListModels();

  getGenderList() async {
    // try {
    String apiUrl = "$baseUrl/get_gender_list";
    print("api: $apiUrl");

    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": widget.userId,
    });
    final responseString = response.body;
    print("getGenderListModels: $responseString");
    print("status Code getGenderListModels : ${response.statusCode}");

    if (response.statusCode == 200) {
      print("SuucessFull");
      print("in 200 getGenderListModels list");
      getGenderListModels = getGenderListModelsFromJson(responseString);
      setState(() {
        isLoading = false;
      });

      print('getGenderListModels status: ${getGenderListModels.status}');
    }
  }
  // genderid() async {
  //   String apiUrl = "$baseUrl/get_gender_list";
  //   print("api: $apiUrl");

  //   setState(() {
  //     isLoading = true;
  //   });

  //   final response = await http.post(Uri.parse(apiUrl), headers: {
  //     'Accept': 'application/json',
  //   }, body: {
  //     "passport_holder_id": "$userID"
  //   });

  //   final responseString = response.body;
  //   print("responseCoverDesignApi: $responseString");
  //   print("status Code CoverDesign: ${response.statusCode}");
  //   print("in 200 signIn");

  //   if (response.statusCode == 200) {
  //     print("Successful");
  //     print("Cover Design Data: $responseString");
  //     setState(() {
  //       getGenderListModels = getGenderListModelsFromJson(responseString);
  //       // if (getGenderListModels.data != null) {
  //       //   for (int i = 0; i < getGenderListModels.data!.length; i++) {
  //       //     if (getGenderListModels.data![i].genderId ==
  //       //         getProfileModels.data!.genderId) {
  //       //       print("genderId: ${getGenderListModels.data![i].genderId}");
  //       //       setState(() {
  //       //         selectedgenderId = getGenderListModels.data![i].gender;
  //       //         print("selectedgender $selectedgenderId");
  //       //       });
  //       //     }
  //       //   }
  //       // }
  //       isLoading = false;
  //     });
  //   }
  // }
  Country? _selectedCountry;

  String? selectedgenderId;
  CoverDesignDataModel coverDesignDataModel = CoverDesignDataModel();
  SelectedCoverDesign selectedCoverDesign = SelectedCoverDesign();
  coverDesign() async {
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
        isLoading = false;
      });
      print("Cover Design Data Length: ${coverDesignDataModel.data?.length}");
    }
  }

  selectedDesign() async {
    String apiUrl = "$baseUrl/customer_design";
    print("api: $apiUrl");

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
    print("responseSelectedDesignApi: $responseString");
    print("status Code SelectedDesign: ${response.statusCode}");
    print("in 200 signIn");

    if (response.statusCode == 200) {
      print("Successful");
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
    // final DateTime? picked = await showDatePicker(
    //   context: context,
    //   initialDate: DateTime.now(),
    //   firstDate: DateTime(1900),
    //   lastDate: DateTime.now(),
    //    // Set mode to only select the date
    // );
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
          // DateFormat.yMd().format(selectedDate);
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

  @override
  Widget build(BuildContext context) {
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
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      const ProgressDialog(), // Show the custom dialog
                );

                await updateProfile();

                Navigator.pop(context); // Close the dialog after update

                if (updateProfileModels.status == "success") {
                  Navigator.pop(context);
                } else if (updateProfileModels.status != "success") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(updateProfileModels.message.toString()),
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
      body: SingleChildScrollView(
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
                  borderRadius: BorderRadius.circular(64),
                  child: SizedBox(
                    height: 120,
                    width: 120,
                    child: imagePathGallery != null
                        ? Image.file(imagePathGallery!, fit: BoxFit.cover)
                        : getProfileModels.data?.profilePicture != null
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
                      border: Border.all(width: 4, color: Colors.transparent),
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
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: const EdgeInsets.all(8.0),
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
                          decoration: const InputDecoration(
                            hintText: 'Mobile Number',
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF525252),
                            ),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF525252),
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
                padding: const EdgeInsets.all(8.0),
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
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF525252),
                            ),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF525252),
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
                              print(" _slectedGenderId $_slectedGenderId");
                            });
                          },
                          items: getGenderListModels.data?.map((gender) {
                                return DropdownMenuItem<String>(
                                  value: gender.genderId,
                                  child: Text(
                                    gender.gender ?? '',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF525252),
                                    ),
                                  ),
                                );
                              }).toList() ??
                              [],
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Gender',
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF525252),
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
                padding: const EdgeInsets.all(8.0),
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
                          decoration: const InputDecoration(
                            hintText: 'Date of Birth',
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF525252),
                            ),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF525252),
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
                        'assets/flag.svg',
                        color: const Color(0xFFFF8D74),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: TextFormField(
                          controller: _flag,

                          // readOnly: true,
                          // onTap: () {
                          //   showCountryPicker(
                          //     context: context,
                          //     countryListTheme: CountryListThemeData(
                          //       flagSize: 25,
                          //       backgroundColor: Colors.white,
                          //       textStyle: const TextStyle(
                          //           fontSize: 16, color: Colors.blueGrey),
                          //       bottomSheetHeight: 500,
                          //       borderRadius: const BorderRadius.only(
                          //         topLeft: Radius.circular(20.0),
                          //         topRight: Radius.circular(20.0),
                          //       ),
                          //       inputDecoration: InputDecoration(
                          //         prefixIcon: Padding(
                          //           padding: const EdgeInsets.all(8.0),
                          //           child: SvgPicture.asset(
                          //             'assets/flag.svg',
                          //           ),
                          //         ),

                          //         focusedBorder: OutlineInputBorder(
                          //           borderSide: const BorderSide(
                          //               color: Color(0xFFF65734)),
                          //           borderRadius: BorderRadius.circular(15.0),
                          //         ),
                          //         // labelText: 'Email',
                          //         hintText: "Country Name",
                          //         enabledBorder: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(15),
                          //           borderSide: const BorderSide(
                          //               color: Color(
                          //                   0xFFF3F3F3)), // change border color
                          //         ),
                          //         labelStyle: const TextStyle(),
                          //         hintStyle: const TextStyle(
                          //             color: Color(0xFFA7A9B7),
                          //             fontSize: 16,
                          //             fontWeight: FontWeight.w300,
                          //             fontFamily: "Satoshi"),
                          //         border: OutlineInputBorder(
                          //             borderRadius: BorderRadius.circular(15)),
                          //       ),
                          //     ),
                          //     onSelect: (Country country) {
                          //       setState(() {
                          //         _selectedCountry = country;
                          //         print(
                          //             'Selected country: ${country.displayNameNoCountryCode}');
                          //         print(_selectedCountry);
                          //       });
                          //     },
                          //   );
                          // },
                          // controller: TextEditingController(
                          //   text: _selectedCountry != null
                          //       ? _selectedCountry?.displayNameNoCountryCode
                          //       : '',
                          // ),

                          decoration: const InputDecoration(
                            hintText: 'Nationality',
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF525252),
                            ),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF525252),
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
                height: 50,
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                      onTap: () {},
                                      child: SvgPicture.asset(
                                          "assets/arrowDown.svg"))
                                ]),
                            hintText: 'Change the Passport Design',
                            hintStyle: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF525252),
                            ),
                            border: InputBorder.none,
                          ),
                          items: coverDesignDataModel.data
                                  ?.map<DropdownMenuItem<String>>((data) {
                                return DropdownMenuItem<String>(
                                  value: data.passportDesignId ?? '',
                                  child: Text(data.passportCountry ?? ''),
                                );
                              }).toList() ??
                              [],
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value;
                              selectedCoverImage = coverDesignDataModel.data
                                  ?.firstWhereOrNull(
                                    (data) => data.passportDesignId == value,
                                  )
                                  ?.passportFrontCover;
                              print("Selected Option: $selectedOption");
                              print(
                                  "Selected Cover Image: $selectedCoverImage");
                            });
                          },
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF525252),
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
    );
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
