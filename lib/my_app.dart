import 'package:bootcamp_2023_dio_imc/controller/home_page_controller.dart';
import 'package:bootcamp_2023_dio_imc/data/db.dart';
import 'package:bootcamp_2023_dio_imc/repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomePageController>(
            create: (ctx) => HomePageController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
          colorScheme: const ColorScheme.light(),
        ),
        title: 'Bootcamp 2023 DIO IMC',
        home: const HomePage(),
      ),
    );
  }
}
