import 'package:bootcamp_2023_dio_imc/controller/imc_controller.dart';
import 'package:bootcamp_2023_dio_imc/enums/enums.dart';
import 'package:bootcamp_2023_dio_imc/model/imc_today.dart';
import 'package:bootcamp_2023_dio_imc/model/pessoa.dart';
import 'package:flutter/material.dart';

import '../util/math_util.dart';

class HomePageController extends ChangeNotifier {
//altura em cm
  double alturaSlider = 170;
//peso em kg
  double pesoSlider = 62;
  double imc = 0;
  ImcStatus imcStatus = ImcStatus.saudavel;
  String imcMessage = '';
  String imcImage = '';

  //TODO - get_pessoa_to_shared_preferences
  Pessoa? pessoaAtual;

  void setImcStatus() {
    imc = MathUtil.calcularIMC(pesoSlider, alturaSlider);
    imcStatus = ImcController.imcStatus(imc);
    imcMessage = ImcController.imcStatusMessage(imcStatus);
    imcImage = ImcController.imcImage(imcStatus);
    if (pessoaAtual != null) {
      pessoaAtual?.peso = pesoSlider;
      pessoaAtual?.altura = alturaSlider;
    } else {
      pessoaAtual =
          Pessoa(nome: "Person01", altura: alturaSlider, peso: pesoSlider);
    }
    notifyListeners();
  }

  

  void saveImc() {
    ImcToday imcToday = ImcToday(DateTime.now(), imc);
    pessoaAtual?.listaImc?.add(imcToday);
    //bool? isIn = pessoaAtual?.listaImc?.contains(imcToday);
  }
}
