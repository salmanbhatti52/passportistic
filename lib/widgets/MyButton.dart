import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:scanguard/Utils/colors.dart';

Widget mainButton(
  text,
  color,
  BuildContext context,
) {
  final isMobile = ResponsiveBreakpoints.of(context).isMobile;
  final isTablet = ResponsiveBreakpoints.of(context).isTablet;
  final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Container(
      height: isMobile
          ? MediaQuery.of(context).size.height * 0.07
          : MediaQuery.of(context).size.height * 0.065,
      width: isMobile
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: appThemeColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            spreadRadius: 0,
            blurRadius: 15,
            offset: Offset(1, 10),
            color: Color.fromRGBO(7, 1, 87, 0.1),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontFamily: "Outfit",
              fontSize: isMobile ? 14 : 20,
              color: Colors.white,
              fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

Widget smallButton(
  text,
  color,
  BuildContext context,
) {
  return Container(
    height: 48,
    width: 118,
    decoration: BoxDecoration(
      color: appThemeColor,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          spreadRadius: 0,
          blurRadius: 15,
          offset: Offset(1, 10),
          color: Color.fromRGBO(7, 1, 87, 0.1),
        ),
      ],
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
            fontFamily: "Outfit",
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w400),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget smallButton2(
  text,
  color,
  BuildContext context,
) {
  return Container(
    height: 31,
    width: 81,
    decoration: BoxDecoration(
      color: appThemeColor,
      borderRadius: BorderRadius.circular(6),
      boxShadow: const [
        BoxShadow(
          spreadRadius: 0,
          blurRadius: 15,
          offset: Offset(1, 10),
          color: Color.fromRGBO(7, 1, 87, 0.1),
        ),
      ],
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
            fontFamily: "Outfit",
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w400),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget smallButton3(
  text,
  color,
  BuildContext context,
) {
  return Container(
    height: 31,
    width: 65,
    decoration: BoxDecoration(
      color: appThemeColor,
      borderRadius: BorderRadius.circular(6),
      boxShadow: const [
        BoxShadow(
          spreadRadius: 0,
          blurRadius: 15,
          offset: Offset(1, 10),
          color: Color.fromRGBO(7, 1, 87, 0.1),
        ),
      ],
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
            fontFamily: "Outfit",
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w400),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget loadingBar(
  BuildContext context,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: appThemeColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            spreadRadius: 0,
            blurRadius: 15,
            offset: Offset(1, 10),
            color: Color.fromRGBO(7, 1, 87, 0.1),
          ),
        ],
      ),
      child: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Please Wait...",
              style: TextStyle(
                  fontFamily: "Outfit",
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
