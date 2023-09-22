import 'package:flutter/material.dart';

class BuyStamps extends StatefulWidget {
  const BuyStamps({super.key});

  @override
  State<BuyStamps> createState() => _BuyStampsState();
}

class _BuyStampsState extends State<BuyStamps> {
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
            body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          shrinkWrap: true,
          //          physics: NeverScrollableScrollPhysics(),
          itemCount: stamps.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
            childAspectRatio: 1 / 1.5,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: 171,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Container(
                        width: 171,
                        height: 151,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: Image.network(
                          "https://images.pexels.com/photos/3839651/pexels-photo-3839651.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                          fit: BoxFit.fill,
                        )),
                  ),
                  const Text(
                    '25 Stamp Pack',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    '\$2.49',
                    style: TextStyle(
                      color: Color(0xFFF65734),
                      fontSize: 20,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Container(
                    width: 104,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFFFF8D74), Color(0xFFF65634)],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Row(
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}