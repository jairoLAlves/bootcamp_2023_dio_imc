import 'package:bootcamp_2023_dio_imc/model/pessoa.dart';
import 'package:flutter/cupertino.dart';

class ListImcPage extends StatefulWidget {
  final Pessoa pessoa;
  const ListImcPage({super.key, required this.pessoa});

  @override
  State<ListImcPage> createState() => _ListImcPageState();
}

class _ListImcPageState extends State<ListImcPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        child: ListView(
          children: widget.pessoa.listaImc
                  ?.map((e) => Text("${e.dateTime} : ${e.imc}"))
                  .toList() ??
              [],
        ),
      ),
    );
  }
}
