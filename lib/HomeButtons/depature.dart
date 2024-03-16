// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:scanguard/HomeButtons/PassportSection/passport.dart';
import 'package:scanguard/Models/getProfileModels.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Home/homePage.dart';
import '../Home/shop.dart';
import '../Models/departedDetailsModels.dart';
import '../Models/getColorListModels.dart';
import '../Models/getCountryListModels.dart';
import '../Models/getStampImageModel.dart';
import '../Models/getStampShapeListModels.dart';
import '../Models/transportListModels.dart';
import '../Models/validationModelAPI.dart';
import '../auth/signUpNextPage.dart';
import '../auth/signUpPage.dart';
import '../main.dart';

class DepatureDetails extends StatefulWidget {
  final String? userId;
  const DepatureDetails({super.key, this.userId});

  @override
  State<DepatureDetails> createState() => _DepatureDetailsState();
}

class _DepatureDetailsState extends State<DepatureDetails> {
  TextEditingController cityname = TextEditingController();

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

  GetStampImageModels getStampImageModel = GetStampImageModels();

  getStampImage() async {
    // try {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/stamp_design";
    print("api: $apiUrl");
    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": userID,
      "travel_type": "Departed",
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
        isLoading = false;
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

  DepartedDetailsModels departedDetailsModels = DepartedDetailsModels();

  departedDetails() async {
    // try {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/departure_details";
    print("api: $apiUrl");
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    setState(() {
      isLoading = true;
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
      "stamps_arrive_depart": "Departed",
      "stamp_image": base64Image
    });
    final responseString = response.body;
    print("response_arrivalDetailsModels: $responseString");
    print("status Code arrivalDetailsModels: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 arrivalDetailsModels");
      print("SuucessFull");
      departedDetailsModels = departedDetailsModelsFromJson(responseString);
      setState(() {
        isLoading = false;
      });
      print('arrivalDetailsModels status: ${departedDetailsModels.status}');
    }
  }
  //-----------------------------------End of Departure Details----------------------------//

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

  String? formatedTime;
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

  TextEditingController time = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController city = TextEditingController();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();
  final FocusNode _focusNode7 = FocusNode();
  final FocusNode _focusNode8 = FocusNode();
  final FocusNode _focusNode9 = FocusNode();
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

  checkPassPortPages() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      title: 'Passport Pages Ended',
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

  bool load = false;
  ValidationModelApi validationModelApi = ValidationModelApi();
  validation() async {
    setState(() {
      load = true;
    });
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    var headersList = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var url =
        Uri.parse('https://portal.passporttastic.com/api/getPackageDetails');

    var body = {"passport_holder_id": "$userID"};

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode == 200) {
      validationModelApi = validationModelApiFromJson(resBody);
      print(resBody);
    } else {
      print(res.reasonPhrase);
      validationModelApi = validationModelApiFromJson(resBody);
    }
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    super.initState();
    validation();
    mdoeofTransport();
    getCountryList();
    shapeList();
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
    bool isFocused1 = _focusNode1.hasFocus;
    bool isFocused2 = _focusNode2.hasFocus;
    bool isFocused3 = _focusNode3.hasFocus;
    bool isFocused4 = _focusNode4.hasFocus;
    bool isFocused5 = _focusNode5.hasFocus;
    bool isFocused6 = _focusNode6.hasFocus;
    bool isFocused7 = _focusNode7.hasFocus;
    bool isFocused8 = _focusNode8.hasFocus;
    bool isFocused9 = _focusNode8.hasFocus;
    if (load == true) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            backgroundColor: Color(0xFFF65734),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 2,
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          forceMaterialTransparency: true,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              "assets/arrowBack1.svg",
              fit: BoxFit.scaleDown,
            ),
          ),
          title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 1, right: 10, left: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
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
                                validationModelApi.data != null
                                    ? Text(
                                        "${validationModelApi.data!.totalStamps} ",
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
                height: 35,
                width: 108,
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
                    "Departure Details",
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
                "Complete the following to get the Departure Stamp of your own choosing.  If you are not happy with your choices, please make alternative selections",
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
                                date.text = DateFormat('yyyy-MM-dd')
                                    .format(selectedDate);
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
                        // readOnly: true, // Prevent manual text input
                        onTap: () {
                          // Open the time picker when the field is tapped
                          showTimePicker(
                            context: context,
                            initialTime: const TimeOfDay(hour: 00, minute: 00),
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
                        //snakbar in flutter
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
                const Center(
                    child: Text(
                  "Departed",
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
                        if (validationModelApi.data!.totalStamps == 0) {
                          checkStamps();
                        } else if (validationModelApi.data!.totalPages == 0) {
                          checkPassPortPages();
                        } else {
                          if (cityname.text.isEmpty &&
                              _selectedTransportMode == null &&
                              _selectedStampShape == null &&
                              _selectedColor == null &&
                              date.text.isEmpty &&
                              time.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please Select all Fields",
                                backgroundColor: Colors.red);
                          } else {
                            await departedDetails();
                            if (departedDetailsModels.status == "success") {
                              Fluttertoast.showToast(
                                msg: "SuccessFull",
                                backgroundColor: Colors.green,
                              );
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const ViewPassport();
                                },
                              ));
                            } else {
                              Fluttertoast.showToast(
                                  msg: departedDetailsModels.message.toString(),
                                  backgroundColor: Colors.red);
                            }
                          }
                          // await departure();
                          // Navigator.push(context, MaterialPageRoute(
                          //   builder: (BuildContext context) {
                          //     return MainScreen();
                          //   },
                          // ));
                        }
                      },
                      child: Container(
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
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
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
// Widget _getShapeImage(String shapeName) {
//     final shape = shapeListModels.data?.firstWhere(
//       (shape) => shape.shapeName == shapeName,
//       orElse: () => null,
//     );

//     if (shape != null) {
//       return Image.network(
//         'https://portal.passporttastic.com/${shape.shapeImage}',
//         height: 100,
//         width: 100,
//       );
//     } else {
//       return Text('No shape data found.');
//     }
//   }
// }
  List<String> colors = ["Black", "Red", "Yellow", "Blue", "Pink"];

  String selectedHexColor = "";
  String selectedColor = "";
  String _singleValue = "Text alignment right";
  // String? _selectedCountry;
}
