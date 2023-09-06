import 'dart:math';

import 'package:bootcamp_2023_dio_imc/model/pessoa.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';

import '../controller/home_page_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageController homePageController;

  @override
  void initState() {
    super.initState();
    homePageController = HomePageController();
    homePageController.setImcStatus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("IMC - Bootcamp 2023 DIO"),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Nome: ${homePageController.pessoaAtual?.nome}'),
                  Text('IMC: ${homePageController.imc.round()}'),
                ],
              ),
            ),
          ),

          //
          Expanded(
            flex: 3,
            child: Container(
              child: Stack(children: [
                Container(
                    alignment: Alignment.topCenter,
                    height: 60,
                    width: double.infinity,
                    color: CupertinoColors.activeOrange,
                    padding: const EdgeInsets.all(10),
                    child: Text(homePageController.imcMessage)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.all(40),
                          child: AnimatedSize(
                            duration: const Duration(milliseconds: 3),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 3),
                              child: SvgPicture.network(
                                  placeholderBuilder: (_) =>
                                      const CupertinoActivityIndicator(),
                                  homePageController.imcImage),
                            ),
                          ),
                        )),
                    Expanded(
                        child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                                "Altura: ${homePageController.alturaSlider.round() / 100}"),
                          ),
                          Expanded(
                            child: RotatedBox(
                              quarterTurns: 3,
                              child: CupertinoSlider(
                                value: homePageController.alturaSlider,
                                min: 10,
                                max: 400.0,
                                onChanged: (value) {
                                  setState(() {
                                    homePageController.alturaSlider = value;
                                    homePageController.setImcStatus();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ]),
            ),
          ),
          //
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                        "Peso: ${homePageController.pesoSlider.round()}"),
                  ),
                  Container(
                      child: CupertinoSlider(
                    value: homePageController.pesoSlider,
                    min: 10,
                    max: 400.0,
                    onChanged: (value) {
                      setState(() {
                        homePageController.pesoSlider = value;
                        homePageController.setImcStatus();
                      });
                    },
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
