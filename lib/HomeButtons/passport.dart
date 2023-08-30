import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ViewPassport extends StatefulWidget {
  const ViewPassport({super.key});

  @override
  State<ViewPassport> createState() => _ViewPassportState();
}

class _ViewPassportState extends State<ViewPassport> {
  int currentPage = 0; // Keep track of the current page

  void nextPage() {
    setState(() {
      currentPage++;
    });
  }

  void previousPage() {
    setState(() {
      currentPage--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00AEFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00AEFF),
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
          const SizedBox(
            height: 10,
          ),
          Transform(
            transform: Matrix4.identity()
              ..translate(0.0, 0.0)
              ..rotateZ(-1.57),
            child: Container(
              width: 453,
              height: 314,
              padding: const EdgeInsets.only(
                top: 24,
                left: 17.29,
                right: 18.49,
                bottom: 24.98,
              ),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: const Color(0xFFFFFCF4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17.34),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "John Doe",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Passport No: 123456789",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF9C9999),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Date of Birth:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF9C9999),
                    ),
                  ),
                  Text(
                    "01 Jan 1990",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Nationality:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF9C9999),
                    ),
                  ),
                  Text(
                    "United States",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "MRZ Zone",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 188,
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                'View Pages',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFF65734),
                  fontSize: 24,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/arrowRoundLeft.svg"),
                  const SizedBox(
                    width: 20,
                  ),
                  SvgPicture.asset("assets/minus.svg"),
                  const SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset("assets/add.svg"),
                  const SizedBox(
                    width: 20,
                  ),
                  SvgPicture.asset("assets/arrowRight.svg"),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: const ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFFFF8D74), Color(0xFFF65634)],
                      ),
                      shape: OvalBorder(),
                    ),
                    child: Center(child: SvgPicture.asset("assets/share1.svg")),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 72,
                    height: 72,
                    decoration: const ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFFFF8D74), Color(0xFFF65634)],
                      ),
                      shape: OvalBorder(),
                    ),
                    child: Center(child: SvgPicture.asset("assets/import.svg")),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 72,
                    height: 72,
                    decoration: const ShapeDecoration(
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
      // bottomNavigationBar: Container(
      //   width: double.infinity,
      //   padding: const EdgeInsets.all(20),
      //   decoration: const BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      //     boxShadow: [
      //       BoxShadow(
      //         color: Color(0x0F312E23),
      //         blurRadius: 16,
      //         offset: Offset(0, 8),
      //         spreadRadius: 0,
      //       ),
      //     ],
      //   ),
      //   child: Column(
      //     children: [
      //       const SizedBox(height: 10),
      //       const Text(
      //         'View Pages',
      //         textAlign: TextAlign.center,
      //         style: TextStyle(
      //           color: Color(0xFFF65734),
      //           fontSize: 24,
      //           fontFamily: 'Satoshi',
      //           fontWeight: FontWeight.w500,
      //         ),
      //       ),
      //       const SizedBox(height: 10),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           GestureDetector(
      //             onTap: previousPage,
      //             child: SvgPicture.asset("assets/arrowRoundLeft.svg"),
      //           ),
      //           const SizedBox(width: 20),
      //           SvgPicture.asset("assets/minus.svg"),
      //           const SizedBox(width: 10),
      //           SvgPicture.asset("assets/add.svg"),
      //           const SizedBox(width: 20),
      //           GestureDetector(
      //             onTap: nextPage,
      //             child: SvgPicture.asset("assets/arrowRight.svg"),
      //           ),
      //         ],
      //       ),
      //       const SizedBox(height: 10),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Container(
      //             width: 72,
      //             height: 72,
      //             decoration: const ShapeDecoration(
      //               gradient: LinearGradient(
      //                 begin: Alignment(0.00, -1.00),
      //                 end: Alignment(0, 1),
      //                 colors: [Color(0xFFFF8D74), Color(0xFFF65634)],
      //               ),
      //               shape: OvalBorder(),
      //             ),
      //             child: Center(
      //               child: SvgPicture.asset("assets/share1.svg"),
      //             ),
      //           ),
      //           const SizedBox(width: 20),
      //           Container(
      //             width: 72,
      //             height: 72,
      //             decoration: const ShapeDecoration(
      //               gradient: LinearGradient(
      //                 begin: Alignment(0.00, -1.00),
      //                 end: Alignment(0, 1),
      //                 colors: [Color(0xFFFF8D74), Color(0xFFF65634)],
      //               ),
      //               shape: OvalBorder(),
      //             ),
      //             child: Center(
      //               child: SvgPicture.asset("assets/import.svg"),
      //             ),
      //           ),
      //           const SizedBox(width: 20),
      //           Container(
      //             width: 72,
      //             height: 72,
      //             decoration: const ShapeDecoration(
      //               gradient: LinearGradient(
      //                 begin: Alignment(0.00, -1.00),
      //                 end: Alignment(0, 1),
      //                 colors: [Color(0xFFFF8D74), Color(0xFFF65634)],
      //               ),
      //               shape: OvalBorder(),
      //             ),
      //             child: Center(
      //               child: SvgPicture.asset("assets/print1.svg"),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
