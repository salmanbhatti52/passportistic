import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({super.key});

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Terms & Conditions',
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
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 350,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Welcome to Passporttastic, your trusted air travel agency dedicated to providing exceptional travel experiences. Before you proceed with booking your flights and utilizing our services, we kindly ask you to carefully review and acknowledge the following terms and conditions:\n',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text:
                          "1. Flight Reservations: a. Passporttastic acts as an intermediary between you and the airlines. We strive to provide accurate and up-to-date flight information; however, we do not guarantee the availability of flights or the accuracy of the provided information. b. Flight reservations are subject to the terms and conditions of the respective airlines. It is your responsibility to review and comply with these terms. c. Passporttastic is not liable for any changes, delays, cancellations, or disruptions caused by the airlines or any other third-party providers.\n2. Pricing and Payments: a. Flight prices displayed on our website or communicated through our customer support channels are subject to change without prior notice. Prices may vary due to factors such as airline policies, seat availability, and market conditions. b. Passporttastic strives to provide transparent pricing, including all applicable taxes, fees, and surcharges. However, additional charges imposed by airlines or authorities may apply, and you are responsible for reviewing and understanding these charges before making a booking. c. Payment for flight bookings must be made in full at the time of reservation. We accept various forms of payment, including credit cards, debit cards, and electronic bank transfers. Any additional charges or fees related to the payment method are your responsibility.\n3. Travel Documentation: a. It is your responsibility to ensure that you possess the necessary travel documents, including passports, visas, and health certificates, required for your journey. Passporttastic will not be held liable for any inconveniences, delays, or cancellations resulting from inadequate or expired travel documents. b. We recommend that you review the passport validity requirements of your destination country, as some countries may require passports to be valid for a certain period beyond your planned departure date.\n4. Travel Insurance: a. Passporttastic highly recommends obtaining comprehensive travel insurance to protect yourself against unforeseen circumstances, including trip cancellations, medical emergencies, or baggage loss. It is your responsibility to evaluate and select the appropriate insurance coverage.\n5. Changes, Cancellations, and Refunds: a. Flight changes, cancellations, and refunds are subject to the terms and conditions of the respective airlines. Additional fees and restrictions may apply, and some tickets may be non-refundable or non-changeable. b. Passporttastic will assist you in processing any changes, cancellations, or refund requests to the best of our ability, but we do not guarantee the outcome or timelines for such requests. Any refunds granted by the airline will be subject to their policies and processing times.\n6. Limitation of Liability: a. Passporttastic strives to provide accurate and reliable information; however, we do not warrant or guarantee the accuracy, completeness, or reliability of the information provided. b. In no event shall Passporttastic be liable for any direct, indirect, incidental, consequential, or punitive damages arising out of your use of our services, including but not limited to flight reservations, cancellations, delays, or any other related services.\n\n",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text:
                          'By using the services of Passporttastic, you acknowledge and agree to abide by these terms and conditions. It is important to note that these terms may be subject to change without prior notice. We recommend reviewing our terms and conditions periodically to stay updated with any modifications.\n\nThank you for choosing Passporttastic. We look forward to assisting you with your air travel needs and providing you with a memorable and enjoyable journey.',
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
            ),
          )
        ]),
      ),
    );
  }
}
