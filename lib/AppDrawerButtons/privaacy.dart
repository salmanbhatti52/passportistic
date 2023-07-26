import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Privacy Policy',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF141010),
            fontSize: 20,
            fontFamily: 'Satoshi',
            fontWeight: FontWeight.w700,
          ),
        ),
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.all(14.0),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset("assets/menub.svg")),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text:
                      "At Passporttastic, we are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy outlines how we collect, use, disclose, and safeguard the data you provide to us when using our services. By using Passporttastic's website or engaging with our services, you consent to the practices described in this Privacy Policy.\n",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text:
                      "1. Information We Collect: a. Personal Information: When you make a flight reservation or interact with our website, we may collect personal information such as your name, contact details, billing information, and travel preferences. b. Usage Information: We gather non-personal information about your interactions with our website, including your IP address, browser type, operating system, and pages visited. This information helps us analyze trends, administer the site, and improve user experience.\n 2. Use of Collected Information: a. We utilize the information we collect to process your flight reservations, communicate with you regarding your bookings, and provide customer support. b. Personal information may also be used to personalize your experience, tailor our offerings to your preferences, and send you relevant promotional materials and updates. c. We may use usage information for internal purposes, such as analyzing website usage patterns, troubleshooting issues, and enhancing our services.\n3. Data Retention: a. Passporttastic retains your personal information for as long as necessary to fulfill the purposes outlined in this Privacy Policy, unless a longer retention period is required or permitted by law. b. We take reasonable measures to securely store and protect your personal information from unauthorized access, disclosure, alteration, or destruction.\n4. Information Sharing and Disclosure: a. We may share your personal information with trusted third-party service providers who assist us in delivering our services, such as airlines, hotels, car rental agencies, and travel insurance providers. These partners are obligated to protect your data and use it solely for the purposes of providing the requested services. b. We may also disclose your information when required by law, in response to legal requests, or to protect our rights, property, or safety, as well as the rights, property, or safety of others.\n5. Third-Party Links: a. Our website may contain links to third-party websites or services. Please note that this Privacy Policy does not cover the practices of these third parties. We encourage you to review their privacy policies before engaging with their services.\n6. Children's Privacy: a. Passporttastic does not knowingly collect personal information from individuals under the age of 18. If you become aware that a child has provided us with personal information without parental consent, please contact us, and we will take steps to remove the information from our systems.\n7. Your Privacy Choices: a. You have the right to access, update, and correct your personal information. You may also opt-out of receiving promotional communications from Passporttastic by following the instructions provided in our communications or by contacting us directly. b. Please note that even if you opt-out of marketing communications, we may still send you transactional or administrative messages related to your bookings or our services.\n8. Changes to the Privacy Policy: a. Passporttastic reserves the right to update or modify this Privacy Policy at any time. We will notify you of any material changes through our website or other appropriate means. Your continued use of our services after the changes have been implemented constitutes your acceptance of the revised Privacy Policy.\n",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text:
                      "If you have any questions, concerns, or requests regarding our Privacy Policy or the protection of your personal information, please contact us through the provided channels. We are dedicated to addressing your inquiries and ensuring your privacy is respected and safeguarded.\n\nThank you for trusting Passporttastic with your travel needs.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.justify,
          ),
        ]),
      )),
    );
  }
}
