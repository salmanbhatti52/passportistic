import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/getProfileModels.dart';
import '../auth/signUpNextPage.dart';
import '../auth/signUpPage.dart';
import '../main.dart';
import 'navbar.dart';

class MainScreen extends StatefulWidget {
  final String? userId;

  const MainScreen({
    super.key,
    this.userId,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GetProfileModels getProfileModels = GetProfileModels();
  getUserProfile() async {
    // try {

    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');

    String apiUrl = "$baseUrl/get_profile";
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
    print("getProfileModels Response: $responseString");
    print("status Code getProfileModels: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 getProfileModels");
      print("SuucessFull");
      getProfileModels = getProfileModelsFromJson(responseString);
      setState(() {
        isLoading = false;
      });
      print('getProfileModels status: ${getProfileModels.status}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      // backgroundColor: Color(0xFF00AEFF),

      bottomNavigationBar: NavBar(
        userId: "${widget.userId}",
      ),
    );
  }
  // selectedTab(index) {
  //   setState(() {
  //     pageindex = index;
  //   });
  // }

  // int pageindex = 0;
  // bool exit = false;
}
