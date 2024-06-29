import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:scanguard/Models/getColorListModels.dart';
import 'package:scanguard/Models/getStampShapeListModels.dart';
import 'package:scanguard/Models/transportListModels.dart';
import 'package:scanguard/auth/signUpPage.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StampWidget extends StatefulWidget {
  const StampWidget({super.key});

  @override
  _StampWidgetState createState() => _StampWidgetState();
}

class _StampWidgetState extends State<StampWidget> {
  ScreenshotController screenshotController = ScreenshotController();

  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  String? selectedTransportMode;
  String? selectedStampShape;
  String? selectedColor;

  bool isLoading = false;
  SharedPreferences? prefs;
  String? userID;
  GetStampShapeListModels getStampShapeListModels = GetStampShapeListModels();
  TransportListModels transportListModels = TransportListModels();
  GetColorListModels getColorListModels = GetColorListModels();

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  void fetchInitialData() async {
    await shapeList();
    await mdoeofTransport();
    await getColorList();
  }

  Future<void> shapeList() async {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/get_stamp_shape";
    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": "$userID",
    });
    if (response.statusCode == 200) {
      getStampShapeListModels = getStampShapeListModelsFromJson(response.body);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> mdoeofTransport() async {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/get_transport_mode";
    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": userID,
    });
    if (response.statusCode == 200) {
      transportListModels = transportListModelsFromJson(response.body);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getColorList() async {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    String apiUrl = "$baseUrl/get_stamps_color";
    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "passport_holder_id": userID,
    });
    if (response.statusCode == 200) {
      getColorListModels = getColorListModelsFromJson(response.body);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Stamp'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: cityController,
                    decoration: const InputDecoration(labelText: 'City'),
                  ),
                  TextField(
                    controller: countryController,
                    decoration: const InputDecoration(labelText: 'Country'),
                  ),
                  TextField(
                    controller: dateController,
                    decoration: const InputDecoration(labelText: 'Date'),
                  ),
                  TextField(
                    controller: timeController,
                    decoration: const InputDecoration(labelText: 'Time'),
                  ),
                  // Dropdowns for Transport Mode, Shape, and Color
                  DropdownButton<String>(
                    hint: const Text('Select Transport Mode'),
                    value: selectedTransportMode,
                    onChanged: (value) {
                      setState(() {
                        selectedTransportMode = value;
                      });
                    },
                    items: transportListModels.data != null
                        ? transportListModels.data!.map((mode) {
                            return DropdownMenuItem(
                              value: mode.transportModeId!,
                              child: Text(mode.modeName!),
                            );
                          }).toList()
                        : [], // Empty list if data is null
                  ),

                  DropdownButton<String>(
                    hint: const Text('Select Stamp Shape'),
                    value: selectedStampShape,
                    onChanged: (value) {
                      setState(() {
                        selectedStampShape = value;
                      });
                    },
                    items: getStampShapeListModels.data != null
                        ? getStampShapeListModels.data!.map((shape) {
                            return DropdownMenuItem(
                              value: shape.shapesId!,
                              child: Text(shape.shapeName!),
                            );
                          }).toList()
                        : [], // Empty list if data is null
                  ),
                  DropdownButton<String>(
                    hint: const Text('Select Color'),
                    value: selectedColor,
                    onChanged: (value) {
                      setState(() {
                        selectedColor = value;
                      });
                    },
                    items: getColorListModels.data != null
                        ? getColorListModels.data!.map((color) {
                            return DropdownMenuItem(
                              value: color.stampsColorRgb!,
                              child: Text(color.stampsColor!),
                            );
                          }).toList()
                        : [], // Empty list if data is null
                  ),

                  ElevatedButton(
                    onPressed: () {
                      if (cityController.text.isEmpty ||
                          countryController.text.isEmpty ||
                          dateController.text.isEmpty ||
                          selectedTransportMode == null ||
                          selectedStampShape == null ||
                          selectedColor == null) {
                        // Show error
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please fill all fields')),
                        );
                      } else {
                        // Convert the selectedColor to a Color
                        final colorParts = selectedColor!.split(',');
                        final color = Color.fromRGBO(
                          int.parse(colorParts[0]),
                          int.parse(colorParts[1]),
                          int.parse(colorParts[2]),
                          1.0,
                        );

                        // Convert the selectedStampShape to Shape enum
                        Shape shape;
                        switch (selectedStampShape) {
                          case '1':
                            shape = Shape.pentagon;
                            break;
                          case '2':
                            shape = Shape.hexagon;
                            break;
                          case '3':
                            shape = Shape.octagon;
                            break;
                          case '4':
                            shape = Shape.oval;
                            break;
                          case '5':
                            shape = Shape.parallelogram;
                            break;
                          case '6':
                            shape = Shape.pentagon;
                            break;
                          case '7':
                            shape = Shape.rectangleRoundCorner;
                            break;
                          case '8':
                            shape = Shape.rectangleSquareCorner;
                            break;
                          case '9':
                            shape = Shape.square;
                            break;
                          case '10':
                            shape = Shape.tombstone;
                            break;
                          case '11':
                            shape = Shape.triangle;
                            break;
                          default:
                            shape = Shape.circle;
                            break;
                        }

                        // Assuming the transport mode images are in the assets folder
                        final transportModeImage =
                            'assets/transport_modes/$selectedTransportMode.png';

                        // Show the stamp
                        DateTime parsedDate =
                            DateTime.tryParse(dateController.text) ??
                                DateTime.now();

                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: CustomPaint(
                              size: const Size(300, 300),
                              painter: StampPainter(
                                city: cityController.text,
                                country: countryController.text,
                                date: parsedDate,
                                color: color,
                                shape: shape,
                                transportModeImage: transportModeImage,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Create Stamp'),
                  ),
                ],
              ),
            ),
    );
  }
}

class StampPainter extends CustomPainter {
  final String city;
  final String country;
  final DateTime date;
  final Color color;
  final Shape shape;
  final String transportModeImage;

  StampPainter({
    required this.city,
    required this.country,
    required this.date,
    required this.color,
    required this.shape,
    required this.transportModeImage,
  });

  @override
  void paint(Canvas canvas, Size size) async {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    // Draw the shape
    switch (shape) {
      case Shape.circle:
        canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
        break;
      case Shape.pentagon:
        drawPolygon(canvas, size, 5, paint);
        break;
      case Shape.triangle:
        drawPolygon(canvas, size, 3, paint);
        break;
      // Add other shapes here
      default:
        canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
        break;
    }

    // Load the transport mode image
    final ByteData data = await rootBundle.load(transportModeImage);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    final transportImage = frame.image;

    // Draw the transport mode image
    final paintImage = Paint();
    final imageSize = size.width * 0.2;
    canvas.drawImageRect(
      transportImage,
      Rect.fromLTRB(
        0,
        0,
        transportImage.width.toDouble(),
        transportImage.height.toDouble(),
      ),
      Rect.fromCenter(
        center: size.center(Offset.zero),
        width: imageSize,
        height: imageSize,
      ),
      paintImage,
    );

    // Draw the city and country text
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    final textSpan = TextSpan(
      text: '$city, $country',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    textPainter.paint(
      canvas,
      Offset(size.width / 2 - textPainter.width / 2, size.height * 0.7),
    );

    // Draw the date text
    const dateStyle = TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );
    final dateSpan = TextSpan(
      text: '${date.toLocal()}'.split(' ')[0],
      style: dateStyle,
    );
    final datePainter = TextPainter(
      text: dateSpan,
      textDirection: TextDirection.ltr,
    );
    datePainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    datePainter.paint(
      canvas,
      Offset(size.width / 2 - datePainter.width / 2, size.height * 0.8),
    );
  }

  void drawPolygon(Canvas canvas, Size size, int sides, Paint paint) {
    final double radius = size.width / 2;
    final double angle = (2 * pi) / sides;
    final Offset center = size.center(Offset.zero);

    final path = Path();
    for (int i = 0; i < sides; i++) {
      final double x = center.dx + radius * cos(i * angle);
      final double y = center.dy + radius * sin(i * angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

enum Shape {
  circle,
  pentagon,
  triangle,
  rectangleSquareCorner,
  hexagon,
  octagon,
  oval,
  parallelogram,
  rectangleRoundCorner,
  square,
  tombstone,
  // Add other shapes as needed
}

// void main() {
//   runApp(MaterialApp(home: StampWidget()));
// }
