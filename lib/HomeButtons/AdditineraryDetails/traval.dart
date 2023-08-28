import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:scanguard/HomeButtons/ItineraryDetails/travelDetailsPage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/transportListModels.dart';
import '../../Models/travalDetailsModels.dart';
import '../../auth/signUpNextPage.dart';
import '../../auth/signUpPage.dart';
import '../../main.dart';
import 'accomodationDetails.dart';

class TravelDetails extends StatefulWidget {
  final String? itinid;
  const TravelDetails({super.key,  this.itinid});

  @override
  State<TravelDetails> createState() => _TravelDetailsState();
}

class _TravelDetailsState extends State<TravelDetails> {
  TextEditingController travelMode = TextEditingController();
  TextEditingController departureCity = TextEditingController();
  TextEditingController departureDate = TextEditingController();
  TextEditingController departureTime = TextEditingController();
  TextEditingController operator = TextEditingController();
  TextEditingController tripDetails = TextEditingController();
  TextEditingController arrivalCity = TextEditingController();
  TextEditingController arrivalDate = TextEditingController();
  TextEditingController arrivalTime = TextEditingController();
  TextEditingController travelTime = TextEditingController();
  TextEditingController layOver = TextEditingController();
  TextEditingController dayno = TextEditingController();

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
      "passport_holder_id": "$userID"
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

  TravalDetailsModels travalDetailsModels = TravalDetailsModels();
  String? _selectedTransportMode;

  itinerayAdd() async {
    // try {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');

    String apiUrl = "$baseUrl/add_itinerary_details";
    print("api: $apiUrl");

    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "travel_ltinerary_id": widget.itinid,
      "passport_holder_id": "$userID",
      "departure_city": departureCity.text,
      "transport_id": "$_selectedTransportMode",
      "day_no": dayno.text,
      "trip_details": tripDetails.text,
      "departure_date": departureDate.text,
      "departure_time": departureTime.text,
      "travel_time": travelTime.text,
      "arrive_city": arrivalCity.text,
      "arrive_time": arrivalTime.text,
      "arrive_date": arrivalDate.text,
      "operator": operator.text
    });
    final responseString = response.body;
    print("response_travalDetailsModels: $responseString");
    print("status Code travalDetailsModels: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 itineraryAddModels");
      print("SuucessFull");
      travalDetailsModels = travalDetailsModelsFromJson(responseString);
      setState(() {
        isLoading = false;
      });
      print('travalDetailsModels status: ${travalDetailsModels.status}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mdoeofTransport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text(
          'UK 2023',
          style: TextStyle(
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
              'Ininerary',
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
                  controller: dayno,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: "Day No",
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButtonFormField<String>(
              iconDisabledColor: Colors.transparent,
              iconEnabledColor: Colors.transparent,
              value: _selectedTransportMode,
              onChanged: (newValue) {
                setState(() {
                  _selectedTransportMode = newValue;
                  print(_selectedTransportMode);
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
                  controller: departureCity,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: "Departure City",
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
                  controller: departureDate,
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
                          departureDate.text =
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
                    hintText: "Departure Date",
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
                  controller: departureTime,
                  keyboardType: TextInputType.name,
                  readOnly: true,
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((selectedTime) {
                      if (selectedTime != null) {
                        // Handle the selected time
                        setState(() {
                          final formattedTime =
                              '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}:00';
                          departureTime.text = formattedTime;
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
                    hintText: "Departure Time",
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
                  controller: operator,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: "Operator",
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
                  controller: tripDetails,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: "Trip Details",
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
                  controller: arrivalCity,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: "Arrival City",
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
                  controller: arrivalDate,
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
                          arrivalDate.text =
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
                    hintText: "Arrival Date",
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
                  controller: arrivalTime,
                  keyboardType: TextInputType.name,
                  readOnly: true,
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((selectedTime) {
                      if (selectedTime != null) {
                        // Handle the selected time
                        setState(() {
                          final formattedTime =
                              '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}:00';
                          arrivalTime.text = formattedTime;
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
                    hintText: "Arrival Time",
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
                  controller: travelTime,
                  keyboardType: TextInputType.name,
                  readOnly: true,
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((selectedTime) {
                      if (selectedTime != null) {
                        // Handle the selected time
                        setState(() {
                          final formattedTime =
                              '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}:00';
                          travelTime.text = formattedTime;
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
                    hintText: "Travel Time",
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
                  controller: layOver,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: "Lay-over",
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
              setState(() {
                isLoading = true;
              });
              if (operator.text.isEmpty &&
                  arrivalTime.text.isEmpty &&
                  arrivalDate.text.isEmpty &&
                  arrivalCity.text.isEmpty &&
                  travelTime.text.isEmpty &&
                  departureTime.text.isEmpty &&
                  departureDate.text.isEmpty &&
                  departureCity.text.isEmpty &&
                  tripDetails.text.isEmpty &&
                  dayno.text.isEmpty &&
                  _selectedTransportMode == null) {
                print(operator.text);
                print(arrivalTime.text);
                print(arrivalDate.text);
                print(arrivalCity.text);
                print(travelTime.text);
                print(departureTime.text);
                print(departureDate.text);
                print(departureCity.text);
                print(tripDetails.text);
                print(dayno.text);
                print("$_selectedTransportMode");
                print(widget.itinid);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Please fill all the fields',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              } else {
                await itinerayAdd();
                print(_selectedTransportMode);
                print(widget.itinid);
                if (travalDetailsModels.status == "success") {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) {
                      return AccommodationDetails(
                        itinid: widget.itinid,
                      );
                    },
                  ));
                } else if (travalDetailsModels.status != "success") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        travalDetailsModels.message.toString(),
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
                setState(() {
                  isLoading = false;
                });
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
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return TravelDetailsPage(
                    itinid: widget.itinid,
                  );
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
