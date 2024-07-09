// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../Models/buyProductsModel.dart';
import '../../Models/getPaymentModel.dart';
import '../../Utils/colors.dart';
import '../../main.dart';
import '../../widgets/MyButton.dart';
import '../../widgets/ToastMessage.dart';
import '../navbar.dart';

class SelectPaymentMethod extends StatefulWidget {
  final String? userId;
  final String? productId;
  final String? productName;
  final String? productPrice;
  final String? productImage;
  final String productType;

  const SelectPaymentMethod({
    super.key,
    this.userId,
    this.productId,
    this.productName,
    this.productPrice,
    this.productImage,
    required this.productType,
  });
  @override
  State<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
  bool isLoading = false;

  GetPaymentModels getPaymentModels = GetPaymentModels();
  getpaymentlist() async {
    // try {

    String apiUrl = "https://portal.passporttastic.com/api/get_payment_method";
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
    final responseString = response.body;
    print("response getProfileModels: $responseString");
    print("status Code getProfileModels: ${response.statusCode}");
    print("in 200 getProfileModels");
    if (response.statusCode == 200) {
      print("SuccessFull");
      getPaymentModels = getPaymentModelsFromJson(responseString);
      generateFiveDigitCode();
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      print('getProfileModels status: ${getPaymentModels.status}');
    }
  }

  var code = '';
  String generateFiveDigitCode() {
    var rng = Random();

    for (var i = 0; i < 5; i++) {
      code += rng.nextInt(10).toString();
    }
    return code;
  }

  bool progress = false;
  bool isInAsyncCall = false;
  int buttonPressCount = 0;
  BuyProductsModel buyProductsModel = BuyProductsModel();
  Future<void> buyStamps() async {
    String apiUrl = "https://portal.passporttastic.com/api/purchase_details";
    print("working");

    // Check for null values and log them
    Map<String, String?> fields = {
      "passport_holder_id": "${widget.userId}",
      "transiction_id": code.toString(),
      "product_id": "${widget.productId}",
      "product_type": widget.productType,
      "amount": "${widget.productPrice}"
    };

    List<String> nullFields = [];
    fields.forEach((key, value) {
      if (value == null || value.isEmpty) {
        nullFields.add(key);
      }
    });

    if (nullFields.isNotEmpty) {
      print("The following fields are null or empty: $nullFields");

      return; // Stop execution if any required field is null or empty
    }

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: fields.map((key, value) =>
          MapEntry(key, value ?? "")), // Convert null values to empty strings
    );

    final responseString = response.body;
    print("buyStamps: $responseString");
    print("status Code buyStamps: ${response.statusCode}");
    if (response.statusCode == 200) {
      buyProductsModel = buyProductsModelFromJson(responseString);
      setState(() {
        progress = false;
      });
      print('buyProductsModel status: ${buyProductsModel.status}');
      print('buyProductsModel data: ${buyProductsModel.data}');
    } else {
      // Handle non-200 responses
      setState(() {
        progress = false;
      });
    }
  }

  Map<String, dynamic>? paymentIntent;

  // calculateAmount(String amount) {
  //   amount = "${jobsCreateModel.data?.totalPrice}";
  //   final a = (int.parse(amount)) * 100;
  //   print("amount ${a}");
  //   final calculatedAmout = a;
  //   print("calculatedAmout ${calculatedAmout}");
  //   return calculatedAmout.toString();
  // }
  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  String calculateAmount(String amount) {
    try {
      double numericAmount = double.parse(widget.productPrice!);
      print('Numeric amount after addition: $numericAmount');
      print("numericAmount $numericAmount");
      int amountInCents = (numericAmount * 100).toInt();
      print("Amount in cents: $amountInCents");
      return amountInCents.toString();
    } catch (e) {
      // Handle the case where parsing the numeric amount fails
      print('Error parsing the numeric amount: $e');
    }
    // Handle cases where the amount is null or not a valid numeric string
    return "0"; // Return a default value or handle it based on your application's logic.
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      print("hello");
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51OEcOiC2zni1dAD5stQ8OroUN92VtjegmFLQqlf5i50Mb6ClxUD7BbyRByB56xmjShDeG2LlZBS5CKwjwi9TZA2h00dguAb7JF',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  final DraggableScrollableController scrollController =
      DraggableScrollableController();

  Future<void> makePayment() async {
    try {
      paymentIntent =
          await createPaymentIntent('${widget.productPrice}', 'USD');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent?['client_secret'],
                  // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
                  // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
                  style: ThemeMode.dark,
                  merchantDisplayName: 'StandMan'))
          .then((value) {});

      ///now finally display payment sheeet
      await displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        await buyStamps();
        if (buyProductsModel.status == "success") {
          showDialog(
              barrierDismissible: false,
              builder: (BuildContext context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width:
                              MediaQuery.of(context).size.height * 0.9, //350,
                          height:
                              MediaQuery.of(context).size.height * 0.3, // 321,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              const Text(
                                "Stamp Purchased\nSuccessfully!",
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: "Outfit",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  // letterSpacing: -0.3,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    // prefs =
                                    //     await SharedPreferences.getInstance();
                                    // userID = prefs?.getString('userID');
                                    // Navigator.pushReplacement(context,
                                    //     MaterialPageRoute(
                                    //   builder: (BuildContext context) {
                                    //     return NavBar(
                                    //       userId: "$userID",
                                    //     );
                                    //   },
                                    // ));
                                  },
                                  child: mainButton(
                                      "Go Back", appThemeColor, context)),
                            ],
                          ),
                        ),
                        Positioned(
                            top: -48,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              //106,
                              height: MediaQuery.of(context).size.height * 0.13,
                              //106,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffFF9900),
                              ),
                              child: const Icon(
                                Icons.check,
                                size: 40,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ),
              context: context);
        } else {
          toastFailedMessage("Purchasing Failed", Colors.red);
        }
        paymentIntent = null;
      }).onError((error, stackTrace) {
        if (error != null) {
          throw Exception(error.toString());
        } else {
          throw Exception('An unknown error occurred');
        }
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ),
          context: context);
    } catch (e) {
      print('$e');
    }
  }

  String? selectedPayment;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getpaymentlist();
    print("Product ID: ${widget.productType}");
    // print("Total Price: ${widget.totalPrice}");
    // print("discountedprice  init:  ${widget.discountedPrice}");
    // print("price in inti ${widget.price}");
    // print("Final Price in inti ${widget.finalPrice}");
  }

  void showGoBackDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Please go back'),
          content: const Text('Please go back and create the job again.'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () async {
                prefs = await SharedPreferences.getInstance();
                userID = prefs?.getString('userID');
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return NavBar(
                      userId: "$userID",
                    );
                  },
                ));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    buttonPressCount = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Select Payment Mothods",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.3,
            ),
          ),
          backgroundColor: const Color(0xFFF65734).withOpacity(0.90),
          iconTheme: const IconThemeData(color: Colors.white),
          automaticallyImplyLeading: true,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                    // changes position of shadow
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
                      child: widget.productImage != null
                          ? Image.network(
                              "https://portal.passporttastic.com/public/${widget.productImage}",
                              fit: BoxFit.fill,
                            )
                          : Image.asset(
                              "assets/logo.png",
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  Text(
                    "${widget.productName}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '\$${widget.productPrice}',
                    style: const TextStyle(
                      color: Color(0xFFF65734),
                      fontSize: 20,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: DropdownButtonFormField<String>(
                iconDisabledColor: Colors.transparent,
                iconEnabledColor: Colors.transparent,
                value: selectedPayment,
                onChanged: (newValue) {
                  setState(() {
                    selectedPayment = newValue;
                    print(selectedPayment);
                  });
                },
                items: getPaymentModels.data?.map((payment) {
                      return DropdownMenuItem<String>(
                        value: payment.paymentGatewayId.toString(),
                        child: Text(payment.name ?? ''),
                      );
                    }).toList() ??
                    [],
                decoration: InputDecoration(
                  suffixIcon: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.arrow_drop_down_sharp)],
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xff2B65EC)),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  hintText: "Select Payment Method",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Color(0xFFF3F3F3),
                    ),
                  ),
                  hintStyle: const TextStyle(
                    color: Color(0xFFA7A9B7),
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    fontFamily: "Satoshi",
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: GestureDetector(
                  onTap: () async {
                    print("buttonPressCount main $buttonPressCount");

                    if (buttonPressCount >= 1) {
                      print("buttonPressCount if $buttonPressCount");
                      showGoBackDialog(context);
                    } else {
                      print("buttonPressCount else if $buttonPressCount");

                      if (selectedPayment == null) {
                        toastMessage(
                            "Please Select Payment Method", Colors.red);
                      } else {
                        setState(() {
                          isInAsyncCall = true;
                        });
                        prefs = await SharedPreferences.getInstance();
                        userID = prefs?.getString('userID');
                        print("userID: $userID");

                        print("selectedPayment: $selectedPayment");

                        await makePayment();

                        setState(() {
                          buttonPressCount++;
                        });
                        print("buttonPressCount in success $buttonPressCount");

                        setState(() {
                          isInAsyncCall = false;
                        });
                      }
                    }
                  },
                  child: isInAsyncCall
                      ? loadingBar(context)
                      : mainButton(
                          "Proceed", const Color(0xff2B65EC), context)),
            ),
          ],
        ));
  }
}
