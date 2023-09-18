import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import '../Models/systemSettingModels.dart';
import '../auth/signUpNextPage.dart';
import '../auth/signUpPage.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  SystemSettingsModels systemSettingsModels = SystemSettingsModels();
  getSettingData() async {
    String apiUrl = "$baseUrl/system_settings";
    print("api: $apiUrl");

    setState(() {
      isLoading = true;
    });
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
      },
    );
    if (!mounted) {
      return; // Check again if the widget is still mounted after the HTTP request
    }
    final responseString = response.body;
    print("faqModels Response: $responseString");
    print("status Code faqModels: ${response.statusCode}");

    if (response.statusCode == 200) {
      // After getting the user's profile data
      print("in 200 faqModels");
      print("SuucessFull");
      systemSettingsModels = systemSettingsModelsFromJson(responseString);
      if (systemSettingsModels.data != null) {
        if (!mounted) {
          setState(() {});
        }
      } else {
        // Handle the case when user profile data is null
        print("User profile data is null");
      }
      if (!mounted) {
        return; // Check once more if the widget is still mounted before updating the state
      }
      setState(() {
        isLoading = false;
      });
    } else {
      print("in else faqModels");
      print("faqs status False");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSettingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Privacy Policy',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF141010),
            fontSize: 20,
            fontFamily: 'Satoshi',
            fontWeight: FontWeight.w700,
          ),
        ),
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.all(14.0),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset("assets/menub.svg")),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFF65734),
              
              ),
            )
          : systemSettingsModels.data != null &&
                  systemSettingsModels.data!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildPolicyText(systemSettingsModels.data!),
                )
              : const Center(
                  child: Text("No data available."),
                ),
    );
  }

  Widget _buildPolicyText(List<Datum> data) {
    // Find the item with "type" equal to "about_us"
    final aboutUsItem = data.firstWhere(
      (item) => item.type == "privacy_policy",
      orElse: () => Datum(
          description:
              "About us data not found."), // Default value if not found
    );

    return Container(
      padding: const EdgeInsets.all(1.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: SvgPicture.asset(
                "assets/log1.svg",
                height: 35.h,
                width: 108.w,
                color: const Color(0xFFF65734),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              aboutUsItem.description ??
                  "No Data found.", // Display the description
              style: const TextStyle(
                fontSize: 16.0,
              ),
              textAlign: TextAlign.justify, // Justify the text
            ),
          ],
        ),
      ),
    );
  }
}
