import 'package:flutter/material.dart';
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
