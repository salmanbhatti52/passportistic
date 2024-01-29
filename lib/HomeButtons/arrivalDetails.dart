// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:scanguard/Models/getProfileModels.dart';
import 'package:scanguard/Models/getStampImageModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Home/shop.dart';
import '../Models/arrivalDetailsModels.dart';
import '../Models/getColorListModels.dart';
import '../Models/getCountryListModels.dart';
import '../Models/getStampShapeListModels.dart';
import '../Models/transportListModels.dart';
import '../auth/signUpNextPage.dart';
import '../auth/signUpPage.dart';
import '../main.dart';
import 'PassportSection/passport.dart';

class ArrivalDetails extends StatefulWidget {
  const ArrivalDetails({super.key});

  @override
  State<ArrivalDetails> createState() => _ArrivalDetailsState();
}

class _ArrivalDetailsState extends State<ArrivalDetails> {
  ArrivalDetailsModels arrivalDetailsModels = ArrivalDetailsModels();

  TextEditingController cityname = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController date = TextEditingController();

  GetStampShapeListModels getStampShapeListModels = GetStampShapeListModels();

  shapeList() async {
    // try {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/get_stamp_shape";
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
    print("response_getStampShapeListModels: $responseString");
    print("status Code getStampShapeListModels: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 getStampShapeListModels");
      print("SuucessFull");
      getStampShapeListModels = getStampShapeListModelsFromJson(responseString);
      setState(() {
        isLoading = false;
      });
      print(
          'getStampShapeListModels status: ${getStampShapeListModels.status}');
    }
  }

  TransportListModels transportListModels = TransportListModels();
  mdoeofTransport() async {
    // try {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/get_transport_mode";
    print("api: $apiUrl");
    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": userID,
    });
    final responseString = response.body;
    print("responseModeTransportModel: $responseString");
    print("status Code responseModeTransportModel: ${response.statusCode}");
    print("in 200 responseModeTransportModel");
    if (response.statusCode == 200) {
      print("SuccessFull");
      transportListModels = transportListModelsFromJson(responseString);
      setState(() {
        isLoading = false;
      });
      print('responseModeTransportModel status: ${transportListModels.status}');
    }
  }

  GetCountryListModels getCountryListModels = GetCountryListModels();
  getCountryList() async {
    // try {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/get_passport_design";
    print("api: $apiUrl");
    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": userID,
    });
    final responseString = response.body;
    print("response getCountryListModels: $responseString");
    print("status Code getCountryListModels: ${response.statusCode}");
    print("in 200 getCountryListModels");
    if (response.statusCode == 200) {
      print("SuccessFull");
      getCountryListModels = getCountryListModelsFromJson(responseString);
      setState(() {
        isLoading = false;
      });
      print('getCountryListModels status: ${getCountryListModels.status}');
    }
  }

  GetColorListModels getColorListModels = GetColorListModels();
  getColorList() async {
    // try {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/get_stamps_color";
    print("api: $apiUrl");
    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": userID,
    });
    final responseString = response.body;
    print("response getColorListModels: $responseString");
    print("status Code getColorListModels: ${response.statusCode}");
    print("in 200 getColorListModels");
    if (response.statusCode == 200) {
      print("SuccessFull");
      getColorListModels = getColorListModelsFromJson(responseString);
      setState(() {
        isLoading = false;
      });
      print('getColorListModels status: ${getColorListModels.status}');
    }
  }

  bool isLoading3 = false;
  GetStampImageModels getStampImageModel = GetStampImageModels();
  getStampImage() async {
    // try {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/stamp_design";
    print("api: $apiUrl");
    setState(() {
      isLoading3 = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": userID,
      "travel_type": "Arrival",
      "stamp_shape_name": _selectedStampShape,
      "shapes_id": stampShapeId,
      "country_name": _selectedCountry,
      "city_name": cityname.text,
      "arrival_date": date.text,
      "transport_mode_id": _selectedTransportMode,
      "stamps_color_id": _selectedColor
    });
    final responseString = response.body;
    print("response getStampImageModel: $responseString");
    print("status Code getStampImageModel: ${response.statusCode}");
    print("in 200 getStampImageModel");
    if (response.statusCode == 200) {
      print("SuccessFull");
      getStampImageModel = getStampImageModelsFromJson(responseString);
      final stampImageData = getStampImageModel.data;

      if (stampImageData != null && stampImageData.isNotEmpty) {
        // Extract the stamp image URL from the first item in the data list
        stampImageURL = stampImageData[0].stampShapeImage;
        print(
            "stampImageURL https://portal.passporttastic.com/public$stampImageURL");
      }
      await convertImageToBase64(
          'https://portal.passporttastic.com/public$stampImageURL');
      setState(() {
        isLoading3 = false;
      });
      print('getStampImageModel status: ${getStampImageModel.status}');
    }
  }

  Future<void> convertImageToBase64(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      final List<int> imageBytes = response.bodyBytes;
      final String base64 = base64Encode(imageBytes);

      setState(() {
        base64Image = base64;
        print("base64Image : $base64Image");
      });
    }
  }

  GetProfileModels getProfileModels = GetProfileModels();
  getUserProfile() async {
    String apiUrl = "$baseUrl/get_profile";
    print("api: $apiUrl");
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
    print("getProfileModels Response: $responseString");
    print("status Code getProfileModels: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 getProfileModels");
      print("SuucessFull");
      getProfileModels = getProfileModelsFromJson(responseString);
      if (getProfileModels.data!.passportStampsHeld == "0") {
        checkStamps();
      }
      setState(() {
        isLoading = false;
      });
      print('getProfileModels status: ${getProfileModels.status}');
    }
  }

  checkStamps() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      title: 'Stamps Ended',
      desc: 'Click OK to go to the shop page.',
      btnCancelOnPress: () {
        Navigator.pop(context); // Close the dialog
      },
      btnOkOnPress: () {
        Navigator.pop(context); // Close the dialog
        // Navigate to the shop page (replace 'ShopPage' with your actual route)
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const StampPage()));
      },
    ).show();
  }

  ColorFilter getColorFilter(Color color) {
    return ColorFilter.mode(
      color,
      BlendMode.modulate,
    );
  }

  Widget coloredImage(String imageUrl, Color color) {
    return ColorFiltered(
      colorFilter: getColorFilter(color),
      child: Image.network(imageUrl),
    );
  }

  bool isLoading2 = false;
  final imageUrl =
      'https://img.freepik.com/premium-vector/blank-rubber-stamps-grunge-style-vintage-postage-stamps_422344-3475.jpg?w=740';
  arrivalDetails() async {
    // try {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/arrival_details";
    print("api: $apiUrl");
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    print("""

   "stamps_country": $_selectedCountry,
      "passport_holder_id": $userID,
      "stamps_city": ${cityname.text},
      "transport_mode_id": $_selectedTransportMode,
      "stamp_shape_id": $stampShapeId,
      "stamps_color_id": $_selectedColor,
      "stamps_date": ${date.text},
      "stamps_offset_rotation": "-5",
      "stamps_offset_vertical": "5",
      "stamps_offset_horizental": "8",
      "stamps_page_number": "24",
      "stamps_time": $formatedTime,
      "stamps_position_number": "12",
      "stamps_arrive_depart": "Arrive",
      "stamp_image": $base64Image


""");
    setState(() {
      isLoading2 = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "stamps_country": _selectedCountry,
      "passport_holder_id": userID,
      "stamps_city": cityname.text,
      "transport_mode_id": _selectedTransportMode,
      "stamp_shape_id": stampShapeId,
      "stamps_color_id": _selectedColor,
      "stamps_date": date.text,
      "stamps_offset_rotation": "-5",
      "stamps_offset_vertical": "5",
      "stamps_offset_horizental": "8",
      "stamps_page_number": "24",
      "stamps_time": formatedTime,
      "stamps_position_number": "12",
      "stamps_arrive_depart": "Arrive",
      "stamp_image": base64Image
    });
    final responseString = response.body;
    print("response_arrivalDetailsModels: $responseString");
    print("status Code arrivalDetailsModels: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 arrivalDetailsModels");
      print("SuucessFull");
      arrivalDetailsModels = arrivalDetailsModelsFromJson(responseString);
      setState(() {
        isLoading2 = false;
      });
      print('arrivalDetailsModels status: ${arrivalDetailsModels.status}');
    }
  }

  String? formatedTime;
  String? _selectedTransportMode;
  String? _selectedStampShape;
  String? _selectedCountry;
  String? _selectedColor;
  String? _selectedShapeName;
  String? _selectedShapeImage;
  String? _selectedShapeWidth;
  String? _selectedShapeHeight;
  String? modeImage;
  String? stampImageURL;
  String? base64Image;
  String? stampShapeId;

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();
  final FocusNode _focusNode7 = FocusNode();
  final FocusNode _focusNode8 = FocusNode();
  final FocusNode _focusNode9 = FocusNode();

  @override
  void initState() {
    super.initState();
    shapeList();
    mdoeofTransport();
    getCountryList();
    getColorList();
    getUserProfile();
    _focusNode1.addListener(_onFocusChange);
    _focusNode2.addListener(_onFocusChange);
    _focusNode3.addListener(_onFocusChange);
    _focusNode4.addListener(_onFocusChange);
    _focusNode5.addListener(_onFocusChange);
    _focusNode6.addListener(_onFocusChange);
    _focusNode7.addListener(_onFocusChange);
    _focusNode8.addListener(_onFocusChange);
    _focusNode9.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode1.removeListener(_onFocusChange);
    _focusNode2.removeListener(_onFocusChange);
    _focusNode3.removeListener(_onFocusChange);
    _focusNode4.removeListener(_onFocusChange);
    _focusNode5.removeListener(_onFocusChange);
    _focusNode6.removeListener(_onFocusChange);
    _focusNode7.removeListener(_onFocusChange);
    _focusNode8.removeListener(_onFocusChange);
    _focusNode9.removeListener(_onFocusChange);

    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isFocused5 = _focusNode5.hasFocus;
    bool isFocused6 = _focusNode6.hasFocus;

    // final _selectedColor = Color(int.parse('0x$_selectedColorString'));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            "assets/arrowBack1.svg",
            fit: BoxFit.scaleDown,
          ),
        ),
        title: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 1, right: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/approval.svg"),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Stamp Credits"),
                          const SizedBox(
                            width: 5,
                          ),
                          getProfileModels.data != null
                              ? Text(
                                  "${getProfileModels.data!.passportStampsHeld} ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.5)),
                                )
                              : const Text(""),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 1, right: 10),
            child: GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, '/notification');
              },
              child: SvgPicture.asset(
                "assets/notification.svg",
              ),
            ),
          ),
        ],
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
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Row(
              children: [
                Text(
                  "Arrival Details",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Color(0xFFF65734)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 1),
            child: Text(
              "Complete the following to get the Arrival Stamp of your own choosing.  If you are not happy with your choices, please make alternative selections",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF141111).withOpacity(0.5)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: DropdownButtonFormField<String>(
              iconDisabledColor: Colors.transparent,
              iconEnabledColor: Colors.transparent,
              value: _selectedCountry,
              onChanged: (newValue) {
                setState(() {
                  _selectedCountry = newValue;
                  print(_selectedCountry);
                });
              },
              items: getCountryListModels.data?.map((country) {
                    return DropdownMenuItem<String>(
                      value: country.passportCountry.toString(),
                      child: Text(country.passportCountry ?? ''),
                    );
                  }).toList() ??
                  [],
              decoration: InputDecoration(
                suffixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset("assets/arrowDown1.svg"),
                    ),
                  ],
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFF65734)),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                hintText: "Select Country",
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
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  controller: cityname,
                  style:
                      const TextStyle(color: Color(0xFF000000), fontSize: 16),
                  cursorColor: const Color(0xFF000000),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: "Write City Name",
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
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: DropdownButtonFormField<String>(
              iconDisabledColor: Colors.transparent,
              iconEnabledColor: Colors.transparent,
              value: _selectedTransportMode,
              onChanged: (newValue) {
                setState(() {
                  _selectedTransportMode = newValue;
                  // Find the selected transport mode based on its ID
                  final selectedTransportMode =
                      transportListModels.data?.firstWhere(
                    (mode) => mode.transportModeId == newValue,
                  );

                  if (selectedTransportMode != null) {
                    modeImage = selectedTransportMode.modeImage;
                    // Print all of the data associated with the selected transport mode
                    print(
                        "Transport Mode ID: ${selectedTransportMode.transportModeId}");
                    print("Mode Name: ${selectedTransportMode.modeName}");
                    print("Mode Image: $modeImage");
                  } else {
                    // Handle the case when no matching transport mode is found
                    print("No matching transport mode found.");
                  }
                });
              },
              items: transportListModels.data?.map((mode) {
                    return DropdownMenuItem<String>(
                      value: mode.transportModeId,
                      child: Text(mode.modeName ?? ''),
                    );
                  }).toList() ??
                  [],
              decoration: InputDecoration(
                suffixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset("assets/arrowDown1.svg"),
                    ),
                  ],
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFF65734)),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                hintText: "Select mode of transport",
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
            height: 10,
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Arrival Date and Time",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xFF141111)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      focusNode: _focusNode6,
                      controller: date,
                      readOnly: true, // Prevent manual text input
                      onTap: () {
                        // Open the date picker when the field is tapped
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        ).then((selectedDate) {
                          if (selectedDate != null) {
                            // Handle the selected date
                            setState(() {
                              date.text =
                                  DateFormat('yyyy-MM-dd').format(selectedDate);
                              // Date.text = DateFormat.yMd().format(selectedDate);
                            });
                          }
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            "assets/date.svg",
                            color: isFocused6
                                ? const Color(0xFFF65734)
                                : const Color(0xFFE0E0E5),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFFF65734)),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        hintText: "Select Date",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Color(0xFFF3F3F3)),
                        ),
                        hintStyle: const TextStyle(
                          color: Color(0xFFA7A9B7),
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Outfit",
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      focusNode: _focusNode5,
                      controller: time,
                      readOnly: true, // Prevent manual text input
                      onTap: () {
                        // Open the time picker when the field is tapped
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          initialEntryMode: TimePickerEntryMode.inputOnly,
                        ).then((selectedTime) {
                          if (selectedTime != null) {
                            // Handle the selected time
                            setState(() {
                              String formattedTime =
                                  selectedTime.format(context);
                              formatedTime =
                                  '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}:00';
                              time.text = DateFormat('hh:mm a').format(
                                DateFormat('hh:mm a').parse(formattedTime),
                              );
                              print(formatedTime);
                            });
                          }
                        });
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFFF65734)),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        hintText: "Select Time",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Color(0xFFF3F3F3)),
                        ),
                        hintStyle: const TextStyle(
                          color: Color(0xFFA7A9B7),
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Outfit",
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: GestureDetector(
                          onTap: () {
                            // Open the time picker when the icon is clicked
                            // showTimePicker(
                            //   context: context,
                            //   initialTime: TimeOfDay.now(),
                            // ).then((selectedTime) {
                            //   if (selectedTime != null) {
                            //     // Handle the selected time
                            //     setState(() {
                            //       String formattedTime =
                            //           selectedTime.format(context);
                            //       time.text = DateFormat('hh:mm a').format(
                            //         DateFormat('hh:mm a').parse(formattedTime),
                            //       );
                            //     });
                            //   }
                            // });
                          },
                          child: Icon(
                            Icons.access_time,
                            color: isFocused5
                                ? const Color(0xFFF65734)
                                : const Color(0xFFE0E0E5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                child: DropdownButtonFormField<String>(
                  iconDisabledColor: Colors.transparent,
                  iconEnabledColor: Colors.transparent,
                  value: _selectedColor,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedColor = newValue;
                      print(_selectedColor);
                    });
                  },
                  items: getColorListModels.data?.map((color) {
                        return DropdownMenuItem<String>(
                          value: color.stampsColorId.toString(),
                          child: Text(color.stampsColor ?? ''),
                        );
                      }).toList() ??
                      [],
                  decoration: InputDecoration(
                    suffixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset("assets/arrowDown1.svg"),
                        ),
                      ],
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    hintText: "Select Colors",
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
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                child: DropdownButtonFormField<String>(
                  iconDisabledColor: Colors.transparent,
                  iconEnabledColor: Colors.transparent,
                  value: _selectedStampShape,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedStampShape = newValue;
                      // Find the selected shape based on its name
                      final selectedShape =
                          getStampShapeListModels.data?.firstWhere(
                        (shape) => shape.shapeName == newValue,
                      );

                      if (selectedShape != null) {
                        stampShapeId = selectedShape.shapesId;
                        _selectedShapeName = selectedShape.shapeName;
                        _selectedShapeImage = selectedShape.shapeImage;
                        _selectedShapeWidth = selectedShape.width;
                        _selectedShapeHeight = selectedShape.height;
                        // Print all of the data associated with the selected shape
                        print("Shape ID: ${selectedShape.shapesId}");
                        print("Shape Name: $_selectedShapeName");
                        print("Shape Image: $_selectedShapeImage");
                        print("Width: $_selectedShapeWidth");
                        print("Height: $_selectedShapeHeight");
                      } else {
                        // Handle the case when no matching shape is found
                        print("No matching shape found.");
                      }
                    });
                    getStampImage();
                    if (getStampImageModel.status == "success") {
                      Fluttertoast.showToast(
                          msg: "Success", backgroundColor: Colors.green);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please Wait", backgroundColor: Colors.green);
                    }
                  },
                  items: getStampShapeListModels.data?.map((shape) {
                        return DropdownMenuItem<String>(
                          value: shape.shapeName,
                          child: Text(shape.shapeName ?? ''),
                        );
                      }).toList() ??
                      [],
                  decoration: InputDecoration(
                    suffixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset("assets/arrowDown1.svg"),
                        ),
                      ],
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    hintText: "Select Stamp Shape",
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
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       SingleChildScrollView(
              //         scrollDirection: Axis.horizontal,
              //         child: Row(
              //           children: colors.map((color) {
              //             bool isSelected = selectedColor == color;
              //             return GestureDetector(
              //               onTap: () {
              //                 setState(() {
              //                   selectedColor = isSelected ? "" : color;
              //                 });
              //               },
              //               child: Container(
              //                 width: 48,
              //                 height: 48,
              //                 margin: const EdgeInsets.symmetric(horizontal: 8),
              //                 decoration: BoxDecoration(
              //                   color: getColor(color),
              //                   shape: BoxShape.circle,
              //                   border: Border.all(
              //                     width: 2,
              //                     color: isSelected
              //                         ? Colors.white
              //                         : Colors.transparent,
              //                   ),
              //                 ),
              //                 child: isSelected
              //                     ? const Center(
              //                         child: Icon(
              //                           Icons.check,
              //                           color: Colors.white,
              //                           size: 20,
              //                         ),
              //                       )
              //                     : const SizedBox(), // Hide the tick mark when not selected
              //               ),
              //             );
              //           }).toList(),
              //         ),
              //       ),
              //       const SizedBox(height: 16),
              //       Padding(
              //         padding: const EdgeInsets.only(left: 8),
              //         child: Container(
              //           width: 122,
              //           height: 39,
              //           padding: const EdgeInsets.all(8),
              //           clipBehavior: Clip.antiAlias,
              //           decoration: ShapeDecoration(
              //             shape: RoundedRectangleBorder(
              //               side: const BorderSide(
              //                   width: 0.50, color: Color(0xFFE0E0E5)),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //           ),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Container(
              //                 width: 24,
              //                 height: 24,
              //                 decoration: BoxDecoration(
              //                   color: getColor(selectedColor),
              //                   shape: BoxShape.rectangle,
              //                 ),
              //               ),
              //               const SizedBox(width: 8),
              //               Text(
              //                 getColorHex(selectedColor),
              //                 style: const TextStyle(
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.bold,
              //                   color: Colors.black,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 10),

              const Center(
                  child: Text(
                "Arrival",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF141111)),
              )),
              Center(
                child: stampImageURL != null
                    ? Container(
                        width: 250, // Set the desired width
                        height: 200, // Set the desired height
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://portal.passporttastic.com/public/$stampImageURL'),
                            // Use BoxFit.cover to fit the complete image
                          ),
                        ),
                      )
                    : const Text("No stamp image available"),
              ),

              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      "Select Stamp Location",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF141111)),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    RadioButton(
                      description: "Randomly throughout passport",
                      value: "1",
                      groupValue: _singleValue,
                      onChanged: (value) => setState(
                        () => _singleValue = value ?? '',
                      ),
                      activeColor: const Color(0xFFFF8D74),
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF141111)),
                    ),
                    RadioButton(
                      description: "Chronological order",
                      value: "2",
                      groupValue: _singleValue,
                      onChanged: (value) => setState(
                        () => _singleValue = value ?? '',
                      ),
                      activeColor: const Color(0xFFFF8D74),
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF141111)),
                    ),
                    RadioButton(
                      description: "Position centrally",
                      value: "3",
                      groupValue: _singleValue,
                      onChanged: (value) => setState(
                        () => _singleValue = value ?? '',
                      ),
                      activeColor: const Color(0xFFFF8D74),
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF141111)),
                    ),
                    RadioButton(
                      description: "Position randomly",
                      value: "4",
                      groupValue: _singleValue,
                      onChanged: (value) => setState(
                        () => _singleValue = value ?? '',
                      ),
                      activeColor: const Color(0xFFFF8D74),
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF141111)),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      //                      await showDialog<String>(context: context, builder:(BuildContext context){});

                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (BuildContext context) {
                      //     return MainScreen();
                      //   },
                      // ));
                      if (stampShapeId == null && _selectedColor == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please fill the all fields',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      } else {
                        await arrivalDetails();
                        if (arrivalDetailsModels.status == "success") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'SuccessFully Stamped your Passport',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Colors.greenAccent,
                            ),
                          );
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const ViewPassport();
                            },
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Server Error!',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 48,
                          width: MediaQuery.of(context).size.width * 0.94,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFF65734), Color(0xFFFF8D74)],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Stamp My Passport",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Satoshi",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isLoading2)
                          const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          )
        ]),
      ),
    );
  }

  Color getColor(String colorName) {
    switch (colorName) {
      case "Black":
        return const Color(0xFF141010);
      case "Red":
        return const Color(0xFFFF3838);
      case "Yellow":
        return const Color(0xFFFF8C38);
      case "Blue":
        return const Color(0xFF3888FF);
      case "Pink":
        return const Color(0xFFFF3874);
      default:
        return Colors.transparent;
    }
  }

  String getColorHex(String colorName) {
    switch (colorName) {
      case "Black":
        return "#141010";
      case "Red":
        return "#FF3838";
      case "Yellow":
        return "#FF8C38";
      case "Blue":
        return "#3888FF";
      case "Pink":
        return "#FF3874";
      default:
        return "";
    }
  }

  List<String> colors = ["Black", "Red", "Yellow", "Blue", "Pink"];
  Color selectedColor = Colors.blue;
  String selectedHexColor = "";
  // String selectedColor = "";

  String _singleValue = "Text alignment right";
}
