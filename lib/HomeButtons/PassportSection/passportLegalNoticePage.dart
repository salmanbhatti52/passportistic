import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:scanguard/HomeButtons/PassportSection/bloc/leagalnoticsBloc.dart';
import '../../auth/signUpNextPage.dart';

class PassportLegalNoticePage extends StatefulWidget {
  const PassportLegalNoticePage({super.key});

  @override
  State<PassportLegalNoticePage> createState() =>
      _PassportLegalNoticePageState();
}

class _PassportLegalNoticePageState extends State<PassportLegalNoticePage> {
  @override
  void initState() {
    super.initState();
    context.read<PassportLegalNoticePageCubit>().loadLegalNotice();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return BlocBuilder<PassportLegalNoticePageCubit,
        PassportLegalNoticePageState>(
      builder: (context, state) {
        if (state == PassportLegalNoticePageState.loading) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
            backgroundColor: Color(0xFFF65734),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ));
        } else if (state == PassportLegalNoticePageState.loaded) {
          final legalnotice =
              context.read<PassportLegalNoticePageCubit>().legalnotice;
          return isMobile
              ? buildLoadedUI(legalnotice)
              : buildLoadedUIT(legalnotice);
        } else if (state == PassportLegalNoticePageState.error) {
          return const Center(child: Text('Error loading legal notice'));
        }
        return Container(); // Handle other cases if needed
      },
    );
  }

  Widget buildLoadedUI(String? legalnotice) {
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 416.02,
                height: 36.98,
                padding: const EdgeInsets.only(top: 7.51, bottom: 7.47),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: const Center(
                  child: Text(
                    'Legal notices',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF50A0FF),
                      fontSize: 16.18,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: 420.02,
                    height: 200.14,
                    padding: const EdgeInsets.only(bottom: 2.14),
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    child: legalnotice != null
                        ? Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: legalnotice
                                      .toUpperCase(), // Set the legal notice text here
                                  style: const TextStyle(
                                    color: Color(0xFF141010),
                                    fontSize: 9.24,
                                    fontFamily: 'OCR-B 10 BT',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.justify,
                          )
                        : const Text(""),
                  ),
                  if (isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoadedUIT(String? legalnotice) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RotatedBox(
        quarterTurns: 3,
        child: Center(
          child: Container(
            width: 900, // Updated width
            height: 700,

            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFFFFFCF5),
              // color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17.33),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    width: 560.22,
                    height: 400.02,
                    padding: const EdgeInsets.only(
                        top: 7.51, bottom: 7.47, left: 16, right: 16),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Legal notices',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF50A0FF),
                            fontSize: 22.18,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 2.14),
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: legalnotice != null
                              ? Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: legalnotice
                                            .toUpperCase(), // Set the legal notice text here
                                        style: const TextStyle(
                                          color: Color(0xFF141010),
                                          fontSize: 13.24,
                                          fontFamily: 'OCR-B 10 BT',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                )
                              : const Text(""),
                        )
                      ],
                    ),
                  ),
                ),
                // Stack(
                //   children: [
                //     Container(
                //       width: 420.02,
                //       height: 200.14,
                //       padding: const EdgeInsets.only(bottom: 2.14),
                //       clipBehavior: Clip.antiAlias,
                //       decoration: const BoxDecoration(),
                //       child: legalnotice != null
                //           ? Text.rich(
                //               TextSpan(
                //                 children: [
                //                   TextSpan(
                //                     text: legalnotice
                //                         .toUpperCase(), // Set the legal notice text here
                //                     style: const TextStyle(
                //                       color: Color(0xFF141010),
                //                       fontSize: 9.24,
                //                       fontFamily: 'OCR-B 10 BT',
                //                       fontWeight: FontWeight.w400,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //               textAlign: TextAlign.justify,
                //             )
                //           : const Text(""),
                //     ),
                //     if (isLoading)
                //       const Center(
                //         child: CircularProgressIndicator(),
                //       ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
