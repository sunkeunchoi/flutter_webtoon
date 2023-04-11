import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  // static String routeName="/home";
  // static String routePath="/home";
  static Route route() =>
      MaterialPageRoute(builder: (context) => const HomeScreen());
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HomeScreen',
        ),
      ),
    );
  }
}
