import 'package:bootcamp_2023_dio_imc/controller/imc_controller.dart';
import 'package:bootcamp_2023_dio_imc/enums/enums.dart';
import 'package:bootcamp_2023_dio_imc/model/imc_today.dart';
import 'package:bootcamp_2023_dio_imc/model/pessoa.dart';
import 'package:flutter/material.dart';

import '../util/math_util.dart';

class HomePageController extends ChangeNotifier {
  Pessoa? pessoaAtual;



  double alturaSlider = 170;
  double pesoSlider = 62;

  double imc = 0;
  ImcStatus imcStatus = ImcStatus.saudavel;
  String imcMessage = '';
  String imcImage = '';

  void loaderPessoa() {
    if (pessoaAtual != null) {
      pessoaAtual!.peso = pesoSlider;
      pessoaAtual!.altura = alturaSlider;
    } else {
      pessoaAtual = Pessoa.empty();
    }
  }



  void loaderImc() {
    imc = MathUtil.calcularIMC(pesoSlider, alturaSlider);
    imcStatus = ImcController.imcStatus(imc);
    imcMessage = ImcController.imcStatusMessage(imcStatus);
    imcImage = ImcController.imcImage(imcStatus);
    notifyListeners();
  }

  void saveImc() {
    ImcToday imcToday = ImcToday(DateTime.now(), imc);
    pessoaAtual?.addListImc(imcToday);
    debugPrint(pessoaAtual?.toJson());
    //bool? isIn = pessoaAtual?.listaImc?.contains(imcToday);
    notifyListeners();
  }
}
