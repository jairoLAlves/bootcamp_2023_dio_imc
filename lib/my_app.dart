import 'package:flutter/material.dart';

import 'pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurpleAccent,
        colorScheme: const ColorScheme.light(),
      ),
      title: 'Bootcamp 2023 DIO IMC',
      home: const HomePage(),
    );
  }
}
