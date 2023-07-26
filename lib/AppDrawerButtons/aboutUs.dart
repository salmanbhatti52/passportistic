import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'About Us',
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
              child: const Icon(Icons.arrow_back_ios)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 350,
              child: Text(
                "Welcome to Passporttastic, your premier air travel agency for all your flight needs! We are dedicated to providing you with the best and most convenient air travel experiences, ensuring that your journey is smooth, comfortable, and unforgettable.\n\nAt Passporttastic, we understand that planning and booking air travel can be a daunting task. That's why our team of expert travel consultants is here to assist you every step of the way. Whether you're flying for business or pleasure, our knowledgeable professionals will go above and beyond to tailor your travel arrangements to suit your preferences, budget, and schedule.\n\nWith access to a vast network of domestic and international airlines, we offer a wide range of flight options to destinations across the globe. From quick weekend getaways to extensive worldwide adventures, we have you covered. Our commitment to excellence means that we carefully select our airline partners to ensure the highest standards of safety, reliability, and customer service.\n\nBooking your flights with Passporttastic is a breeze. Our user-friendly online platform allows you to effortlessly search, compare, and book flights at your convenience. If you prefer personalized assistance, our dedicated customer support team is just a phone call away. We take pride in providing prompt, friendly, and efficient service, ensuring that all your inquiries and requests are handled with utmost care.\n\nAs a customer-centric company, your satisfaction is our top priority. We strive to exceed your expectations by offering competitive prices, flexible itineraries, and value-added services. Whether you're a frequent flyer or embarking on your first air travel adventure, we believe in building long-term relationships with our clients, earning their trust and loyalty through exceptional service.\n\nAt Passporttastic, we go beyond just booking flights. We understand that air travel is part of a larger travel experience. That's why we offer a range of additional services to enhance your journey. From airport transfers and hotel accommodations to travel insurance and visa assistance, we take care of the finer details, allowing you to focus on creating cherished memories.\n\nChoose Passporttastic as your trusted air travel partner, and let us elevate your travel experience to new heights. Sit back, relax, and let us take care of all your flight arrangements. With our expertise, passion for travel, and unwavering commitment to customer satisfaction, we guarantee that your journey with us will be truly exceptional.\n\nFly with confidence. Fly with Passporttastic.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
