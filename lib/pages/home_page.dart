import 'package:bootcamp_2023_dio_imc/model/imc_today.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';
import 'package:intl/intl.dart';

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
    homePageController = context.read<HomePageController>();
  }

  @override
  Widget build(BuildContext context) {
    homePageController = context.watch<HomePageController>();
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.all(2),
                        child: CircleAvatar(
                          backgroundColor: Colors.black12,
                          maxRadius: 60,
                          child: CreateImgImc(
                            image: homePageController.imcImage,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text('Nome: ${homePageController.nome}'),
                      const Divider(
                        height: 2,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: ListView(
                      children: homePageController.getListImc
                          .map(
                            (imcItem) => createItemImcList(imcItem),
                          )
                          .toList()))
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("IMC - Bootcamp 2023 DIO"),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Text('Nome: ${homePageController.pessoaAtual?.nome}'),
                  Text('IMC: ${homePageController.imc.round()}'),
                ],
              ),
            ),

            //
            Expanded(
              flex: 4,
              child: Container(
                child: Stack(children: [
                  Container(
                      alignment: Alignment.topLeft,
                      height: 60,
                      width: double.infinity,
                      // color: Colors.orange,
                      padding: const EdgeInsets.all(10),
                      child: Text('Status: ${homePageController.imcMessage}')),
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
                                child: CreateImgImc(
                                    image: homePageController.imcImage),
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
                                child: Card(
                                  elevation: 3,
                                  child: Slider(
                                    value: homePageController.alturaSlider,
                                    min: 10,
                                    max: 400.0,
                                    onChanged: (value) {
                                      homePageController.alturaSlider = value;
                                      homePageController.loaderImc();
                                    },
                                  ),
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
              flex: 2,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                          "Peso: ${homePageController.pesoSlider.round()}"),
                    ),
                    Card(
                      child: Container(
                          child: Slider(
                        value: homePageController.pesoSlider,
                        min: 10,
                        max: 400.0,
                        onChanged: (value) {
                          homePageController.pesoSlider = value;
                          homePageController.loaderImc();
                        },
                      )),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        homePageController.saveImc();
                      },
                      child: const Text('Salve'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card createItemImcList(ImcToday imcItem) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text('${imcItem.imc.round()}')),
        trailing:
            Text('Data: ${DateFormat('dd/mm/yyyy').format(imcItem.dateTime)}'),
      ),
    );
  }
}

class CreateImgImc extends StatelessWidget {
  const CreateImgImc({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
        placeholderBuilder: (_) =>
            const Center(child: CircularProgressIndicator()),
        image);
  }
}
