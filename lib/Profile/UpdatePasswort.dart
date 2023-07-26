import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyApp extends StatelessWidget {
  final TextEditingController createPass = TextEditingController();
  final TextEditingController currentPass = TextEditingController();
  final TextEditingController confirmPass = TextEditingController();

  bool _obscureText = true;

  void _toggle() {
    _obscureText = !_obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Center(
        child: ElevatedButton(
          child: Text('Open Bottom Sheet'),
          onPressed: () {
        
          },
        ),
      ),
    );
  }

}

