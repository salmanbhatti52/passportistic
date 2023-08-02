import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'appDrawer.dart';

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
      drawer: AppDrawer(),
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          'Purchase Stamps',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFF65734),
            fontSize: 24,
            fontFamily: 'Satoshi',
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                "assets/menu.svg",
                // fit: BoxFit.scaleDown,
              ),
            ),
          );
        }),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: SvgPicture.asset(
              "assets/notification.svg",
              // fit: BoxFit.scaleDown,
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
            crossAxisSpacing: 6.0,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  // Handle stamp selection
                },
                child: Container(
                  width: 171,
                  height: 267,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 171,
                          height: 267,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 0.50, color: Color(0xFFE0E0E5)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 171,
                          height: 151,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/3839651/pexels-photo-3839651.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 0.50, color: Color(0xFFE0E0E5)),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 8,
                        top: 159,
                        child: Text(
                          '25 Stamp Pack',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 8,
                        top: 186,
                        child: Text(
                          '\$2.49',
                          style: TextStyle(
                            color: Color(0xFFF65734),
                            fontSize: 20,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 34,
                        top: 223,
                        child: Container(
                          width: 104,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            gradient: LinearGradient(
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
                      ),
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }
}
