import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/getProfileModels.dart';
import '../auth/signUpNextPage.dart';
import '../auth/signUpPage.dart';
import '../main.dart';
import 'navbar.dart';

class MainScreen extends StatefulWidget {
  final String? userId;

  const MainScreen({
    super.key,
    this.userId,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(
        userId: "${widget.userId}",
      ),
    );
  }
}
