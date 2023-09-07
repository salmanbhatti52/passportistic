// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/addItineraryModels.dart';
import '../auth/signUpNextPage.dart';
import '../auth/signUpPage.dart';
import '../main.dart';
import 'addItinerary2.dart';

class AddItineray extends StatefulWidget {
  final String? userId;
  const AddItineray({super.key, this.userId});

  @override
  State<AddItineray> createState() => _AddItinerayState();
}

class _AddItinerayState extends State<AddItineray> {
  TextEditingController addItineray = TextEditingController();
  final TextEditingController _Startdate = TextEditingController();
  final TextEditingController _Enddate = TextEditingController();

  ItinerayAddModels itineraryAddModels = ItinerayAddModels();
  String desiredItineraryId = "";

  itinerayAdd() async {
    // try {

    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/add_itinerary";
    print("api: $apiUrl");
    print("name: ${addItineray.text}");
    print("start date: ${_Startdate.text}");
    print("end date: ${_Enddate.text}");
    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "itinerary_name": addItineray.text,
      "passport_holder_id": "$userID",
      "departure_date": _Startdate.text,
      "return_date": _Enddate.text
    });
    final responseString = response.body;
    print("responseitineraryAddModelsi: $responseString");
    print("status Code itineraryAddModels: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 itineraryAddModels");
      print("SuucessFull");
      itineraryAddModels = itinerayAddModelsFromJson(responseString);
      String desiredItineraryName = addItineray.text;

      if (itineraryAddModels.data != null) {
        for (var itinerary in itineraryAddModels.data!) {
          if (itinerary.travelLtineraryName == desiredItineraryName) {
            desiredItineraryId = itinerary.travelLtineraryId!;
            break; // Found the desired itinerary, exit the loop
          }
        }
      }

      print("Desired Itinerary ID: $desiredItineraryId");

      setState(() {
        isLoading = false;
      });
      print('itineraryAddModels status: ${itineraryAddModels.status}');
    }
  }

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(_onFocusChange);
    _focusNode2.addListener(_onFocusChange);
    _focusNode6.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode1.removeListener(_onFocusChange);

    _focusNode2.removeListener(_onFocusChange);
    _focusNode6.removeListener(_onFocusChange);

    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isFocused1 = _focusNode1.hasFocus;
    bool isFocused2 = _focusNode2.hasFocus;
    bool isFocused6 = _focusNode6.hasFocus;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              "assets/arrowBack1.svg",
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, '/notification');
            },
            child: SvgPicture.asset(
              "assets/notification.svg",
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Center(
            child: SvgPicture.asset(
              "assets/log1.svg",
              height: 70.h,
              width: 219.w,
              color: const Color(0xFFF65734),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 15),
            child: Row(
              children: [
                Text(
                  'Itinerary and Diary Maintenance',
                  style: TextStyle(
                    color: Color(0xFFF65734),
                    fontSize: 21,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 15),
            child: Row(
              children: [
                Text(
                  'Add Itinerary',
                  style: TextStyle(
                    color: Color(0xFF141010),
                    fontSize: 20,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
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
                  controller: addItineray,
                  focusNode: _focusNode1,
                  style:
                      const TextStyle(color: Color(0xFF000000), fontSize: 16),
                  cursorColor: const Color(0xFF000000),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/routing.svg",
                        color: isFocused1
                            ? const Color(0xFFF65734)
                            : const Color(0xFFE0E0E5),
                      ),
                    ),
                    // suffixIcon: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: SvgPicture.asset("assets/arrowDown1.svg"),
                    //       ),
                    //     ]),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: "Add new itinerary ",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color(0xFFF3F3F3),
                      ),
                    ),
                    hintStyle: const TextStyle(
                      color: Color(0xFF525252),
                      fontSize: 14,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w500,
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
          Padding(
            padding: const EdgeInsets.all(5.0).r,
            child: Column(children: [
              Row(
                children: [
                  SizedBox(
                    width: 170.w,

                    // decoration: const BoxDecoration(color: Colors.red),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 3.5),
                          child: Text(
                            'Departure Date',
                            style: TextStyle(
                              color: Color(0xFF141010),
                              fontSize: 16,
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                focusNode: _focusNode2,
                                controller: _Enddate,
                                readOnly: true, // Prevent manual text input
                                onTap: () {
                                  // Open the date picker when the field is tapped
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  ).then((selectedDate) {
                                    if (selectedDate != null) {
                                      // Handle the selected date
                                      setState(() {
                                        _Enddate.text = DateFormat('yyyy-MM-dd')
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
                                      color: isFocused2
                                          ? const Color(0xFFF65734)
                                          : const Color(0xFFE0E0E5),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xFFF65734)),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  hintText: "Select Date",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: Color(0xFFF3F3F3)),
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
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 170.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 3.5),
                          child: Text(
                            'Return Date',
                            style: TextStyle(
                              color: Color(0xFF141010),
                              fontSize: 16,
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: TextFormField(
                                focusNode: _focusNode6,
                                controller: _Startdate,
                                readOnly: true, // Prevent manual text input
                                onTap: () {
                                  // Open the date picker when the field is tapped
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  ).then((selectedDate) {
                                    if (selectedDate != null) {
                                      // Handle the selected date
                                      setState(() {
                                        _Startdate.text =
                                            DateFormat('yyyy-MM-dd')
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
                                    borderSide: const BorderSide(
                                        color: Color(0xFFF65734)),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  hintText: "Select Date",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: Color(0xFFF3F3F3)),
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
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )
            ]),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                if (addItineray.text.isEmpty &&
                    _Startdate.text.isEmpty &&
                    _Enddate.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all the fields'),
                    ),
                  );
                } else {
                  await itinerayAdd();
                  if (itineraryAddModels.status == "success") {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ItineraryTwo(
                          // itinId: "${itineraryAddModels.data[''].travelLtineraryId}",
                          itinid: desiredItineraryId,
                          additinerarywidget: addItineray.text,
                        );
                      },
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Itinerary is Saved Successfully'),
                        backgroundColor: Color(0xFFF65734),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Something went wrong'),
                      ),
                    );
                  }
                }
                setState(() {
                  isLoading = false;
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 350,
                    height: 51,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFFFF8D74), Color(0xFFF65634)],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    // child: const Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       'Save',
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 20,
                    //         fontFamily: 'Satoshi',
                    //         fontWeight: FontWeight.w700,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                  isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text(
                          "Save and Continue",
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Or select an existing Itinerary or Travel Diary",
              style: TextStyle(
                color: Color(0xFFF65734),
                fontSize: 20,
                fontFamily: 'Satoshi',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ItineraryTwo(
                      //userId: widget.userId,
                      itinid: desiredItineraryId,
                      additinerarywidget: addItineray.text,
                    );
                  },
                ));
              },
              child: Container(
                width: 350,
                height: 51,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [Color(0xFFFF8D74), Color(0xFFF65634)],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Travel Diary',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  String? selectedOption;
}
