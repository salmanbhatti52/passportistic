// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:scanguard/Home/Shop/selectPayment.dart';

import '../../Models/getOtherShopModels.dart';
import '../../auth/signUpPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../auth/signUpNextPage.dart';
import '../../main.dart';

class BuyPassportPages extends StatefulWidget {
  const BuyPassportPages({super.key});

  @override
  State<BuyPassportPages> createState() => _BuyPassportPagesState();
}

class _BuyPassportPagesState extends State<BuyPassportPages> {
  GetOtherShopModels getOtherShopModels = GetOtherShopModels();
  getOtherPackageShop() async {
    String apiUrl = "$baseUrl/shopItem_packages";
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
    print("getOtherShopModels Response: $responseString");
    print("status Code getOtherShopModels: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 getOtherShopModels");
      print("SuucessFull");
      getOtherShopModels = getOtherShopModelsFromJson(responseString);
      if (!mounted) {
        return; // Check once more if the widget is still mounted before updating the state
      }
      setState(() {
        isLoading = false;
      });
      print('getOtherShopModels status: ${getOtherShopModels.status}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOtherPackageShop();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    if (isLoading) {
      return const Center(
          child: CircularProgressIndicator(
        color: Color(0xFFF65634),
      ));
    } else {
      return isMobile
          ? Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  //          physics: NeverScrollableScrollPhysics(),
                  itemCount: getOtherShopModels.data?.length ?? 0,
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
                              userId: userID.toString(),
                              productId: getOtherShopModels
                                  .data![index].managePackagesId
                                  .toString(),
                              productName: getOtherShopModels
                                  .data![index].packageName
                                  .toString(),
                              productPrice: getOtherShopModels
                                  .data![index].packagePrice
                                  .toString(),
                              productImage: getOtherShopModels
                                  .data![index].packageImage
                                  .toString(),
                              productType: "Packages",
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
                              offset: const Offset(
                                  0, 3), // changes position of shadow
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
                                child: getOtherShopModels.data != null
                                    ? Image.network(
                                        "https://portal.passporttastic.com/public/${getOtherShopModels.data?[index].packageImage}",
                                        fit: BoxFit.fill,
                                      )
                                    : Image.asset(
                                        "assets/logo.png",
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                            Text(
                              "${getOtherShopModels.data?[index].packageName}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Satoshi',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            getOtherShopModels.data?[index].packagePrice != null
                                ? Text(
                                    "\$${getOtherShopModels.data?[index].packagePrice}",
                                    style: const TextStyle(
                                      color: Color(0xFFF65734),
                                      fontSize: 20,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  )
                                : const Text(
                                    "Out of Stock",
                                    style: TextStyle(
                                      color: Color(0xFFF65734),
                                      fontSize: 18,
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
                                  colors: [
                                    Color(0xFFFF8D74),
                                    Color(0xFFF65634)
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Buy',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w700,
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
            )
          : Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  //          physics: NeverScrollableScrollPhysics(),
                  itemCount: getOtherShopModels.data?.length ?? 0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        prefs = await SharedPreferences.getInstance();
                        userID = prefs?.getString('userID');
                        Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return SelectPaymentMethod(
                              userId: userID.toString(),
                              productId: getOtherShopModels
                                  .data![index].managePackagesId
                                  .toString(),
                              productName: getOtherShopModels
                                  .data![index].packageName
                                  .toString(),
                              productPrice: getOtherShopModels
                                  .data![index].packagePrice
                                  .toString(),
                              productImage: getOtherShopModels
                                  .data![index].packageImage
                                  .toString(),
                              productType: "Packages",
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
                              offset: const Offset(
                                  0, 3), // changes position of shadow
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
                                child: getOtherShopModels.data != null
                                    ? Image.network(
                                        "https://portal.passporttastic.com/public/${getOtherShopModels.data?[index].packageImage}",
                                        fit: BoxFit.fill,
                                      )
                                    : Image.asset(
                                        "assets/logo.png",
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                            Text(
                              "${getOtherShopModels.data?[index].packageName}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Satoshi',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            getOtherShopModels.data?[index].packagePrice != null
                                ? Text(
                                    "\$${getOtherShopModels.data?[index].packagePrice}",
                                    style: const TextStyle(
                                      color: Color(0xFFF65734),
                                      fontSize: 20,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  )
                                : const Text(
                                    "Out of Stock",
                                    style: TextStyle(
                                      color: Color(0xFFF65734),
                                      fontSize: 18,
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
                                  colors: [
                                    Color(0xFFFF8D74),
                                    Color(0xFFF65634)
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Buy',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w700,
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
