import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Models/getStampImagesOnPassportModels.dart';
import '../../auth/signUpNextPage.dart';
import '../../auth/signUpPage.dart';
import '../../main.dart';

int? currentPageIndex;

class BlankPage extends StatefulWidget {
  final int initialPage;
  final int totalPages;
  const BlankPage({
    Key? key,
    required this.initialPage,
    required this.totalPages,
  }) : super(key: key);

  @override
  _BlankPageState createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  GetStampImagesOnPassportModels getStampImagesOnPassportModels =
      GetStampImagesOnPassportModels();
  // create the api function
  int imagesPerPage = 4;
  getStampImage() async {
    String apiUrl = "$baseUrl/get_travel_details";
    print("api: $apiUrl");
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    if (!mounted) {
      return; // Check if the widget is still mounted
    }
    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": "$userID"
    });
    if (!mounted) {
      return; // Check again if the widget is still mounted after the HTTP request
    }
    final responseString = response.body;
    print("getStampImagesOnPassportModels Response: $responseString");
    print("status Code getStampImagesOnPassportModels: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 getStampImagesOnPassportModels");
      print("SuucessFull");
      getStampImagesOnPassportModels =
          getStampImagesOnPassportModelsFromJson(responseString);
      if (!mounted) {
        return; // Check once more if the widget is still mounted before updating the state
      }
      setState(() {
        isLoading = false;
      });
      print(
          'getStampImagesOnPassportModels status: ${getStampImagesOnPassportModels.status}');
    }
  }

  final PageController _pageController = PageController(initialPage: 0);
  Alignment _getAlignment(int index) {
    if (index == 0) {
      return Alignment.topRight;
    } else if (index == 1) {
      return Alignment.topLeft;
    } else if (index == 2) {
      return Alignment.bottomLeft;
    } else {
      return Alignment.bottomLeft;
    }
  }

  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    getStampImage();
    print("widget.total pages: ${widget.totalPages}");
  }

  @override
  Widget build(BuildContext context) {
    int totalStamps = getStampImagesOnPassportModels.data?.length ?? 0;
    int totalPages = (totalStamps / imagesPerPage).ceil();
    int remainingStamps = totalStamps % imagesPerPage;
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.totalPages + (remainingStamps > 0 ? 1 : 0),
      onPageChanged: (index) {
        setState(() {
          currentPageIndex = index + 1; // Incrementing index by 1
          print("currentPageIndex $currentPageIndex");
        });
      },
      itemBuilder: (context, pageIndex) {
        print("totalStamps $totalStamps");
        print("totalPages $totalPages");
        print("remainingStamps $remainingStamps");
        // print("pageIndex $pageIndex");
        return Container(
          height: 199,
          decoration: const ShapeDecoration(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          child: Column(
            children: [
              Visibility(
                // visible: currentPageIndex == 1,
                child: Center(
                  child: Text(
                    '(${currentPageIndex > widget.totalPages ? widget.totalPages : currentPageIndex}/${widget.totalPages})',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 60, bottom: 60, left: 15, right: 15),
                    child: Stack(
                      children: List.generate(imagesPerPage, (index) {
                        final imageIndex = pageIndex * imagesPerPage + index;
                        if (getStampImagesOnPassportModels.data != null &&
                            imageIndex <
                                getStampImagesOnPassportModels.data!.length) {
                          final stampImage = getStampImagesOnPassportModels
                              .data![imageIndex].stampImage;

                          return Positioned(
                            right: (index == 2 || index == 0) ? 170 : null,
                            left: (index == 3 || index == 1) ? 170 : null,
                            top: (index == 1 || index == 0) ? 0 : null,
                            bottom: (index == 3 || index == 2) ? 0 : null,
                            child: RotatedBox(
                              quarterTurns: 3,
                              child: SizedBox(
                                width: 140,
                                height: 140,
                                child: stampImage != null
                                    ? Image.network(
                                        "https://portal.passporttastic.com/public/$stampImage",
                                        fit: BoxFit.fill,
                                      )
                                    : Image.asset(
                                        "assets/logo.png",
                                        fit: BoxFit.contain,
                                      ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
