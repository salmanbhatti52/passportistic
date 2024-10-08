import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
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
    debugPrint("api: $apiUrl");
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
    debugPrint("getStampImagesOnPassportModels Response: $responseString");
    debugPrint(
        "status Code getStampImagesOnPassportModels: ${response.statusCode}");

    if (response.statusCode == 200) {
      debugPrint("in 200 getStampImagesOnPassportModels");
      debugPrint("SuucessFull");
      getStampImagesOnPassportModels =
          getStampImagesOnPassportModelsFromJson(responseString);
      if (!mounted) {
        return; // Check once more if the widget is still mounted before updating the state
      }
      setState(() {
        isLoading = false;
      });
      debugPrint(
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
    debugPrint("widget.total pages: ${widget.totalPages}");
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    int totalStamps = getStampImagesOnPassportModels.data?.length ?? 0;
    int totalPages = (totalStamps / imagesPerPage).ceil();
    int remainingStamps = totalStamps % imagesPerPage;
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.totalPages + (remainingStamps > 0 ? 1 : 0),
      onPageChanged: (index) {
        setState(() {
          currentPageIndex = index + 1; // Incrementing index by 1
          debugPrint("currentPageIndex $currentPageIndex");
        });
      },
      itemBuilder: (context, pageIndex) {
        debugPrint("totalStamps $totalStamps");
        debugPrint("totalPages $totalPages");
        debugPrint("remainingStamps $remainingStamps");
        // debugPrint("pageIndex $pageIndex");
        return isMobile
            ? Container(
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
                              final imageIndex =
                                  pageIndex * imagesPerPage + index;
                              if (getStampImagesOnPassportModels.data != null &&
                                  imageIndex <
                                      getStampImagesOnPassportModels
                                          .data!.length) {
                                final stampImage =
                                    getStampImagesOnPassportModels
                                        .data![imageIndex].stampImage;

                                return Positioned(
                                  right: (index == 2 || index == 0)
                                      ? MediaQuery.of(context).size.width * 0.48
                                      : null,
                                  left: (index == 3 || index == 1)
                                      ? MediaQuery.of(context).size.width * 0.48
                                      : null,
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
              )
            : Padding(
                padding: const EdgeInsets.all(68.0),
                child: Container(
                  decoration: const ShapeDecoration(
                    color: Color(0xFFFFFCF4),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        // visible: currentPageIndex == 1,
                        child: Center(
                          child: Text(
                            '(${currentPageIndex > widget.totalPages ? widget.totalPages : currentPageIndex}/${widget.totalPages})',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.67,
                          height: MediaQuery.of(context).size.height * 0.57,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 60, bottom: 60, left: 15, right: 15),
                            child: Stack(
                              children: List.generate(imagesPerPage, (index) {
                                final imageIndex =
                                    pageIndex * imagesPerPage + index;
                                if (getStampImagesOnPassportModels.data !=
                                        null &&
                                    imageIndex <
                                        getStampImagesOnPassportModels
                                            .data!.length) {
                                  final stampImage =
                                      getStampImagesOnPassportModels
                                          .data![imageIndex].stampImage;

                                  return Positioned(
                                    right: (index == 2 || index == 0)
                                        ? MediaQuery.of(context).size.width *
                                            0.38
                                        : null,
                                    left: (index == 3 || index == 1)
                                        ? MediaQuery.of(context).size.width *
                                            0.38
                                        : null,
                                    top: (index == 1 || index == 0) ? 0 : null,
                                    bottom:
                                        (index == 3 || index == 2) ? 0 : null,
                                    child: RotatedBox(
                                      quarterTurns: 3,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.225,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.159,
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
                ),
              );
      },
    );
  }
}
