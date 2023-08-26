import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MyImageConverter extends StatefulWidget {
  const MyImageConverter({super.key});

  @override
  _MyImageConverterState createState() => _MyImageConverterState();
}

class _MyImageConverterState extends State<MyImageConverter> {
  String base64Image = '';

  Future<void> convertImageToBase64(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      final List<int> imageBytes = response.bodyBytes;
      final String base64 = base64Encode(imageBytes);

      setState(() {
        base64Image = base64;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image to Base64 Converter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Replace 'IMAGE_URL' with the actual image URL
                convertImageToBase64(
                    'https://portal.passporttastic.com/public/uploads/cover_design/1692770973legal_design.jpeg');
                print(base64Image);
              },
              child: const Text('Convert Image to Base64'),
            ),
            const SizedBox(height: 20),
            if (base64Image.isNotEmpty)
              Image.memory(
                base64Decode(base64Image),
                width: 200,
                height: 200,
              ),
          ],
        ),
      ),
    );
  }
}
