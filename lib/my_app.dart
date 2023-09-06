import 'package:flutter/cupertino.dart';
import 'pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Bootcamp 2023 DIO IMC',
      home: HomePage(),
    );
  }
}
