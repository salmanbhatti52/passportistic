import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import '../Models/getFAQModels.dart';
import '../auth/signUpNextPage.dart';
import '../auth/signUpPage.dart';
import '../main.dart';

class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  FaqModels faqModels = FaqModels();
  getFAQ() async {
    String apiUrl = "$baseUrl/get_faqs";
    print("api: $apiUrl");

    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": " $userID"
    });
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
      faqModels = faqModelsFromJson(responseString);
      if (faqModels.data != null) {
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
    getFAQ();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
            child: CircularProgressIndicator(
          color: Color(0xFFF65734),
        )),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          centerTitle: true,
          title: const Text(
            "FAQ's",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF141010),
              fontSize: 20,
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(14.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset("assets/menub.svg")),
          ),
        ),
        body: Column(
          children: [
            Center(
              child: SvgPicture.asset(
                "assets/faq.svg",
                // color: const Color(0xFFF65734),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: faqModels.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final faqItem = faqModels.data?[index];
                  return ExpansionTile(
                    title: Text(faqItem?.faqQuestion ?? ''),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(faqItem?.faqAnswer ?? ''),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      );
    }
  }
}
