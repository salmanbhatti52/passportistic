import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

class StampPainter extends StatelessWidget {
  final String imageUrl;

  const StampPainter({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _getImageFromUrl(imageUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading indicator
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Show error if image loading fails
        } else {
          return CustomPaint(
            painter: _ImagePainter(imageData: snapshot.data!),
            size: const Size(250, 200), // Set the size as per your requirement
          );
        }
      },
    );
  }

  Future<Uint8List> _getImageFromUrl(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes; // Return image data if request is successful
    } else {
      throw Exception('Failed to load image: ${response.statusCode}');
    }
  }
}

class _ImagePainter extends CustomPainter {
  final Uint8List imageData;

  _ImagePainter({required this.imageData});

  @override
  void paint(Canvas canvas, Size size) async {
    final codec = await ui.instantiateImageCodec(imageData);
    final frameInfo = await codec.getNextFrame();
    final image = frameInfo.image;

    canvas.drawImage(
      image,
      Offset.zero,
      Paint(),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
