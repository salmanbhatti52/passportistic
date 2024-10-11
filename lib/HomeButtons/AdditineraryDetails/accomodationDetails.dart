import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/accomodationModels.dart';
import '../../auth/signUpNextPage.dart';
import '../../auth/signUpPage.dart';
import '../../main.dart';
import '../ItineraryDetails/getAccomodationDetails.dart';
import 'activities.dart';

class AccommodationDetails extends StatefulWidget {
  final String? itinid;
  final String? itinname;
  const AccommodationDetails({super.key, this.itinid, this.itinname});

  @override
  State<AccommodationDetails> createState() => _AccommodationDetailsState();
}

class _AccommodationDetailsState extends State<AccommodationDetails> {
  TextEditingController city = TextEditingController();
  TextEditingController checkInDate = TextEditingController();
  TextEditingController establishmentName = TextEditingController();
  TextEditingController typeoFAccommodation = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController checkOuTDate = TextEditingController();
  TextEditingController nights = TextEditingController();
  TextEditingController breakfasTIncluded = TextEditingController();
  TextEditingController checkinTime = TextEditingController();
  TextEditingController checkOutTime = TextEditingController();

  AccommodationModels accommodationModels = AccommodationModels();
  String? _selectedTransportMode;
  String? formattedApiCheckOutTime;
  String? formattedApiCheckInTime;
  int numberOfNights = 0;
  accommodationDetails() async {
    // try {

    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');

    String apiUrl = "$baseUrl/add_itinerary_accomodations";
    print("api: $apiUrl");

    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "travel_ltinerary_id": "${widget.itinid}",
      "passport_holder_id": "$userID",
      "accomodation_city": city.text,
      "establishment_name": establishmentName.text,
      "accomodation_address": Address.text,
      "accomodation_type": typeoFAccommodation.text,
      "accomodation_checkin_date": checkInDate.text,
      "accomodation_nights": numberOfNights.toString(),
      "accomodation_breakfast": breakfasTIncluded.text,
      "accomodation_checkout_date": checkOuTDate.text,
      "accomodation_checkin_time": "$formattedApiCheckInTime",
      "accomodation_checkout_time": "$formattedApiCheckOutTime",
    });
    final responseString = response.body;
    print("response_travalDetailsModels: $responseString");
    print("status Code travalDetailsModels: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 itineraryAddModels");
      print("SuucessFull");
      accommodationModels = accommodationModelsFromJson(responseString);
      setState(() {
        isLoading = false;
      });
      print(
          'AaccommodationModelsDetailsModels status: ${accommodationModels.status}');
    }
  }

  @override
  void dispose() {
    city.dispose();
    checkInDate.dispose();
    establishmentName.dispose();
    typeoFAccommodation.dispose();
    Address.dispose();
    checkOuTDate.dispose();
    nights.dispose();
    breakfasTIncluded.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "${widget.itinname}",
          style: const TextStyle(
            color: Color(0xFF525252),
            fontSize: 24,
            fontFamily: 'Satoshi',
            fontWeight: FontWeight.w900,
          ),
        ),
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
    
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: SvgPicture.asset(
              "assets/log1.svg",
              height: 35.h,
              width: 108.w,
              color: const Color(0xFFF65734),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              'Accomodation',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFF65734),
                fontSize: 24,
                fontFamily: 'Satoshi',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  style:
                      const TextStyle(color: Color(0xFF000000), fontSize: 16),
                  cursorColor: const Color(0xFF000000),
                  controller: city,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: "City",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color(0xFFF3F3F3)), // change border color
                    ),
                    labelStyle: const TextStyle(),
                    hintStyle: const TextStyle(
                        color: Color(0xFFA7A9B7),
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Satoshi"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  style:
                      const TextStyle(color: Color(0xFF000000), fontSize: 16),
                  cursorColor: const Color(0xFF000000),
                  controller: checkInDate,
                  keyboardType: TextInputType.name,
                  onTap: () {
                    // Open the date picker when the field is tapped
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime
                          .now(), // Set the first selectable date to the current date
                      lastDate: DateTime(2100),
                    ).then((selectedDate) {
                      if (selectedDate != null) {
                        // Handle the selected date
                        setState(() {
                          checkInDate.text =
                              DateFormat('yyyy-MM-dd').format(selectedDate);
                        });
                      }
                    });
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: "Check In Date",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color(0xFFF3F3F3)), // change border color
                    ),
                    labelStyle: const TextStyle(),
                    hintStyle: const TextStyle(
                        color: Color(0xFFA7A9B7),
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Satoshi"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  style:
                      const TextStyle(color: Color(0xFF000000), fontSize: 16),
                  cursorColor: const Color(0xFF000000),
                  controller: checkinTime,
                  keyboardType: TextInputType.name,
                  onTap: () {
                    showTimePicker(
                      initialEntryMode: TimePickerEntryMode.inputOnly,
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((selectedTime) {
                      if (selectedTime != null) {
                        // Handle the selected time
                        final formattedDisplayTime = selectedTime
                            .format(context); // Display in AM/PM format
                        formattedApiCheckInTime =
                            '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}:00'; // 24-hour format for API

                        setState(() {
                          checkinTime.text = formattedDisplayTime;
                          print(formattedDisplayTime);
                          print(formattedApiCheckInTime);
                        });
                      }
                    });
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: "Check in Time",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color(0xFFF3F3F3)), // change border color
                    ),
                    labelStyle: const TextStyle(),
                    hintStyle: const TextStyle(
                        color: Color(0xFFA7A9B7),
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Satoshi"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  style:
                      const TextStyle(color: Color(0xFF000000), fontSize: 16),
                  cursorColor: const Color(0xFF000000),
                  controller: establishmentName,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: "Establishment Name",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color(0xFFF3F3F3)), // change border color
                    ),
                    labelStyle: const TextStyle(),
                    hintStyle: const TextStyle(
                        color: Color(0xFFA7A9B7),
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Satoshi"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  style:
                      const TextStyle(color: Color(0xFF000000), fontSize: 16),
                  cursorColor: const Color(0xFF000000),
                  controller: typeoFAccommodation,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: "Type of Accommodation",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color(0xFFF3F3F3)), // change border color
                    ),
                    labelStyle: const TextStyle(),
                    hintStyle: const TextStyle(
                        color: Color(0xFFA7A9B7),
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Satoshi"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  style:
                      const TextStyle(color: Color(0xFF000000), fontSize: 16),
                  cursorColor: const Color(0xFF000000),
                  controller: Address,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: "Address",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color(0xFFF3F3F3)), // change border color
                    ),
                    labelStyle: const TextStyle(),
                    hintStyle: const TextStyle(
                        color: Color(0xFFA7A9B7),
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Satoshi"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  style:
                      const TextStyle(color: Color(0xFF000000), fontSize: 16),
                  cursorColor: const Color(0xFF000000),
                  controller: checkOuTDate,
                  keyboardType: TextInputType.name,
                  // Prevent manual text input
                  onTap: () async {
                    // Open the date picker when the field is tapped
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );

                    if (selectedDate != null) {
                      final checkIn = DateTime.parse(checkInDate.text);
                      final checkOut = selectedDate;

                      // Calculate the duration between check-in and check-out

                      final duration = checkOut.difference(checkIn);

                      // Calculate the number of nights (round up to the nearest day)
                      numberOfNights = duration.inDays;
                      print("numberOfNights $numberOfNights");

                      // Handle the selected date and update checkOutDate.text
                      setState(() {
                        checkOuTDate.text =
                            DateFormat('yyyy-MM-dd').format(checkOut);
                      });
                    }
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: "Check out Date",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color(0xFFF3F3F3)), // change border color
                    ),
                    labelStyle: const TextStyle(),
                    hintStyle: const TextStyle(
                        color: Color(0xFFA7A9B7),
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Satoshi"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  style:
                      const TextStyle(color: Color(0xFF000000), fontSize: 16),
                  cursorColor: const Color(0xFF000000),
                  controller: checkOutTime,
                  keyboardType: TextInputType.name,
                  onTap: () {
                    showTimePicker(
                      initialEntryMode: TimePickerEntryMode.inputOnly,
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((selectedTime) {
                      if (selectedTime != null) {
                        // Handle the selected time
                        final formattedDisplayTime = selectedTime
                            .format(context); // Display in AM/PM format
                        formattedApiCheckOutTime =
                            '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}:00'; // 24-hour format for API

                        setState(() {
                          checkOutTime.text = formattedDisplayTime;
                          print(formattedDisplayTime);
                          print(formattedApiCheckOutTime);
                        });
                      }
                    });
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: "Check out Time",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color(0xFFF3F3F3)), // change border color
                    ),
                    labelStyle: const TextStyle(),
                    hintStyle: const TextStyle(
                        color: Color(0xFFA7A9B7),
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Satoshi"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  style:
                      const TextStyle(color: Color(0xFF000000), fontSize: 16),
                  cursorColor: const Color(0xFF000000),
                  controller: breakfasTIncluded,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: "Breakfast Included",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color(0xFFF3F3F3)), // change border color
                    ),
                    labelStyle: const TextStyle(),
                    hintStyle: const TextStyle(
                        color: Color(0xFFA7A9B7),
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Satoshi"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          GestureDetector(
            onTap: () async {
              if (checkInDate.text.isEmpty &&
                  checkOuTDate.text.isEmpty &&
                  Address.text.isEmpty &&
                  establishmentName.text.isEmpty &&
                  typeoFAccommodation.text.isEmpty &&
                  nights.text.isEmpty &&
                  breakfasTIncluded.text.isEmpty &&
                  city.text.isEmpty &&
                  checkinTime.text.isEmpty &&
                  checkOutTime.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Please fill all the fields',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              } else {
                await accommodationDetails();
                if (accommodationModels.status == "success") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Accommodation Added Successfully',
                      ),
                    ),
                  );
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ActivitiesDetails(
                          itinid: widget.itinid, itinname: widget.itinname);
                    },
                  ));
                } else if (accommodationModels.status != "success") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        accommodationModels.message.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Something went wrong',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return AccomodationDetailsPage(
                      itinid: widget.itinid, itinname: widget.itinname);
                },
              ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 350,
                height: 48,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side:
                        const BorderSide(width: 0.50, color: Color(0xFFFF8D74)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'View Accommodation Schedule',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFFF8D74),
                        fontSize: 20,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
        ]),
      ),
    );
  }
}
