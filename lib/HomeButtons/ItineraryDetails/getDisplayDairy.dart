import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Models/getAccomodationDetailsModels.dart';
import '../../Models/getDisplayDairyModels.dart';
import '../../auth/signUpNextPage.dart';
import '../../auth/signUpPage.dart';
import '../../main.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class DisplayDairyDetailsPage extends StatefulWidget {
  final String? itinid;
  final String? itinname;
  const DisplayDairyDetailsPage({Key, key, this.itinid, this.itinname})
      : super(key: key);

  @override
  State<DisplayDairyDetailsPage> createState() =>
      _DisplayDairyDetailsPageState();
}

class _DisplayDairyDetailsPageState extends State<DisplayDairyDetailsPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  int accommodationsPerPage = 1;
  GetAccomodationsDetailsModels getAccomodationsDetailsModels =
      GetAccomodationsDetailsModels();
  GetDisplayDairyModels getDisplayDairyModels = GetDisplayDairyModels();
  displayDairyDetails() async {
    // try {

    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');

    String apiUrl = "$baseUrl/get_travel_diary";
    print("api: $apiUrl");

    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "travel_ltinerary_id": "${widget.itinid}",
      // "passport_holder_id": "$userID",
    });
    final responseString = response.body;
    print("responseModels: $responseString");
    print("status Code  getDisplayDairyModels: ${response.statusCode}");
    if (response.statusCode == 200) {
      print("in 200 getDisplayDairyModels");
      print("SuucessFull");
      getDisplayDairyModels = getDisplayDairyModelsFromJson(responseString);
      setState(() {
        isLoading = false;
      });
      print('getDisplayDairyModels status: ${getDisplayDairyModels.status}');
    } else {
      // Show a dialog box if data is not available
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: const Text("Data is not available."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Close the page
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
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
    displayDairyDetails();
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
              onTap: () async {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                "assets/arrowBack1.svg",
              ),
            ),
          ),
          title: Text(
            "${widget.itinname}",
            style: const TextStyle(
              color: Color(0xFF525252),
              fontSize: 24,
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
                height: 35.h,
                width: 108.w,
                color: const Color(0xFFF65734),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Travel Dairy",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFF65734),
                fontSize: 24,
                fontFamily: 'Satoshi',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                    _currentPage >= 0 &&
                            _currentPage <
                                (getDisplayDairyModels.data?.length ?? 0)
                        ? DateFormat('MMMM yyyy').format(
                            getDisplayDairyModels
                                    .data![_currentPage].travelDiaryDate ??
                                DateTime.now(),
                          )
                        : "",
                    style: const TextStyle(
                      color: Color(0xFFF65734),
                      fontSize: 16,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    icon: SvgPicture.asset("assets/arrow.svg"),
                    onPressed: () {
                      final dataLength =
                          getDisplayDairyModels.data?.length ?? 0;
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
                itemCount: getDisplayDairyModels.data?.length ?? 0,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  if (index < 0 ||
                      index >= (getDisplayDairyModels.data?.length ?? 0)) {
                    return const SizedBox(); // Return an empty container if index is out of range
                  }
                  final data = getDisplayDairyModels.data;

                  final travelDiary = getDisplayDairyModels.data![index];
                  final travelDiaryPictures = travelDiary.travelDiaryPicture;

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 250,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Text(
                                DateFormat('EEEE dd')
                                    .format(data![index].travelDiaryDate!),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Text(
                                travelDiary.travelDiaryEntry ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          if (travelDiaryPictures?.isNotEmpty ?? false)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: travelDiaryPictures!.map((picture) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FullScreenImageGallery(
                                          images: [
                                            "https://portal.passporttastic.com/public/${picture.tavelDiaryPictureImage!}"
                                            // Add more image URLs if needed
                                          ],
                                          initialIndex:
                                              0, // Index of the initially displayed image
                                        ),
                                      ),
                                    );
                                  },
                                  child: Image.network(
                                    "https://portal.passporttastic.com/public/${picture.tavelDiaryPictureImage!}",
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildIndicators(),
              ),
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
    final dataLength = getDisplayDairyModels.data?.length ?? 0;

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

class FullScreenImageGallery extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  const FullScreenImageGallery(
      {super.key, required this.images, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Travel Photos",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'Satoshi',
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF65734),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black, // Background color
      body: PhotoViewGallery.builder(
        itemCount: images.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(images[index]),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        pageController: PageController(initialPage: initialIndex),
      ),
    );
  }
}
