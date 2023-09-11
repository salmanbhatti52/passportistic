import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import '../../Models/diaryDetailsModels.dart';
import '../../auth/signUpNextPage.dart';
import '../../auth/signUpPage.dart';
import '../../main.dart';
import '../ItineraryDetails/getDisplayDairy.dart';

class DisplayDiary extends StatefulWidget {
  final String? itinid;
  final String? itinname;
  const DisplayDiary({super.key, this.itinid, this.itinname});
  @override
  _DisplayDiaryState createState() => _DisplayDiaryState();
}

class _DisplayDiaryState extends State<DisplayDiary> {
  List<File?> selectedImages = [];
  String buildImageUrlsString(List<String> imageUrls) {
    return imageUrls.join(
        ','); // Join the list elements with a comma (or another delimiter)
  }

  File? imagePathGallery;
  String? base64imgGallery;
  File? imagePathGallery1;
  String? base64imgGallery1;

  Future pickImageGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
      if (xFile == null) {
        // Handle if no image is selected
      } else {
        Uint8List imageBytes = await xFile.readAsBytes();
        base64imgGallery = base64.encode(imageBytes);
        print("base64img $base64imgGallery");

        final imageTemporary = File(xFile.path);

        setState(() {
          imagePathGallery = imageTemporary;
          print("newImage $imagePathGallery");
          print("newImage64 $base64imgGallery");
        });
      }
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  List<String> base64ImageUrls = [];

  Future pickImageGallery1() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);

      if (xFile == null) {
        // Handle if no image is selected
      } else {
        Uint8List imageBytes = await xFile.readAsBytes();
        final String base64imgGallery1 = base64.encode(imageBytes);
        print("base64img $base64imgGallery1");

        final imageTemporary = File(xFile.path);

        setState(() {
          imagePathGallery1 = imageTemporary;
          print("newImage $imagePathGallery1");
          print("newImage64 $base64imgGallery1");
          selectedImages.add(File(xFile.path));
          base64ImageUrls.add(base64imgGallery1);
          print("base64ImageUrls ${base64ImageUrls.join(', ')}");
          print("Number of base64ImageUrls: ${base64ImageUrls.length}");
        });
      }
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  String? formattedDate;
  List<String> base64EncodedImageList = [];
  // List<File?> selectedImageList = [];

  Future<void> pickImageFromGallery(int index) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);

      if (xFile != null) {
        Uint8List imageBytes = await xFile.readAsBytes();
        String base64EncodedImage = base64.encode(imageBytes);

        setState(() {
          base64EncodedImageList[index] = base64EncodedImage;
          selectedImages[index] = File(xFile.path);
        });
      }
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  TextEditingController comments = TextEditingController();

  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();

  DirayDetailsModels dirayDetailsModels = DirayDetailsModels();

  dirayDetails() async {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/add_travel_diary";
    print("api: $apiUrl");

    setState(() {
      isLoading = true;
    });

    // Convert base64EncodedImageList to JSON array format
    String imagesJson = jsonEncode(base64ImageUrls);
    String imageUrlString = base64ImageUrls.join(",");

    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "travel_ltinerary_id": "${widget.itinid}",
      "travel_diary_date": formattedDate,
      "travel_diary_entry": comments.text,
      "tavel_diary_picture_images": imagesJson
      // Add the images JSON array
    });

    final responseString = response.body;
    print("response_travalDetailsModels: $responseString");
    print("status Code travalDetailsModels: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 itineraryAddModels");
      print("SuucessFull");
      dirayDetailsModels = dirayDetailsModelsFromJson(responseString);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Successfully Added',
            textAlign: TextAlign.center,
          ),
        ),
      );
      setState(() {
        isLoading = false;
      });
      print('dirayDetailsModels status: ${dirayDetailsModels.status}');
    }
  }

  function() async {
    var headersList = {'Accept': '*/*', 'Content-Type': 'application/json'};
    var url =
        Uri.parse('https://portal.passporttastic.com/api/add_travel_diary');
    String imagesJson = jsonEncode(base64ImageUrls);
    String imageUrlString = base64ImageUrls.join(",");
    var body = {
      "travel_ltinerary_id": "${widget.itinid}",
      "travel_diary_date": formattedDate,
      "travel_diary_entry": comments.text,
      "tavel_diary_picture_images": base64ImageUrls
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Successfully Added',
            textAlign: TextAlign.center,
          ),
        ),
      );
      // Navigator.pushReplacement(context, MaterialPageRoute(
      //   builder: (BuildContext context) {
      //     return DisplayDairyDetailsPage(
      //       itinid: widget.itinid,
      //       itinname: widget.itinname,
      //     );
      //   },
      // ));
      print(resBody);
    } else if (res.statusCode == 404) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Error",
            textAlign: TextAlign.center,
          ),
        ),
      );
      print(res.reasonPhrase);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Something Went Wrong',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   List<String> base64Images = selectedImages
  //       .map((image) =>
  //           image != null ? base64.encode(image.readAsBytesSync()) : "")
  //       .toList();
  // }
  bool isButtonTapped = false;
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
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: SvgPicture.asset(
                "assets/log1.svg",
                height: 35.h,
                width: 108.w,
                color: const Color(0xFFF65734),
              ),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCalendar(
                  headerStyle: HeaderStyle(
                    headerPadding: const EdgeInsets.all(8),
                    titleCentered: true,
                    formatButtonVisible: false, // Hide the format button
                    titleTextFormatter: (date, _) =>
                        '${DateFormat.MMMM().format(date)} ${DateFormat.y().format(date)}', // Format the month and year
                    titleTextStyle: const TextStyle(
                      color: Color(0xFF525252),
                      fontSize: 16,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w700,
                    ),
                    leftChevronIcon: const Icon(
                      Icons.chevron_left,
                      color: Color(0xFFF65734),
                    ),
                    rightChevronIcon: const Icon(
                      Icons.chevron_right,
                      color: Color(0xFFF65734),
                    ),
                  ),
                  // daysOfWeekStyle: DaysOfWeekStyle(
                  //     weekdayStyle: TextStyle(
                  //         letterSpacing: 0.4, color: Color(0xFFE0E0E5))),
                  calendarStyle: const CalendarStyle(
                    todayTextStyle: TextStyle(color: Colors.black),
                    selectedDecoration: BoxDecoration(
                        color: Color(0xFFF65734),
                        shape: BoxShape.rectangle // Color of the selected day
                        // borderRadius: BorderRadius.circular(
                        //     10), // Adjust the border radius as needed
                        ),
                    todayDecoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.rectangle // Color of the selected day
// Color of the today day
                        ),
                  ),

                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = selectedDay;
                      _calendarFormat = CalendarFormat.week;

                      // Format the selected date without the time and ".000Z" part
                      formattedDate =
                          DateFormat('yyyy-MM-dd').format(selectedDay);
                      print(formattedDate);
                    });
                  },

                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
              ),
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    maxLines: null,
                    style:
                        const TextStyle(color: Color(0xFF000000), fontSize: 16),
                    cursorColor: const Color(0xFF000000),
                    controller: comments,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          "assets/edit1.svg",
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFF65734)),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      // labelText: 'Email',
                      hintText: "Comments",
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
            const Padding(
              padding: EdgeInsets.only(left: 12, top: 10),
              child: Row(
                children: [
                  Text(
                    'Upload Pictures',
                    style: TextStyle(
                      color: Color(0xFFF65734),
                      fontSize: 16,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            // Row(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Container(
            //         width: 100,
            //         height: 100,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10),
            //           color: Colors.grey[200],
            //         ),
            //         child: Center(
            //           child: imagePathGallery != null
            //               ? Image.memory(
            //                   imagePathGallery!.readAsBytesSync(),
            //                   fit: BoxFit.cover,
            //                   width: double.infinity,
            //                   height: double.infinity,
            //                 )
            //               : Column(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     GestureDetector(
            //                         onTap: () {
            //                           pickImageGallery();
            //                         },
            //                         child: SvgPicture.asset("assets/addP.svg"))
            //                   ],
            //                 ),
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Container(
            //         width: 100,
            //         height: 100,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10),
            //           color: Colors.grey[200],
            //         ),
            //         child: Center(
            //           child: imagePathGallery1 != null
            //               ? Image.memory(
            //                   imagePathGallery1!.readAsBytesSync(),
            //                   fit: BoxFit.cover,
            //                   width: double.infinity,
            //                   height: double.infinity,
            //                 )
            //               : Column(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     GestureDetector(
            //                         onTap: () {
            //                           pickImageGallery1();
            //                         },
            //                         child: SvgPicture.asset("assets/addP.svg"))
            //                   ],
            //                 ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (File? image in selectedImages)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: image != null
                            ? Image.file(
                                image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              )
                            : GestureDetector(
                                onTap: () {
                                  pickImageGallery1();
                                },
                                child: SvgPicture.asset("assets/addP.svg"),
                              ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        pickImageGallery1();
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: const Center(
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: () async {
                if (isLoading) {
                  return; // Prevent multiple taps while loading
                }

                setState(() {
                  isLoading = true;
                });

                if (comments.text.isEmpty || formattedDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Please fill all the fields and select a date',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  try {
                    await dirayDetails();
                  } catch (e) {
                    print('API call error: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'API Call Failed',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } finally {
                    setState(() {
                      isLoading = false;
                    });
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
                    ),
                    isLoading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text(
                            "Save",
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
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) {
                      return DisplayDairyDetailsPage(
                        itinid: widget.itinid,
                        itinname: widget.itinname,
                      );
                    },
                  ));
                },
                child: Container(
                  width: 330,
                  height: 48,
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
                        'Display Travel Diary',
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
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Shared with',
                    style: TextStyle(
                      color: Color(0xFFF65734),
                      fontSize: 16,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/16377866/pexels-photo-16377866/free-photo-of-woman-wearing-dress-on-meadow.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load"),
                              fit: BoxFit.fill,
                            ),
                            shape: OvalBorder(),
                          ),
                        ),
                        const Text(
                          'Eleanor Pena',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/14142370/pexels-photo-14142370.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                              fit: BoxFit.fill,
                            ),
                            shape: OvalBorder(),
                          ),
                        ),
                        const Text(
                          'Bella Adison',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/17309792/pexels-photo-17309792/free-photo-of-woman-with-red-roses-posing-in-nature.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                              fit: BoxFit.fill,
                            ),
                            shape: OvalBorder(),
                          ),
                        ),
                        const Text(
                          'Cameron \nWilliamson',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/17253417/pexels-photo-17253417/free-photo-of-light-fashion-people-woman.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                              fit: BoxFit.fill,
                            ),
                            shape: OvalBorder(),
                          ),
                        ),
                        const Text(
                          'Brooklyn \nSimmons',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/17585373/pexels-photo-17585373.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                              fit: BoxFit.fill,
                            ),
                            shape: OvalBorder(),
                          ),
                        ),
                        const Text(
                          'Ralph \nEdwards',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/6640696/pexels-photo-6640696.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                              fit: BoxFit.fill,
                            ),
                            shape: OvalBorder(),
                          ),
                        ),
                        const Text(
                          'Floyd Miles',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 300,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              padding: const EdgeInsets.all(16),
                              child: const Text(
                                'Share Using',
                                style: TextStyle(
                                  color: Color(0xFFF65734),
                                  fontSize: 24,
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildSocialIcon(iconData: Icons.facebook),
                                  buildSocialIcon(
                                      iconData: Icons.picture_in_picture_sharp),
                                  buildSocialIcon(iconData: Icons.whatshot),
                                  buildSocialIcon(iconData: Icons.link),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: 330,
                  height: 48,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 0.50, color: Color(0xFFFF8D74)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Share Details',
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
          ],
        ),
      ),
    );
  }

  Widget buildImageWidget(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Center(
          child: selectedImages[index] != null
              ? Image.memory(
                  selectedImages[index]!.readAsBytesSync(),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                )
              : GestureDetector(
                  onTap: () {
                    pickImageFromGallery(index);
                  },
                  child: SvgPicture.asset("assets/addP.svg"),
                ),
        ),
      ),
    );
  }

  Widget buildAddImageButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: const Center(
          child: Icon(Icons.add, size: 48), // Adjust the size as needed
        ),
      ),
    );
  }

  Widget buildImageListView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: selectedImages.length + 1,
      itemBuilder: (context, index) {
        if (index == selectedImages.length) {
          return buildAddImageButton();
        }
        return buildImageWidget(index);
      },
    );
  }

  Widget defaultImageWidget() {
    return SvgPicture.asset("assets/addP.svg");
  }

  Widget buildSocialIcon({required IconData iconData}) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.withOpacity(0.2),
      ),
      child: Icon(
        iconData,
        size: 40,
        color: Colors.black,
      ),
    );
  }
}
