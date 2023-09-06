// ignore_for_file: unnecessary_getters_setters

import 'dart:convert';

import 'package:uuid/uuid.dart';

import 'package:bootcamp_2023_dio_imc/model/imc_today.dart';

class Pessoa {
  Uuid _id = const Uuid();
  String? nome;
  double? peso;
  double? altura;
  List<ImcToday>? listaImc;

  Pessoa({
    this.nome,
    this.peso,
    this.altura,
    this.listaImc,
  });

  Uuid get id => _id;

  set id(Uuid uuid) => _id = uuid;

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'peso': peso,
      'altura': altura,
      'listaImc': listaImc?.map((x) => x.toMap()).toList(),
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
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pessoa.fromJson(String source) => Pessoa.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Pessoa(nome: $nome, peso: $peso, altura: $altura, listaImc: $listaImc)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Pessoa && other._id == _id;
  }

  @override
  int get hashCode {
    return _id.hashCode;
  }
}
