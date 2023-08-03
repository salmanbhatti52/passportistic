import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GpayAPay extends StatefulWidget {
  const GpayAPay({super.key});

  @override
  State<GpayAPay> createState() => _GpayAPayState();
}

class _GpayAPayState extends State<GpayAPay> {
  // Future<void> createGooglePayPayment() async {
  //   try {
  //     // final paymentMethod =
  //     //     // ignore: deprecated_member_use
  //     //     await Stripe.instance.createGooglePayPaymentMethod(
  //     //   // Replace the below values with your own Google Pay API key
  //     //     );
  //     // Use the paymentMethod.id to make a payment on the server-side
  //     // You can pass this paymentMethod.id to your server to create a payment using the Stripe API.
  //     // Handle the success and error cases accordingly.
  //   } catch (e) {
  //     // Handle errors here
  //     print('Error creating Google Pay payment: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color(0xFF00AEFF),
            image: DecorationImage(
              image: AssetImage("assets/bg.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        "assets/menu.svg",
                      ),
                    ),
                  ),
                  Text(
                    'Payment',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF141010),
                      fontSize: 20,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '       ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF141010),
                      fontSize: 20,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Make a Payment',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                '\$6.60',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 75,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'Total to pay',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w400,
                ),
              ),
              //  Spacer(),
              SizedBox(
                height: 150,
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(40)),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(40)),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 60,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: selectContainer1,
                                child: buildContainer(
                                    "assets/aPay.svg", isClicked1),
                              ),
                              SizedBox(width: 20),
                              GestureDetector(
                                onTap: selectContainer2,
                                child: buildContainer(
                                    "assets/gPay.svg", isClicked2),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 350,
                                height: 48,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.00, -1.00),
                                    end: Alignment(0, 1),
                                    colors: [
                                      Color(0xFFFF8D74),
                                      Color(0xFFF65634)
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Pay',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Satoshi',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildContainer(String assetName, bool isClicked) {
    return Container(
      width: 171,
      height: 171,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: isClicked
            ? Colors.white
            : Colors.white, // Updated to use white when not clicked
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.75, color: Colors.orange),
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: isClicked
            ? [
                BoxShadow(
                  color: Color(0x26FF8D74),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                ),
              ]
            : [],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 26,
            top: 29,
            child: Container(
              child: Stack(
                children: [
                  Text(
                    'Pay with',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFF65734),
                      fontSize: 24,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 48),
                    child: SvgPicture.asset(assetName),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 147,
            top: 8,
            child: Container(
              width: 16,
              height: 16,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: ShapeDecoration(
                        gradient: isClicked
                            ? LinearGradient(
                                begin: Alignment(0.00, -1.00),
                                end: Alignment(0, 1),
                                colors: [
                                  Color(0xFFFF8D74),
                                  Color(0xFFF65634),
                                ],
                              )
                            : null,
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  if (isClicked)
                    Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void selectContainer1() {
    setState(() {
      isClicked1 = true;
      isClicked2 = false;
    });
  }

  void selectContainer2() {
    setState(() {
      isClicked1 = false;
      isClicked2 = true;
    });
  }

  bool isClicked1 = false;
  bool isClicked2 = false;
}
