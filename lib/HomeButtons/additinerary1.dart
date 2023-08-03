import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'addItinerary2.dart';

class AdditeneraryNext extends StatefulWidget {
  const AdditeneraryNext({super.key});

  @override
  State<AdditeneraryNext> createState() => _AdditeneraryNextState();
}

class _AdditeneraryNextState extends State<AdditeneraryNext> {
  TextEditingController add = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController _Startdate = TextEditingController();
  TextEditingController _Enddate = TextEditingController();

  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode6 = FocusNode();

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
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15),
            child: Row(
              children: [
                Text(
                  'Itinerary and Diary \nMaintenance',
                  style: TextStyle(
                    color: Color(0xFFF65734),
                    fontSize: 24,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15),
            child: Row(
              children: [
                Text(
                  'Add Itinerary',
                  style: TextStyle(
                    color: Color(0xFF141010),
                    fontSize: 16,
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
                  focusNode: _focusNode1,
                  style: TextStyle(color: Color(0xFF000000), fontSize: 16),
                  cursorColor: Color(0xFF000000),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/routing.svg",
                        color:
                            isFocused1 ? Color(0xFFF65734) : Color(0xFFE0E0E5),
                      ),
                    ),
                    suffixIcon: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset("assets/arrowDown1.svg"),
                          ),
                        ]),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: "Add new itinerary ",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Color(0xFFF3F3F3),
                      ),
                    ),
                    hintStyle: TextStyle(
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
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: Text(
                  'Add Itinerary',
                  style: TextStyle(
                    color: Color(0xFF141010),
                    fontSize: 16,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  focusNode: _focusNode2,
                  controller: name,
                  style: TextStyle(color: Color(0xFF000000), fontSize: 16),
                  cursorColor: Color(0xFF000000),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/sms.svg",
                        color:
                            isFocused2 ? Color(0xFFF65734) : Color(0xFFE0E0E5),
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: "Write itinerary name",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Color(0xFFF3F3F3),
                      ),
                    ),
                    hintStyle: TextStyle(
                      color: Color(0xFF9C9999),
                      fontSize: 14,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 15, bottom: 8),
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
                  SizedBox(
                    width: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 10),
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
                                ? Color(0xFFF65734)
                                : Color(0xFFE0E0E5),
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
                  Expanded(
                    child: TextFormField(
                      focusNode: _focusNode6,
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
                              _Enddate.text =
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
                                ? Color(0xFFF65734)
                                : Color(0xFFE0E0E5),
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
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ItineraryTwo();
                  },
                ));
              },
              child: Container(
                width: 350,
                height: 48,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [Color(0xFFFF8D74), Color(0xFFF65634)],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Continue to Itineray',
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
          ),
        ]),
      ),
    );
  }
}
