import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scanguard/auth/signUpNextPage.dart';
import 'package:scanguard/auth/signUpPage.dart';
import 'package:scanguard/auth/signupDetails.dart';
import 'package:http/http.dart' as http;
import '../Models/selectingProfilePic.dart';

class AddPictureSignup extends StatefulWidget {
  final String? userId;
  final String? email;
  const AddPictureSignup({super.key, this.userId, this.email});

  @override
  State<AddPictureSignup> createState() => _AddPictureSignupState();
}

class _AddPictureSignupState extends State<AddPictureSignup> {
  ProfilePictureModels profilePictureModels = ProfilePictureModels();
  selectedPicture() async {
    String apiUrl = "$baseUrl/user_profile_picture";
    print("api: $apiUrl");

    setState(() {
      isLoading = true;
    });
    String? selectedImage;
    if (base64imgGallery != null) {
      selectedImage = base64imgGallery;
    } else if (cam64Image != null) {
      selectedImage = cam64Image;
    } else {
      selectedImage = base64SvgImage;
    }

    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": widget.userId,
      "profile_picture": selectedImage,
    });

    final responseString = response.body;
    print("responseSelectedPictureApi: $responseString");
    print("status Code SelectedPicture: ${response.statusCode}");
    print("in 200 SelectedPicture");

    if (response.statusCode == 200) {
      print("200 Successful");
      setState(() {
        profilePictureModels = profilePictureModelsFromJson(responseString);
        isLoading = false;
      });
    }
  }

  String? base64SvgImage;
  bool isContainerSelected = false;

  Future<void> convertAssetSvgToBase64() async {
    final svgData = await rootBundle.loadString("assets/dimage.svg");
    base64SvgImage = base64.encode(utf8.encode(svgData));
    print("base64SvgImage: $base64SvgImage");

    setState(() {});
  }

  File? imagePathGallery;
  String? base64imgGallery;
  Future pickImageGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);

      if (xFile == null) {
        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        // const NavBar()), (Route<dynamic> route) => false);
      } else {
        Uint8List imageByte = await xFile.readAsBytes();

        base64imgGallery = base64.encode(imageByte);
        print("base64img $base64imgGallery");

        final imageTemporary = File(xFile.path);

        setState(() {
          imagePathGallery = imageTemporary;
          print("newImage $imagePathGallery");
          print("newImage64 $base64imgGallery");
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => SaveImageScreen(
          //           image: imagePath,

          //           image64: "$base64img",
          //         )));
        });
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: ${e.toString()}');
    }
  }

  File? CamImage;
  String? cam64Image;
  Future<void> takePhotoAndConvertToBase64() async {
    final ImagePicker picker = ImagePicker();
    final XFile? xFile = await picker.pickImage(source: ImageSource.camera);
    if (xFile != null) {
      final imageByte = await xFile.readAsBytes();
      cam64Image = base64.encode(imageByte);
      print("cam64Image: $cam64Image");
      CamImage = File(xFile.path);

      setState(() {
        CamImage = File(xFile.path);
        print("newImage $CamImage");
        print("newImage64 $cam64Image");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: const Text(
          "Add Picture",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: "Satoshi",
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Click on avatar to upload Image",
                  style: TextStyle(
                      fontFamily: "Satoshi",
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xFF222222).withOpacity(0.5)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (isContainerSelected) {
                      // When the user taps on the container again, hide the border and clear the base64SvgImage
                      setState(() {
                        isContainerSelected = false;
                        base64SvgImage = null;
                      });
                    } else {
                      convertAssetSvgToBase64();
                      // When the user taps on the container, set the SVG image to imagePathGallery
                      setState(() {
                        isContainerSelected = true;
                      });
                    }
                  },
                  child: Container(
                    height: 192,
                    width: 169,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFFE0E0E5),
                      border: isContainerSelected
                          ? Border.all(
                              width: 2,
                              color: const Color(0xFFF65734),
                            ) // Show border if selected
                          : null,
                    ),
                    child: base64SvgImage !=
                            null // Show the selected image if available
                        ? SvgPicture.string(
                            utf8.decode(base64.decode(base64SvgImage!)),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Center(
                                child: SvgPicture.asset(
                                  "assets/dimage.svg",
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              const Center(
                  child: Text(
                "Default Image",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Satoshi"),
              )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    pickImageGallery(); // Call function to pick image from gallery
                  },
                  child: Container(
                    height: 169,
                    width: 169,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFFE0E0E5),
                    ),
                    child: imagePathGallery !=
                            null // Show the selected image if available
                        ? Image.file(
                            imagePathGallery!,
                            fit: BoxFit.cover,
                          )
                        : cam64Image != null // Show cam64Image if available
                            ? Image.memory(
                                base64.decode(cam64Image!),
                                fit: BoxFit.cover,
                              )
                            : Center(
                                child: SvgPicture.asset(
                                  "assets/account.svg",
                                ),
                              ),
                  ),
                ),
              ),
              const Center(
                  child: Text(
                "Select Image",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Satoshi"),
              )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/Line.svg",
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "OR",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Satoshi",
                        color: Color(0xFFF65734)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    "assets/Line.svg",
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      takePhotoAndConvertToBase64();
                    },
                    child: SvgPicture.asset(
                      "assets/cam.svg",
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  const Text("Take a Photo"),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (base64SvgImage == null &&
                                base64imgGallery == null &&
                                cam64Image == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Please select an image",
                                    style: TextStyle(
                                      fontFamily: "Satoshi",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (base64SvgImage != null ||
                                base64imgGallery != null ||
                                cam64Image != null) {
                              setState(() {
                                isLoading = true;
                              });
                              await selectedPicture();
                              Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return SignupDetails(
                                    userId: widget.userId,
                                    email: widget.email,
                                  );
                                },
                              ));
                              setState(() {
                                isLoading = false;
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Please select an image",
                                    style: TextStyle(
                                      fontFamily: "Satoshi",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 51,
                            width: MediaQuery.of(context).size.width * 0.92,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFF65734), Color(0xFFFF8D74)],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
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
                    if (isLoading)
                      // Show the circular progress indicator if isLoading is true
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
