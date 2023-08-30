import 'package:flutter/material.dart';

class ViewPassportPage extends StatefulWidget {
  const ViewPassportPage({super.key});

  @override
  State<ViewPassportPage> createState() => _ViewPassportPageState();
}

class _ViewPassportPageState extends State<ViewPassportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Passport'),
      ),
      body: Column(children: [
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200.22,
                  height: 265.02,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 40.85,
                        child: Container(
                          width: 115.57,
                          height: 143.31,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 147.93,
                                height: 150.92,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://via.placeholder.com/148x185"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 1.16,
                        top: 200.03,
                        child: Container(
                          width: 416.07,
                          height: 36.98,
                          padding:
                              const EdgeInsets.only(top: 1.73, bottom: 2.18),
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 416.07,
                                child: Text(
                                  'S<AUDBURKE<<GARY<JOHN JOE<<<<<<<<<<<<<<<<<<<',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF141010),
                                    fontSize: 13.87,
                                    fontFamily: 'OCR-B 10 BT',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.69,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.07),
                              SizedBox(
                                width: 416.07,
                                child: Text(
                                  'PA1234567<<AUD<<19590526<<20230601<<48<<<<<<',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF141010),
                                    fontSize: 13.87,
                                    fontFamily: 'OCR-B 10 BT',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.69,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 1.16,
                        top: 0,
                        child: SizedBox(
                          width: 416.07,
                          height: 42.18,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 97.08,
                                  height: 36.98,
                                  padding: const EdgeInsets.only(
                                    top: 7.51,
                                    left: 7.51,
                                    right: 6.57,
                                    bottom: 7.47,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'PASSPORT',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.18,
                                          fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 212.66,
                                top: 0,
                                child: Container(
                                  width: 97.08,
                                  height: 42.18,
                                  padding: const EdgeInsets.only(right: 35.08),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'AUSTRALIA',
                                        style: TextStyle(
                                          color: Color(0xFF00247D),
                                          fontSize: 11.56,
                                          fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 0.76),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 29.02,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: -0,
                                              top: 15.02,
                                              child: Text(
                                                'AUD',
                                                style: TextStyle(
                                                  color: Color(0xFF141010),
                                                  fontSize: 13.87,
                                                  fontFamily: 'OCR-B 10 BT',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              top: 0,
                                              child: Text(
                                                'Currency',
                                                style: TextStyle(
                                                  color: Color(0xFF50A0FF),
                                                  fontSize: 9.25,
                                                  fontFamily: 'Open Sans',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 318.98,
                                top: 0,
                                child: Container(
                                  width: 97.08,
                                  height: 36.98,
                                  padding: const EdgeInsets.only(
                                      top: 5.78, right: 21.08, bottom: 2.18),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 76,
                                        height: double.infinity,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: -0,
                                              top: 15.02,
                                              child: Text(
                                                'PA1234567',
                                                style: TextStyle(
                                                  color: Color(0xFF141010),
                                                  fontSize: 13.87,
                                                  fontFamily: 'OCR-B 10 BT',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              top: 0,
                                              child: Text(
                                                'Passport No.',
                                                style: TextStyle(
                                                  color: Color(0xFF50A0FF),
                                                  fontSize: 9.25,
                                                  fontFamily: 'Open Sans',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 124.82,
                        top: 60.85,
                        child: SizedBox(
                          width: 292.40,
                          height: 143.31,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 141.58,
                                  height: 41.61,
                                  padding: const EdgeInsets.only(right: 49.58),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: const Column(
                                    // mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Name/Nom',
                                        style: TextStyle(
                                          color: Color(0xFF50A0FF),
                                          fontSize: 9.25,
                                          fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 2.02),
                                      Text(
                                        'BURKE GARY \nJOHN JOE',
                                        style: TextStyle(
                                          color: Color(0xFF141010),
                                          fontSize: 13.87,
                                          fontFamily: 'OCR-B 10 BT',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 50.85,
                                child: Container(
                                  width: 141.58,
                                  height: 41.61,
                                  padding: const EdgeInsets.only(
                                      top: 5.78, right: 38.58, bottom: 6.80),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 103,
                                        height: double.infinity,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: 0,
                                              top: 15.02,
                                              child: Text(
                                                'AUSTRALIAN',
                                                style: TextStyle(
                                                  color: Color(0xFF141010),
                                                  fontSize: 13.87,
                                                  fontFamily: 'OCR-B 10 BT',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              top: 0,
                                              child: Text(
                                                'Nationality/Nationalite ',
                                                style: TextStyle(
                                                  color: Color(0xFF50A0FF),
                                                  fontSize: 9.25,
                                                  fontFamily: 'Open Sans',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 101.71,
                                child: Container(
                                  width: 141.58,
                                  height: 41.61,
                                  padding: const EdgeInsets.only(
                                      top: 5.78, bottom: 6.80),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: double.infinity,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 15.02,
                                                child: Text(
                                                  '16-MAY-1959',
                                                  style: TextStyle(
                                                    color: Color(0xFF141010),
                                                    fontSize: 13.87,
                                                    fontFamily: 'OCR-B 10 BT',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Text(
                                                  'Date of Birth/Date de naissance ',
                                                  style: TextStyle(
                                                    color: Color(0xFF50A0FF),
                                                    fontSize: 9.25,
                                                    fontFamily: 'Open Sans',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 150.82,
                                top: 0,
                                child: Container(
                                  width: 141.58,
                                  height: 41.61,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                ),
                              ),
                              Positioned(
                                left: 150.82,
                                top: 50.85,
                                child: Container(
                                  width: 141.58,
                                  height: 41.61,
                                  padding: const EdgeInsets.only(
                                      top: 5.78, right: 101.58, bottom: 6.80),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: double.infinity,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: -0,
                                              top: 15.02,
                                              child: Text(
                                                'M',
                                                style: TextStyle(
                                                  color: Color(0xFF141010),
                                                  fontSize: 13.87,
                                                  fontFamily: 'OCR-B 10 BT',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              top: 0,
                                              child: Text(
                                                'Sex/Sexe',
                                                style: TextStyle(
                                                  color: Color(0xFF50A0FF),
                                                  fontSize: 9.25,
                                                  fontFamily: 'Open Sans',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 150.82,
                                top: 101.71,
                                child: Container(
                                  width: 141.58,
                                  height: 41.61,
                                  padding: const EdgeInsets.only(
                                      top: 5.78, right: 8.58, bottom: 6.80),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 133,
                                        height: double.infinity,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: -0,
                                              top: 15.02,
                                              child: Text(
                                                '1-MAY-2023',
                                                style: TextStyle(
                                                  color: Color(0xFF141010),
                                                  fontSize: 13.87,
                                                  fontFamily: 'OCR-B 10 BT',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              top: 0,
                                              child: Text(
                                                'Date of Issue/Date d’emission',
                                                style: TextStyle(
                                                  color: Color(0xFF50A0FF),
                                                  fontSize: 9.25,
                                                  fontFamily: 'Open Sans',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
          ),
        )
      ]),
    );
  }
}
