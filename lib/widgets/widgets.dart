import 'package:bootcamp_2023_dio_imc/controller/home_page_controller.dart';
import 'package:bootcamp_2023_dio_imc/model/imc_today.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';

Widget createItemImcList(Key key, ImcToday imcItem) {
  return Consumer<HomePageController>(
    builder: (context, value, _) => Dismissible(
      key: key,
      onDismissed: (_) {
        value.removeListImc(imcItem.id!);
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(child: Text('${imcItem.imc.round()}')),
          trailing: Text(
              'Data: ${DateFormat('dd/mm/yyyy').format(imcItem.dateTime)}'),
        ),
      ),
    ),
  );
}

Widget createImgImc({required String image}) {
  return Consumer<HomePageController>(
    builder: (context, value, _) => SvgPicture.asset(
        placeholderBuilder: (_) =>
            const Center(child: CircularProgressIndicator()),
        image),
  );
}
