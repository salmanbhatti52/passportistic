import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scanguard/auth/signUpPage.dart';
import 'package:http/http.dart' as http;
import 'package:scanguard/auth/signupDetails.dart';
import '../Models/coverDesignModels.dart';
import '../Models/selectCoverDesign.dart';

bool isLoading = false;

class SignupNextPage extends StatefulWidget {
  final String? userId;
  final String? email;
  const SignupNextPage({super.key, this.userId, this.email});

  @override
  State<SignupNextPage> createState() => _SignupNextPageState();
}

class _SignupNextPageState extends State<SignupNextPage> {
  CoverDesignDataModel coverDesignDataModel = CoverDesignDataModel();
  SelectedCoverDesign selectedCoverDesign = SelectedCoverDesign();
//  List<Map<String, dynamic>> coverDesignData = [];
  coverDesign() async {
    String apiUrl = "$baseUrl/get_cover_design";
    print("api: $apiUrl");

    setState(() {
      isLoading = true;
    });

    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "users_customers_id": widget.userId,
    });

    final responseString = response.body;
    print("responseCoverDesignApi: $responseString");
    print("status Code CoverDesign: ${response.statusCode}");
    print("in 200 signIn");

    if (response.statusCode == 200) {
      print("Successful");
      print("Cover Design Data: ${responseString}");
      setState(() {
        coverDesignDataModel = coverDesignDataModelFromJson(responseString);
        isLoading = false;
      });
      print("Cover Design Data Length: ${coverDesignDataModel.data?.length}");
    }
  }

  selectedDesign() async {
    String apiUrl = "$baseUrl/customer_design";
    print("api: $apiUrl");

    setState(() {
      isLoading = true;
    });

    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "users_customers_id": widget.userId,
      "cover_images_id": selectedOption,
    });

    final responseString = response.body;
    print("responseSelectedDesignApi: $responseString");
    print("status Code SelectedDesign: ${response.statusCode}");
    print("in 200 signIn");

    if (response.statusCode == 200) {
      print("Successful");
      setState(() {
        selectedCoverDesign = selectedCoverDesignFromJson(responseString);
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    coverDesign();
  }

  String? selectedOption;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          "Cover Design",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: "Satoshi",
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Center(
            child: selectedOption != null
                ? getImageWidget(selectedOption!)
                : SvgPicture.asset(
                    "assets/cover.svg",
                    width: 298,
                  ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              value: selectedOption,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF65734)),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                hintText: "Select Cover Design",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFFF3F3F3),
                  ),
                ),
                hintStyle: TextStyle(
                  color: Color(0xFFA7A9B7),
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  fontFamily: "Satoshi",
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              items: coverDesignDataModel.data
                      ?.map<DropdownMenuItem<String>>((data) {
                    return DropdownMenuItem<String>(
                      child: Text(data.name ?? ''),
                      value: data.coverImagesId ?? '',
                    );
                  }).toList() ??
                  [],
              onChanged: (value) {
                setState(() {
                  selectedOption = value;
                  print("Selected Option: $selectedOption");
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (selectedOption != null) {
                      await selectedDesign();
                      if (selectedCoverDesign.status == "success")
                        Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return SignupDetails(
                              userId: widget.userId,
                              email: widget.email,
                            );
                          },
                        ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please select a cover design"),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width * 0.94,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFF65734), Color(0xFFFF8D74)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Next",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Satoshi",
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to get the image widget based on the selected image ID
  Widget getImageWidget(String selectedOption) {
    Datum? selectedDatum;

    for (var datum in coverDesignDataModel.data!) {
      if (datum.coverImagesId == selectedOption) {
        print(datum.coverImagesId);
        selectedDatum = datum;
        break;
      }
    }

    if (selectedDatum != null) {
      String baseUrl = "https://portal.passporttastic.com/public/";
      String imageUrl =
          baseUrl + (selectedDatum.image ?? ''); // Use 'image' field

      // Print the complete image link before returning the Image widget
      print("Image Link: $imageUrl");

      return Image.network(
        imageUrl,
        width: 298,
        errorBuilder: (context, error, stackTrace) {
          return SvgPicture.asset(
            "assets/cover.svg",
            width: 298,
          );
        },
      );
    } else {
      // Print debug information when selectedOption is not found in the data
      print("Selected image ID not found in the data: $selectedOption");

      // Return a fallback image when selectedOption doesn't match any image IDs
      return SvgPicture.asset(
        "assets/cover.svg",
        width: 298,
      );
    }
  }
}
