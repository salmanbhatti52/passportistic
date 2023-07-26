import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scanguard/Home/mainScreenHome.dart';

class StampPage extends StatefulWidget {
  const StampPage({Key? key}) : super(key: key);

  @override
  _StampPageState createState() => _StampPageState();
}

class _StampPageState extends State<StampPage> {
  List<String> stamps = [
    "Stamp 1",
    "Stamp 2",
    "Stamp 3",
    "Stamp 4",
    "Stamp 5",
    "Stamp 6",
    "Stamp 7",
    "Stamp 8",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.black.withOpacity(0.5)),
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'Purchase Stamps',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFF65734),
              fontSize: 24,
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MainScreen()),
              (Route<dynamic> route) => false,
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SvgPicture.asset(
              "assets/arrowBack1.svg",
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 15),
            child: SvgPicture.asset(
              "assets/notification.svg",
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: GridView.builder(
          shrinkWrap: true,
          //physics: NeverScrollableScrollPhysics(),
          itemCount: stamps.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                // Handle stamp selection
              },
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.50, color: Color(0xFFE0E0E5)),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 0.50, color: Color(0xFFE0E0E5)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: Image.asset(
                            "assets/StampImage.png",
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      stamps[index],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '\$1.99',
                      style: TextStyle(
                        color: Color(0xFFF65734),
                        fontSize: 20,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 104,
                        height: 30,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.00, -1.00),
                            end: Alignment(0, 1),
                            colors: [Color(0xFFFF8D74), Color(0xFFF65634)],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Buy',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
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
