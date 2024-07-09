// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:scanguard/Home/Shop/selectPayment.dart';

import '../../Models/getStampShopModels.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../auth/signUpNextPage.dart';
import '../../auth/signUpPage.dart';
import '../../main.dart';

class BuyStamps extends StatefulWidget {
  const BuyStamps({super.key});

  @override
  State<BuyStamps> createState() => _BuyStampsState();
}

class _BuyStampsState extends State<BuyStamps> {
  GetStampShopModels getStampShopModels = GetStampShopModels();
  // create the api function
  getStampShop() async {
    String apiUrl = "$baseUrl/shopItem_stamps";
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
    print("getStampShopModels Response: $responseString");
    print("status Code getStampShopModels: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 getStampShopModels");
      print("SuucessFull");
      getStampShopModels = getStampShopModelsFromJson(responseString);
      if (!mounted) {
        return; // Check once more if the widget is still mounted before updating the state
      }
      setState(() {
        isLoading = false;
      });
      print('getStampShopModels status: ${getStampShopModels.status}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStampShop();
  }

  Future<void> refreshList() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      getStampShop();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFF65634),
        ),
      );
    } else {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            shrinkWrap: true,
            //          physics: NeverScrollableScrollPhysics(),
            itemCount: getStampShopModels.data?.length ?? 0,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              childAspectRatio: 1 / 1.5,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () async {
                  prefs = await SharedPreferences.getInstance();
                  userID = prefs?.getString('userID');
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) {
                      return SelectPaymentMethod(
                          productType: "Stamps".toString(),
                        userId: userID.toString(),
                        productId: getStampShopModels.data![index].stampsPacksId
                            .toString(),
                        productName: getStampShopModels
                            .data![index].stampsPacksName
                            .toString(),
                        productPrice: getStampShopModels
                            .data![index].stampsPacksPrice
                            .toString(),
                        productImage: getStampShopModels
                            .data![index].stampsPacksImage
                            .toString(),
                      );
                    },
                  ));
                },
                child: Container(
                  width: 171,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: Container(
                          width: 171,
                          height: 151,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: getStampShopModels.data != null
                              ? Image.network(
                                  "https://portal.passporttastic.com/public/${getStampShopModels.data?[index].stampsPacksImage}",
                                  fit: BoxFit.fill,
                                )
                              : Image.asset(
                                  "assets/logo.png",
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                      Text(
                        "${getStampShopModels.data?[index].stampsPacksName}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '\$${getStampShopModels.data?[index].stampsPacksPrice}',
                        style: const TextStyle(
                          color: Color(0xFFF65734),
                          fontSize: 20,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Container(
                        width: 104,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment(0.00, -1.00),
                            end: Alignment(0, 1),
                            colors: [Color(0xFFFF8D74), Color(0xFFF65634)],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                prefs = await SharedPreferences.getInstance();
                                userID = prefs?.getString('userID');
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return SelectPaymentMethod(
                                      userId: userID.toString(),
                                      productId: getStampShopModels
                                          .data![index].stampsPacksId
                                          .toString(),
                                      productName: getStampShopModels
                                          .data![index].stampsPacksName
                                          .toString(),
                                      productPrice: getStampShopModels
                                          .data![index].stampsPacksPrice
                                          .toString(),
                                      productImage: getStampShopModels
                                          .data![index].stampsPacksImage
                                          .toString(),
                                      productType: "Stamps".toString(),
                                    );
                                  },
                                ));
                              },
                              child: const Text(
                                'Buy',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
