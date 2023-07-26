import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ViewPassport extends StatefulWidget {
  const ViewPassport({super.key});

  @override
  State<ViewPassport> createState() => _ViewPassportState();
}

class _ViewPassportState extends State<ViewPassport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00AEFF),
      appBar: AppBar(
        backgroundColor: Color(0xFF00AEFF),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              "assets/arrowLeft.svg",
              width: 20,
              height: 20,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              "assets/notification.svg",
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
              child: Image.asset(
            "assets/passport.png",
          )),
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 188,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'View Pages',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFF65734),
                  fontSize: 24,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/arrowRoundLeft.svg"),
                  SizedBox(
                    width: 20,
                  ),
                  SvgPicture.asset("assets/minus.svg"),
                  SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset("assets/add.svg"),
                  SizedBox(
                    width: 20,
                  ),
                  SvgPicture.asset("assets/arrowRight.svg"),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFFFF8D74), Color(0xFFF65634)],
                      ),
                      shape: OvalBorder(),
                    ),
                    child: Center(child: SvgPicture.asset("assets/share1.svg")),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 72,
                    height: 72,
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFFFF8D74), Color(0xFFF65634)],
                      ),
                      shape: OvalBorder(),
                    ),
                    child: Center(child: SvgPicture.asset("assets/import.svg")),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 72,
                    height: 72,
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFFFF8D74), Color(0xFFF65634)],
                      ),
                      shape: OvalBorder(),
                    ),
                    child: Center(child: SvgPicture.asset("assets/print1.svg")),
                  ),
                ],
              ),
            ]),
          )
        ],
      ),
    );
  }
}
