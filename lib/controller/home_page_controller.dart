// ignore_for_file: unnecessary_getters_setters

import 'package:bootcamp_2023_dio_imc/controller/imc_controller.dart';
import 'package:bootcamp_2023_dio_imc/data/db.dart';
import 'package:bootcamp_2023_dio_imc/enums/enums.dart';
import 'package:bootcamp_2023_dio_imc/model/imc_today.dart';
import 'package:bootcamp_2023_dio_imc/model/pessoa.dart';
import 'package:bootcamp_2023_dio_imc/repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../util/math_util.dart';

class HomePageController extends ChangeNotifier {
  late final DataRepository dataRepository;

  HomePageController() {
    _initDataRepository().then((value) => init());
  }

  Future<void> _initDataRepository() async {
    final db = await DB.instance.database;
    dataRepository = DataRepository(db);
  }

  List<ImcToday> _listaImc = [];

  Pessoa _pessoaAtual = Pessoa.empty();

  void init() async {
    debugPrint('init- lançado');
    Pessoa? pessoa = await dataRepository.getPessoa();
    debugPrint(pessoa.toString());
    _listaImc = await dataRepository.getImcTodayList();
    debugPrint(_listaImc.toString());

    if (pessoa != null) {
      _pessoaAtual = pessoa;
      alturaSlider = pessoa.altura;
      pesoSlider = pessoa.peso;
      imc = MathUtil.calcularIMC(pesoSlider, alturaSlider);

      notifyListeners();
    } else {
      await dataRepository.salvarPessoa(_pessoaAtual);
      notifyListeners();
    }
  }

  final TextEditingController nameController = TextEditingController();

  double _alturaSlider = 170;
  set alturaSlider(double altura) {
    _alturaSlider = altura;
  }

  double get alturaSlider => _alturaSlider;

  double _pesoSlider = 62;
  set pesoSlider(double peso) => _pesoSlider = peso;
  double get pesoSlider => _pesoSlider;

  double _imc = 0;

  set imc(double imc) => _imc = imc;
  double get imc => _imc;

  ImcStatus _imcStatus = ImcStatus.saudavel;
  ImcStatus get imcStatus => _imcStatus;
  set imcStatus(ImcStatus imcStatus) => _imcStatus = imcStatus;

  String _imcMessage = ImcController.imcStatusMessage(ImcStatus.saudavel);

  String get imcMessage => _imcMessage;
  set imcMessage(String msg) => _imcMessage = msg;

  String _imcImage = ImcController.imcImage(ImcStatus.saudavel);
  String get imcImage => _imcImage;
  set imcImage(String src) => _imcImage = src;

  void loaderImc() {
    imc = MathUtil.calcularIMC(pesoSlider, alturaSlider);
    imcStatus = ImcController.imcStatus(imc);
    imcMessage = ImcController.imcStatusMessage(imcStatus);
    imcImage = ImcController.imcImage(imcStatus);
    notifyListeners();
    debugPrint(_pessoaAtual.toString());
  }

  void saveImc() {
    loaderImc();

    ImcToday imcToday =
        ImcToday.empty().copyWith(dateTime: DateTime.now(), imc: imc);
    _addListImc(imcToday);
    setPeso(peso: pesoSlider);
    setAltura(altura: alturaSlider);
  }

  String get nome => _pessoaAtual.nome;
  double get peso => _pessoaAtual.peso;
  double get altura => _pessoaAtual.altura;

  List<ImcToday> get getListImc => [..._listaImc];

  void _addListImc(ImcToday imcToday) {
    if (!_listaImc.contains(imcToday)) {
      dataRepository.salvarImcToday(imcToday);
      _listaImc.add(imcToday);
      notifyListeners();
    }
  }

  void setNome({required String nome}) async {
    await dataRepository.updatePessoa(_pessoaAtual.copyWith(nome: nome));
    init();
  }

  void setPeso({required double peso}) async {
    await dataRepository.updatePessoa(_pessoaAtual.copyWith(peso: peso));

    init();
  }

  void setAltura({required double altura}) async {
    await dataRepository.updatePessoa(_pessoaAtual.copyWith(altura: altura));
    init();
  }
}
