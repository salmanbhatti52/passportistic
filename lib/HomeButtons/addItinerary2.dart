import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/addItineraryModels.dart';
import '../Models/itineraryGetModels.dart';
import '../auth/signUpNextPage.dart';
import '../auth/signUpPage.dart';
import '../main.dart';
import 'AdditineraryDetails/accomodationDetails.dart';
import 'additinerary1.dart';
import 'AdditineraryDetails/activities.dart';
import 'AdditineraryDetails/displayDiray.dart';
import 'AdditineraryDetails/traval.dart';

class ItineraryTwo extends StatefulWidget {
  final String? itinid;
  final String? additinerarywidget;
  const ItineraryTwo({super.key, this.additinerarywidget, this.itinid});

  @override
  State<ItineraryTwo> createState() => _ItineraryTwoState();
}

class _ItineraryTwoState extends State<ItineraryTwo> {
  String? selectedItinerary;
  String? _slecteditinerary;
  String desiredItineraryId = "";

  final FocusNode _focusNode1 = FocusNode();

  IteneraryGetModels iteneraryGetModels = IteneraryGetModels();
  ItinerayAddModels itineraryAddModels = ItinerayAddModels();

  itinerayGet() async {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    // try {

    String apiUrl = "$baseUrl/get_itinerary";
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
    print("responseitineraryAddModelsi: $responseString");
    print("status Code itineraryAddModels: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 itineraryAddModels");
      print("SuucessFull");
      iteneraryGetModels = iteneraryGetModelsFromJson(responseString);
      String desiredItineraryName = "$_slecteditinerary";

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
      print('itineraryAddModels status: ${iteneraryGetModels.status}');
    }
  }

  final String _selectedItinerary =
      ''; // Initialize it with a default value if needed

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode1.addListener(_onFocusChange);

    itinerayGet();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isFocused1 = _focusNode1.hasFocus;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Itinerary',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF004665),
            fontSize: 24,
            fontFamily: 'Satoshi',
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0,
        backgroundColor: const Color(0xFFC6FFE7),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset("assets/notification.svg"),
          )
        ],
      ),
      body: Column(children: [
        Expanded(
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              gradient: const LinearGradient(
                begin: Alignment(0.20, -0.98),
                end: Alignment(-0.2, 0.98),
                colors: [Color(0xFFC6FFE7), Color(0xFF00AEFF)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1),
              ),
            ),
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),

              // GestureDetector(
              //   onTap: () {
              //     DropdownButtonFormField<String>(
              //       value: _selectedItinerary,
              //       onChanged: (newValue) {
              //         setState(() {
              //           _selectedItinerary = newValue!;
              //           print("Selected Itinerary: $_selectedItinerary");
              //         });
              //       },
              //       items: iteneraryGetModels.data?.map((gender) {
              //             return DropdownMenuItem<String>(
              //               value: gender.travelLtineraryId,
              //               child: GestureDetector(
              //                 onTap: () {
              //                   setState(() {
              //                     _selectedItinerary =
              //                         gender.travelLtineraryId!;
              //                     print(
              //                         "Selected Itinerary: $_selectedItinerary");
              //                   });
              //                 },
              //                 child: Text(gender.travelLtineraryName ?? ''),
              //               ),
              //             );
              //           }).toList() ??
              //           [],
              //     );
              //   },
              //   child: Text(
              //     _selectedItinerary != ''
              //         ? _selectedItinerary
              //         : 'Select an itinerary', // Display the selected itinerary or a placeholder
              //     style: const TextStyle(
              //       color: Color(0xFF525252),
              //       fontSize: 24,
              //       fontFamily: 'Satoshi',
              //       fontWeight: FontWeight.w900,
              //     ),
              //   ),
              // ),

              Row(
                children: [
                  const SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<String>(
                          // iconDisabledColor: Colors.transparent,
                          // iconEnabledColor: Colors.transparent,
                          value: _slecteditinerary,
                          onChanged: (newValue) {
                            setState(() {
                              _slecteditinerary = newValue;
                              print(" _slecteditineraryId $_slecteditinerary");
                              
                            });
                          },
                          items: iteneraryGetModels.data?.map((gender) {
                                return DropdownMenuItem<String>(
                                  value: gender.travelLtineraryId,
                                  child: Text(gender.travelLtineraryName ?? ''),
                                );
                              }).toList() ??
                              [],

                          focusNode: _focusNode1,
                          style: const TextStyle(
                            color: Color(0xFF525252),
                            fontSize: 22,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w900,
                          ),
                          // cursorColor: const Color(0xFF000000),
                          // keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 70),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Select Itinerary",
                            hintStyle: TextStyle(
                              color: Color(0xFF525252),
                              fontSize: 24,
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const AdditeneraryNext();
                          },
                        ));
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Color(0xFF004665),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  if (_slecteditinerary == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please select an itinerary',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return TravelDetails(
                          itinid: _slecteditinerary!,
                        );
                      },
                    ));
                  }
                },
                child: Container(
                  width: 294,
                  height: 60,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x0F312E23),
                        blurRadius: 16,
                        offset: Offset(0, 8),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Travel Details',
                          style: TextStyle(
                            color: Color(0xFF525252),
                            fontSize: 16,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SvgPicture.asset("assets/blueArrow.svg"),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  if (_slecteditinerary == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please select an itinerary',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return AccommodationDetails(
                          itinid: _slecteditinerary!,
                        );
                      },
                    ));
                  }
                },
                child: Container(
                  width: 294,
                  height: 60,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x0F312E23),
                        blurRadius: 16,
                        offset: Offset(0, 8),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Accommodation Details',
                          style: TextStyle(
                            color: Color(0xFF525252),
                            fontSize: 16,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SvgPicture.asset("assets/blueArrow.svg"),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  if (_slecteditinerary == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please select an itinerary',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ActivitiesDetails(
                          itinid: _slecteditinerary!,
                        );
                      },
                    ));
                  }
                },
                child: Container(
                  width: 294,
                  height: 60,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x0F312E23),
                        blurRadius: 16,
                        offset: Offset(0, 8),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Activity Details',
                          style: TextStyle(
                            color: Color(0xFF525252),
                            fontSize: 16,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SvgPicture.asset("assets/blueArrow.svg"),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  if (_slecteditinerary == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please select an itinerary',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return DisplayDiary(
                          itinid: _slecteditinerary!,
                        );
                      },
                    ));
                  }
                },
                child: Container(
                  width: 294,
                  height: 60,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x0F312E23),
                        blurRadius: 16,
                        offset: Offset(0, 8),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.sp,
                      children: [
                        const Text(
                          'Display Itinerary',
                          style: TextStyle(
                            color: Color(0xFF525252),
                            fontSize: 16,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SvgPicture.asset("assets/blueArrow.svg"),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        )
      ]),
    );
  }
}
