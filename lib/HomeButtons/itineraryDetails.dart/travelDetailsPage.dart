import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TravelDetailsPage extends StatefulWidget {
  const TravelDetailsPage({Key, key}) : super(key: key);

  @override
  State<TravelDetailsPage> createState() => _TravelDetailsPageState();
}

class _TravelDetailsPageState extends State<TravelDetailsPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<ContainerData> _containerDataList = [
    ContainerData(title: 'Container 1'),
    ContainerData(title: 'Container 2'),
    ContainerData(title: 'Container 3'),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              "assets/arrowBack1.svg",
            ),
          ),
        ),
        title: Text(
          'UK 2023',
          style: TextStyle(
            color: Color(0xFF525252),
            fontSize: 24,
            fontFamily: 'Satoshi',
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset("assets/notification.svg"),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Travel Details',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFF65734),
              fontSize: 24,
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: SvgPicture.asset("assets/arrow1.svg"),
                  onPressed: () {
                    if (_currentPage > 0) {
                      _goToPage(_currentPage - 1);
                    }
                  },
                ),
                Text(
                  'Day ${_currentPage + 1}',
                  style: TextStyle(
                    color: Color(0xFF525252),
                    fontSize: 16,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  icon: SvgPicture.asset("assets/arrow.svg"),
                  onPressed: () {
                    if (_currentPage < _containerDataList.length - 1) {
                      _goToPage(_currentPage + 1);
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _containerDataList.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                final containerData = _containerDataList[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: 250,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x0F312E23),
                          blurRadius: 16,
                          offset: Offset(0, 8),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Day No',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    '1',
                                    style: TextStyle(
                                      color: Color(0xFFF65734),
                                      fontSize: 18,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  // ---
                                  Text(
                                    'Travel Mode',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  // ---
                                  Text(
                                    'Air',
                                    style: TextStyle(
                                      color: Color(0xFFF65734),
                                      fontSize: 18,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  // ---
                                  Text(
                                    'Trip Details',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  // ---
                                  Text(
                                    'SG2023',
                                    style: TextStyle(
                                      color: Color(0xFFF65734),
                                      fontSize: 18,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  // ---
                                  Text(
                                    'Travel Time',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  // ---
                                  Text(
                                    '10:00',
                                    style: TextStyle(
                                      color: Color(0xFFF65734),
                                      fontSize: 18,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  // ---
                                  Text(
                                    'Local Time',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  // ---
                                  Text(
                                    '10:05',
                                    style: TextStyle(
                                      color: Color(0xFFF65734),
                                      fontSize: 18,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Local Date',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  // ---
                                  Text(
                                    '07 May 2023',
                                    style: TextStyle(
                                      color: Color(0xFFF65734),
                                      fontSize: 18,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  // ---
                                  Text(
                                    'From',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  // ---
                                  Text(
                                    'Brisbane',
                                    style: TextStyle(
                                      color: Color(0xFFF65734),
                                      fontSize: 18,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  // ---
                                  Text(
                                    'Local Time',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  // ---
                                  Text(
                                    '2:45 PM',
                                    style: TextStyle(
                                      color: Color(0xFFF65734),
                                      fontSize: 18,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  // ---
                                  Text(
                                    'To',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  // ---
                                  Text(
                                    'Singapore',
                                    style: TextStyle(
                                      color: Color(0xFFF65734),
                                      fontSize: 18,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  // ---
                                  Text(
                                    'Layover',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  // ---
                                  Text(
                                    '2:15',
                                    style: TextStyle(
                                      color: Color(0xFFF65734),
                                      fontSize: 18,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  )
                                ],
                              ),

                              // ---
                            ]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildIndicators(),
          ),
          SizedBox(height: 20),
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
          SizedBox(height: 20),
        ],
      ),
    );
  }

//   Future<List<int>> _generatePdf(BuildContext context) async {
//   final pdf = Document();

//   // Add the container content to the PDF
//   pdf.addPage(
//     MultiPage(
//       build: (context) => [
//         Container(
//           width: 284,
//           decoration: ShapeDecoration(
//             color: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             shadows: [
//               BoxShadow(
//                 color: Color(0x0F312E23),
//                 blurRadius: 16,
//                 offset: Offset(0, 8),
//                 spreadRadius: 0,
//               )
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 // Add your container content here
//               ],
//            ) ),)
//       ],
//     ),
//   );

//   // Save the PDF document as a list of bytes
//   final pdfBytes = await pdf.save();

//   return pdfBytes;
// }

  List<Widget> _buildIndicators() {
    return List.generate(
      _containerDataList.length,
      (index) => Container(
        width: 10,
        height: 6,
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: _currentPage == index ? Colors.orange : Color(0xFF9C9999),
        ),
      ),
    );
  }
}

class ContainerData {
  final String title;

  ContainerData({required this.title});
}
