import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Models/getStampImagesOnPassportModels.dart';
import '../../auth/signUpNextPage.dart';
import '../../auth/signUpPage.dart';
import '../../main.dart';

class BlankPage extends StatefulWidget {
  final List<String> stampImages;
  final int initialPage;

  const BlankPage({
    Key? key,
    required this.stampImages,
    required this.initialPage,
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

  final PageController _pageController = PageController(initialPage: 3);
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

  @override
  void initState() {
    super.initState();
    getStampImage();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: getStampImagesOnPassportModels.data?.isNotEmpty == true
          ? (getStampImagesOnPassportModels.data!.length / imagesPerPage).ceil()
          : 0,
      itemBuilder: (context, pageIndex) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 188,
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
                      right: (index == 0 || index == 2) ? 0 : null,
                      left: (index == 1 || index == 3) ? 0 : null,
                      top: (index == 0 || index == 1) ? 0 : null,
                      bottom: (index == 2 || index == 3) ? 0 : null,
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: SizedBox(
                          width: 150,
                          height: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: stampImage != null
                                ? Image.network(
                                    "https://portal.passporttastic.com/public/$stampImage",
                                    width: 150,
                                    height: 150,
                                  )
                                : Image.asset(
                                    "assets/logo.png",
                                    fit: BoxFit.contain,
                                  ),
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
        );
      },
    );
  }
}
