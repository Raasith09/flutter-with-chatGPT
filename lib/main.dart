import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/utils/colors.dart';
import 'screens/initial_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: MyColors.primaryColor,
      ),
      home: const InitialPage(),
    );
  }
}
