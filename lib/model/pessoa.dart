// ignore_for_file: unnecessary_getters_setters

import 'dart:convert';
import 'package:bootcamp_2023_dio_imc/model/imc_today.dart';

class Pessoa {
  String? nome;
  double? peso;
  double? altura;
  List<ImcToday> _listaImc = [];

 

  Pessoa.empty() {
    nome = 'Person01';
    peso = 62;
    altura = 170;
    _listaImc = <ImcToday>[];
  }

  Pessoa({
    this.nome,
    this.peso,
    this.altura,
    listaImc,
  }) {
    _listaImc = listaImc ?? [];
  }

  List<ImcToday> get getListImc => [..._listaImc];
  void addListImc(ImcToday imcToday) {
    if (!_listaImc.contains(imcToday)) {
      _listaImc.add(imcToday);
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'peso': peso,
      'altura': altura,
      'listaImc': _listaImc.map((x) => x.toMap()).toList(),
    };
  }

  factory Pessoa.fromMap(Map<String, dynamic> map) {
    return Pessoa(
      nome: map['nome'],
      peso: map['peso']?.toDouble(),
      altura: map['altura']?.toDouble(),
      listaImc: map['listaImc'] != null
          ? List<ImcToday>.from(
              map['listaImc']?.map((x) => ImcToday.fromMap(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Pessoa.fromJson(String source) => Pessoa.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Pessoa(nome: $nome, peso: $peso, altura: $altura, listaImc: $_listaImc)';
  }
}
