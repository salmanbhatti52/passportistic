import 'package:flutter/material.dart';

class PassportLegalNoticePage extends StatefulWidget {
  const PassportLegalNoticePage({super.key});

  @override
  State<PassportLegalNoticePage> createState() =>
      _PassportLegalNoticePageState();
}

class _PassportLegalNoticePageState extends State<PassportLegalNoticePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RotatedBox(
        quarterTurns: 3,
        child: Container(
          width: 453,
          height: 314,
          padding: const EdgeInsets.only(
            top: 35,
            left: 18.49,
            right: 18.49,
            bottom: 34.01,
          ),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: const Color(0xFFFFFCF5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17.33),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  height: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 416.02,
                          height: 36.98,
                          padding:
                              const EdgeInsets.only(top: 7.51, bottom: 7.47),
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Legal notices',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF50A0FF),
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
                        left: 0,
                        top: 50.85,
                        child: Container(
                          width: 420.02,
                          height: 200.14,
                          padding: const EdgeInsets.only(bottom: 2.14),
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 416.02,
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            'THIS DOCUMENT IS A SOUVENIR ONLY.  IT HAS NOT BEEN ISSUED UNDER ANY LAWS OF ANY COUNTRY.  IT HAS NO VALUE, OTHER THAN TO ITS HOLDER AS A MEMENTO OF THEIR TRAVELS, REAL OR OTHERW\n\n',
                                        style: TextStyle(
                                          color: Color(0xFF141010),
                                          fontSize: 9.24,
                                          fontFamily: 'OCR-B 10 BT',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'TIPS FOR USE:-\n\n',
                                        style: TextStyle(
                                          color: Color(0xFF50A0FF),
                                          fontSize: 9.24,
                                          fontFamily: 'OCR-B 10 BT',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            'STAMP YOUR PASSPORT AT THE EARLIEST POSSIBLE TIME AS CLOSE TO THE TIME OF DEPARTURE OR ARRIVAL AS DELAYS WITH SERVICES MAY HAVE AN IMPACT ON DATES.\nSHOULD YOU ELECT TO USE THE ITINERARY FEATURE IN THIS APP, THEN YOU MAY WISH TO ENSURE THAT DEPARTURE AND ARRIVAL DATES OF STAMPS IS THE SAME AS IN YOUR ITINERARY.  THEY HAVE DELIBERATELY BEEN UNLINKED DUE TO POSSIBLE DELAYS IN SERVICES.  YOUR ITINERARY IS WHAT YOU PLANNED.  THE STAMPS ARE INDICATIVE AS TO WHAT ACTUALLY HAPPENED.\nYOU MAY SHARE YOUR TRAVEL DIARY WITH FRIENDS AND FAMILY, BUT DO TAKE CARE ABOUT EXPOSING TOO MUCH INFORMATION ON SOCIAL MEDIA AS THIEVES MAY TAKE ADVANTAGE OF YOUR INFORMATION.\n',
                                        style: TextStyle(
                                          color: Color(0xFF141010),
                                          fontSize: 9.24,
                                          fontFamily: 'OCR-B 10 BT',
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.37,
                                          wordSpacing: -0.37,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '\nSAFE TRAVELS',
                                        style: TextStyle(
                                          color: Color(0xFF141010),
                                          fontSize: 9.24,
                                          fontFamily: 'OCR-B 10 BT',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
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
      ),
    );
  }
}
