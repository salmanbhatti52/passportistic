// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:scanguard/HomeButtons/PassportSection/bloc/frontCoverBloc.dart';
import 'package:scanguard/HomeButtons/PassportSection/bloc/leagalnoticsBloc.dart';
import 'package:scanguard/HomeButtons/PassportSection/passportFrontCover.dart';
import 'package:scanguard/HomeButtons/PassportSection/passportLegalNoticePage.dart';
import 'package:scanguard/HomeButtons/PassportSection/passportMainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/getProfileModels.dart';
import '../../auth/signUpNextPage.dart';
import '../../auth/signUpPage.dart';
import '../../main.dart';
import 'blankPages.dart';

class ViewPassport extends StatefulWidget {
  const ViewPassport({
    super.key,
  });

  @override
  State<ViewPassport> createState() => _ViewPassportState();
}

class _ViewPassportState extends State<ViewPassport> {
  int totalPages = 0; // Total number of passport pages
  int currentPage = 0;
  // Create a PageController
  final PageController _pageController = PageController();
  GetProfileModels getProfileModels = GetProfileModels();
  getUserProfile() async {
    String apiUrl = "$baseUrl/get_profile";
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
    print("getProfileModels Response: $responseString");
    print("status Code getProfileModels: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 getProfileModels");
      print("SuucessFull");
      getProfileModels = getProfileModelsFromJson(responseString);
      if (!mounted) {
        return; // Check once more if the widget is still mounted before updating the state
      }
      setState(() {
        isLoading = false;
      });
      print('getProfileModels status: ${getProfileModels.status}');
    }
    setState(() {
      totalPages =
          int.tryParse(getProfileModels.data!.numberOfPages ?? "0") ?? 0;

      print("totalPages $totalPages");
      // If the parsing fails or the value is null, set totalPages to 0 as a default.
    });
  }

  List<passportPage> passportPages = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfile();
    print("currentPageIndex $currentPageIndex");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00AEFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00AEFF),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              "assets/arrowLeft.svg",
              width: 20,
              height: 20,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              "assets/notification.svg",
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController, // Assign the PageController
              itemCount: 4,
              itemBuilder: (context, index) {
                // Conditionally render front cover, passport page, or blank page
                if (index == 0) {
                  // Display the front cover on the first page
                  return BlocProvider(
                    create: (context) => PassportFrontCoverCubit(),
                    child: const FrontCover(),
                  );
                } else if (index == 1) {
                  // Display the passport page on the second page
                  return const passportPage();
                } else if (index == 2) {
                  // Display blank pages for the remaining pages
                  return BlocProvider(
                    create: (context) => PassportLegalNoticePageCubit(),
                    child: const PassportLegalNoticePage(),
                  );
                } else {
                  return BlankPage(
                    initialPage: 3,
                    totalPages:
                        totalPages, // Set the initial page index as needed
                  );
                }
              },
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                  print("index $index");
                });
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 188,
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
            child: Column(children: [
              const SizedBox(
                height: 2,
              ),
              const Text(
                'View Pages',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFF65734),
                  fontSize: 24,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: SvgPicture.asset("assets/arrowRoundLeft.svg",
                        color: currentPage > 0
                            ? const Color(0xFFF65734)
                            : Colors.grey),
                    onPressed: () {
                      if (currentPage > 0) {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: SvgPicture.asset(
                      "assets/arrowRight.svg",
                      // color: currentPage < totalPages - 1
                      //     ? Colors.blue
                      //     : Colors.grey,
                    ),
                    onPressed: () {
                      if (currentPage < totalPages - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                ],
              ),
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
                    width: 40,
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
            ]),
          )
        ],
      ),
    );
  }
}
