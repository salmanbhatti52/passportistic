import 'package:flutter/material.dart';
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

  AccommodationModels accommodationModels = AccommodationModels();
  String? _selectedTransportMode;

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
      "accomodation_nights": nights.text,
      "accomodation_breakfast": breakfasTIncluded.text,
      "accomodation_checkout_date": checkOuTDate.text
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset("assets/notification.svg"),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
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
                          checkInDate.text =
                              DateFormat('yyyy-MM-dd').format(selectedDate);
                          // Date.text = DateFormat.yMd().format(selectedDate);
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
                    hintText: "CheckI In Date",
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
                          checkOuTDate.text =
                              DateFormat('yyyy-MM-dd').format(selectedDate);
                          // Date.text = DateFormat.yMd().format(selectedDate);
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
                  controller: nights,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: "Nights",
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
              // setState(() {
              // isLoading = true;
              // });
              if (checkInDate.text.isEmpty &&
                  checkOuTDate.text.isEmpty &&
                  Address.text.isEmpty &&
                  establishmentName.text.isEmpty &&
                  typeoFAccommodation.text.isEmpty &&
                  nights.text.isEmpty &&
                  breakfasTIncluded.text.isEmpty &&
                  city.text.isEmpty) {
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
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Something went wrong',
                      ),
                    ),
                  );
                }
              }
              // setState(() {
              // isLoading = false;
              // });
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
            height: MediaQuery.of(context).size.height * 0.02,
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
                      'View Itinerary',
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
          )
        ]),
      ),
    );
  }
}