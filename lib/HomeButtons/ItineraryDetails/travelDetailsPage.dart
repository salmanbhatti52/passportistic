import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/getTravelDetailsModels.dart';
import '../../Models/transportModeNamesModels.dart';
import '../../auth/signUpNextPage.dart';
import '../../auth/signUpPage.dart';
import '../../main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TravelDetailsPage extends StatefulWidget {
  final String? itinid;
  final String? itinname;
  const TravelDetailsPage({Key, key, this.itinid, this.itinname})
      : super(key: key);

  @override
  State<TravelDetailsPage> createState() => _TravelDetailsPageState();
}

class _TravelDetailsPageState extends State<TravelDetailsPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  GetTravelDetailsModels getTravelDetailsModels = GetTravelDetailsModels();
  List<Datum>? travelDetailsData = [];
  int travelDetailsPerPage = 1;
  travelDetails() async {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/get_itinerary_details";
    print("api: $apiUrl");
    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "travel_ltinerary_id": "${widget.itinid}",
      "passport_holder_id": "$userID"
    });
    final responseString = response.body;
    print("responseModels: $responseString");
    print("status Code Accomodation DetailsModels: ${response.statusCode}");
    if (response.statusCode == 200) {
      print("in 200 itineraryAddModels");
      print("SuucessFull");
      getTravelDetailsModels = getTravelDetailsModelsFromJson(responseString);
      travelDetailsData = getTravelDetailsModels.data;

      if (travelDetailsData != null) {
        // Loop through the travel details data and call transportModeNames for each item
        for (var travelDetail in travelDetailsData!) {
          transportModeId =
              getTravelDetailsModels.data![0].transportModeId ?? '';
          await transportModeNames(transportModeId.toString());
          print("transportModeId $transportModeId");
        }
      }
      //  transportModeNames(getTravelDetailsModels.data?.length ?? '');
      setState(() {
        isLoading = false;
      });
      print(
          'AaccommodationModelsDetailsModels status: ${getTravelDetailsModels.status}');
    }
  }

  String? transportModeId;

  TransportModeNamesModels transportModeNamesModels =
      TransportModeNamesModels();

  transportModeNames(String transportModeId) async {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/get_transport_mode_itinerary";
    print("api: $apiUrl");
    setState(() {
      isLoading = true;
    });
    // String transportModeId =
    //     travelForPage[index % itemsPerPage].transportModeId ?? '';

    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "transport_mode_id": transportModeId
    });
    final responseString = response.body;
    print("responseModels: $responseString");
    print(
        "status Code transportModeNamesModels DetailsModels: ${response.statusCode}");
    if (response.statusCode == 200) {
      print("in 200 itineraryAddModels");
      print("SuucessFull");
      transportModeNamesModels =
          transportModeNamesModelsFromJson(responseString);
      print('Mode name: ${transportModeNamesModels.data?.modeName}');
      setState(() {
        isLoading = false;
      });
      print(
          'transportModeNamesModels status: ${transportModeNamesModels.status}');
    }
  }

  int itemsPerPage = 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    userID = prefs?.getString('userID');
    print("${widget.itinid}");
    travelDetails();
    print("$userID");
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFFF65734),
          ), // Show loading indicator
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
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
          title: Text(
            "${widget.itinname}",
            style: TextStyle(
              color: const Color(0xFF525252),
              fontSize: 24.sp,
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.w900,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset("assets/notification.svg"),
            )
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: SvgPicture.asset(
                "assets/log1.svg",
                height: 70.h,
                width: 219.w,
                color: const Color(0xFFF65734),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Travel Details',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFFF65734),
                fontSize: 24.sp,
                fontFamily: 'Satoshi',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02.h),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: SvgPicture.asset("assets/arrow1.svg"),
                    onPressed: () {
                      if (_currentPage > 0) {
                        _goToPage(_currentPage - 1);
                      }
                    },
                  ),
                  Text(
                    "Day ${getTravelDetailsModels.data?[_currentPage].travelDayNumber ?? ""}",
                    style: const TextStyle(
                      color: Color(0xFF525252),
                      fontSize: 16,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    icon: SvgPicture.asset("assets/arrow.svg"),
                    onPressed: () {
                      final dataLength =
                          getTravelDetailsModels.data?.length ?? 0;
                      if (_currentPage < dataLength - 1) {
                        _goToPage(_currentPage + 1);
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: (getTravelDetailsModels.data?.length ??
                        0 / travelDetailsPerPage)
                    .ceil(),
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  final startIndex = index * travelDetailsPerPage;
                  final endIndex = (startIndex + travelDetailsPerPage) <=
                          (getTravelDetailsModels.data?.length ?? 0)
                      ? (startIndex + travelDetailsPerPage)
                      : (getTravelDetailsModels.data?.length ?? 0);

                  final travelForPage = getTravelDetailsModels.data
                          ?.sublist(startIndex, endIndex) ??
                      [];

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 150,
                      height: 400.h,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            color: Color(0xFFF65634), // Border color
                            width: 2, // Border width
                          ),
                        ),
                        // shadows: const [
                        //   BoxShadow(
                        //     color: Color(0x0F312E23),
                        //     blurRadius: 16,
                        //     offset: Offset(0, 8),
                        //     spreadRadius: 0,
                        //   )
                        // ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Day No',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        travelForPage[index % itemsPerPage]
                                                .travelDayNumber ??
                                            '',
                                        style: const TextStyle(
                                          color: Color(0xFFF65734),
                                          fontSize: 18,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      // ---
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                      const Text(
                                        'Travel Mode',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      // ---
                                      Text(
                                        transportModeNamesModels
                                                .data?.modeName ??
                                            '',
                                        style: const TextStyle(
                                          color: Color(0xFFF65734),
                                          fontSize: 18,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      // ---
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                      const Text(
                                        'Trip Details',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      // ---
                                      Text(
                                        travelForPage[index % itemsPerPage]
                                                .travelDepartTripDetails ??
                                            '',
                                        style: const TextStyle(
                                          color: Color(0xFFF65734),
                                          fontSize: 18,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      // ---
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                      const Text(
                                        'Travel Time',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      // ---
                                      Text(
                                        travelForPage[index % itemsPerPage]
                                                .tripTravelTime ??
                                            '',
                                        style: const TextStyle(
                                          color: Color(0xFFF65734),
                                          fontSize: 18,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      // ---
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                      const Text(
                                        'Local Time',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      // ---
                                      Text(
                                        travelForPage[index % itemsPerPage]
                                                .departureTime ??
                                            '',
                                        style: const TextStyle(
                                          color: Color(0xFFF65734),
                                          fontSize: 18,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Local Date',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      // ---
                                      Text(
                                        DateFormat('dd MMM yyyy').format(
                                          travelForPage[index % itemsPerPage]
                                                  .departureDate ??
                                              DateTime.now(),
                                        ),
                                        style: const TextStyle(
                                          color: Color(0xFFF65734),
                                          fontSize: 18,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      // ---
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                      const Text(
                                        'From',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      // ---
                                      Text(
                                        travelForPage[index % itemsPerPage]
                                                .travelDepartCity ??
                                            '',
                                        style: const TextStyle(
                                          color: Color(0xFFF65734),
                                          fontSize: 18,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      // ---
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                      const Text(
                                        'Local Time',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      // ---
                                      Text(
                                        travelForPage[index % itemsPerPage]
                                                .arrivalTime ??
                                            '',
                                        style: const TextStyle(
                                          color: Color(0xFFF65734),
                                          fontSize: 18,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      // ---
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                      const Text(
                                        'To',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      // ---
                                      Text(
                                        travelForPage[index % itemsPerPage]
                                                .travelArriveCity ??
                                            '',
                                        style: const TextStyle(
                                          color: Color(0xFFF65734),
                                          fontSize: 18,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      // ---
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                      const Text(
                                        'Layover',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        travelForPage[index % itemsPerPage]
                                                .layoverTime ??
                                            '',
                                        style: const TextStyle(
                                          color: Color(0xFFF65734),
                                          fontSize: 18,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                // ---
                              ]),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicators(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: const ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [Color(0xFFFF8D74), Color(0xFFF65634)],
                    ),
                    shape: OvalBorder(),
                  ),
                  child: Center(child: SvgPicture.asset("assets/share1.svg")),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 72,
                  height: 72,
                  decoration: const ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [Color(0xFFFF8D74), Color(0xFFF65634)],
                    ),
                    shape: OvalBorder(),
                  ),
                  child: Center(child: SvgPicture.asset("assets/print1.svg")),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    }
  }

//   Future<List<int>> _generatePdf(BuildContext context) async {
//   final pdf = Document();

//   // Add the container content to the PDF
//   pdf.addPage(
//     MultiPage(
//       build: (context) => [
//         Container(
//           width: 284,
//           decoration: ShapeDecoration(
//             color: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             shadows: [
//               BoxShadow(
//                 color: Color(0x0F312E23),
//                 blurRadius: 16,
//                 offset: Offset(0, 8),
//                 spreadRadius: 0,
//               )
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 // Add your container content here
//               ],
//            ) ),)
//       ],
//     ),
//   );

//   // Save the PDF document as a list of bytes
//   final pdfBytes = await pdf.save();

//   return pdfBytes;
// }

  List<Widget> _buildIndicators() {
    final dataLength = getTravelDetailsModels.data?.length ?? 0;

    return List.generate(
      dataLength,
      (index) => Container(
        width: 10,
        height: 6,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: _currentPage == index
              ? const Color(0xFFF65734)
              : const Color(0xFF9C9999),
        ),
      ),
    );
  }
}

class ContainerData {
  final String title;

  ContainerData({required this.title});
}
