import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';

import '../Home/shop.dart';

class ArrivalDetails extends StatefulWidget {
  const ArrivalDetails({super.key});

  @override
  State<ArrivalDetails> createState() => _ArrivalDetailsState();
}

class _ArrivalDetailsState extends State<ArrivalDetails> {
  TextEditingController time = TextEditingController();
  TextEditingController date = TextEditingController();

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
                          Text(
                            "0",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color:
                                    const Color(0xFF000000).withOpacity(0.5)),
                          ),
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(top: 30, left: 10),
          //       child: GestureDetector(
          //         onTap: () {
          //           Navigator.pop(context);
          //         },
          //         child: SvgPicture.asset(
          //           "assets/arrowBack1.svg",
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(top: 30, right: 10),
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Column(
          //           children: [
          //             Row(
          //               children: [
          //                 SvgPicture.asset("assets/approval.svg"),
          //                 SizedBox(
          //                   width: 5,
          //                 ),
          //                 Column(
          //                   mainAxisAlignment: MainAxisAlignment.start,
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text("Stamp Credits"),
          //                     SizedBox(
          //                       width: 5,
          //                     ),
          //                     Text(
          //                       "0",
          //                       style: TextStyle(
          //                           fontSize: 16,
          //                           fontWeight: FontWeight.w400,
          //                           color: Color(0xFF000000).withOpacity(0.5)),
          //                     ),
          //                   ],
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(top: 30, right: 10),
          //       child: GestureDetector(
          //         onTap: () {
          //           // Navigator.pushNamed(context, '/notification');
          //         },
          //         child: SvgPicture.asset(
          //           "assets/notification.svg",
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
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
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  focusNode: _focusNode7,
                  readOnly: true,
                  decoration: InputDecoration(
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
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      countryListTheme: CountryListThemeData(
                        flagSize: 25,
                        backgroundColor: Colors.white,
                        textStyle: const TextStyle(
                            fontSize: 16, color: Colors.blueGrey),
                        bottomSheetHeight: 500,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        inputDecoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFFF65734)),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          // labelText: 'Email',
                          hintText: "Country Name",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color:
                                    Color(0xFFF3F3F3)), // change border color
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
                      onSelect: (Country country) {
                        setState(() {
                          _selectedCountry = country;
                          print(
                              'Selected country: ${country.displayNameNoCountryCode}');
                        });
                      },
                    );
                  },
                  controller: TextEditingController(
                    text: _selectedCountry != null
                        ? _selectedCountry?.displayNameNoCountryCode
                        : '',
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
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
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
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
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
                width: 10,
              ),
            ],
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
                  focusNode: _focusNode3,
                  style:
                      const TextStyle(color: Color(0xFF000000), fontSize: 16),
                  cursorColor: const Color(0xFF000000),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
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
                      borderSide: const BorderSide(color: Color(0xFFF65734)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
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
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 12, top: 10),
            child: Row(
              children: [
                Text(
                  'Stamp Colour',
                  style: TextStyle(
                    color: Color(0xFF141010),
                    fontSize: 16,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: colors.map((color) {
                      bool isSelected = selectedColor == color;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedColor = isSelected ? "" : color;
                          });
                        },
                        child: Container(
                          width: 48,
                          height: 48,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: getColor(color),
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.transparent,
                            ),
                          ),
                          child: isSelected
                              ? const Center(
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                )
                              : const SizedBox(), // Hide the tick mark when not selected
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Container(
                    width: 122,
                    height: 39,
                    padding: const EdgeInsets.all(8),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 0.50, color: Color(0xFFE0E0E5)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: getColor(selectedColor),
                            shape: BoxShape.rectangle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          getColorHex(selectedColor),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
                      focusNode: _focusNode5,
                      controller: time,
                      readOnly: true, // Prevent manual text input
                      onTap: () {
                        // Open the time picker when the field is tapped
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((selectedTime) {
                          if (selectedTime != null) {
                            // Handle the selected time
                            setState(() {
                              String formattedTime =
                                  selectedTime.format(context);
                              time.text = DateFormat('hh:mm a').format(
                                DateFormat('hh:mm a').parse(formattedTime),
                              );
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
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((selectedTime) {
                              if (selectedTime != null) {
                                // Handle the selected time
                                setState(() {
                                  String formattedTime =
                                      selectedTime.format(context);
                                  time.text = DateFormat('hh:mm a').format(
                                    DateFormat('hh:mm a').parse(formattedTime),
                                  );
                                });
                              }
                            });
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
                height: 15,
              ),
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
                          firstDate: DateTime(2000),
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
              Center(child: SvgPicture.asset("assets/iran.svg")),
              const Center(
                  child: Text(
                "Arrival",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF141111)),
              )),
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
                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (BuildContext context) {
                      //     return MainScreen();
                      //   },
                      // ));
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
              const Text(
                "You have insufficient stamps to stamp your passport",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFF65734)),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: "please",
                  style: const TextStyle(
                      fontFamily: "Satoshi",
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFF65734)),
                  children: [
                    TextSpan(
                      text: " click here ",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFF65734),
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const StampPage();
                            },
                          ));
                        },
                    ),
                    const TextSpan(
                      text: "to purchase another package.",
                      style: TextStyle(
                          fontFamily: "Satoshi",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFF65734)),
                    )
                  ],
                ),
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

  String selectedHexColor = "";
  String selectedColor = "";

  String _singleValue = "Text alignment right";
  Country? _selectedCountry;
}
