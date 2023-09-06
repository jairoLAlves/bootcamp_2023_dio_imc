import 'package:bootcamp_2023_dio_imc/enums/enums.dart';

class ImcController {
  static ImcStatus imcStatus(double imc) => switch (imc) {
        < 16 => ImcStatus.magrezaGrave,
        >= 16 && < 17 => ImcStatus.magrezaModerada,
        >= 17 && < 18.5 => ImcStatus.magrezaLeve,
        >= 18.5 && < 25 => ImcStatus.saudavel,
        >= 25 && < 30 => ImcStatus.sobrepeso,
        >= 30 && < 35 => ImcStatus.sobrepesoGrau_1,
        >= 35 && < 40 => ImcStatus.obesidadeGrau_2,
        > 40 => ImcStatus.obesidadeGrau_3,
        _ => ImcStatus.nan,
      };

  static String imcStatusMessage(ImcStatus imcStatus) => switch (imcStatus) {
        ImcStatus.magrezaGrave => 'Magreza Grave',
        ImcStatus.magrezaModerada => 'Magreza  Moderada',
        ImcStatus.magrezaLeve => 'Magreza Leve',
        ImcStatus.saudavel => 'Saudável',
        ImcStatus.sobrepeso => 'Sobrepeso',
        ImcStatus.sobrepesoGrau_1 => 'Sobrepeso Grau 1',
        ImcStatus.obesidadeGrau_2 => 'Obesidade Grau 2 (Severa) ',
        ImcStatus.obesidadeGrau_3 => 'Obesidade Grau 3 (Mórbida)',
        ImcStatus.nan => 'Não foi possível obter o status do IMC',
      };

  static String imcImage(ImcStatus imcStatus) {
    const String baseUrl = 'https://svgsilh.com/svg/';

    return switch (imcStatus) {
      ImcStatus.magrezaGrave => '${baseUrl}3378748.svg',
      ImcStatus.magrezaModerada => '${baseUrl}146310.svg',
      ImcStatus.magrezaLeve => '${baseUrl}1158318.svg',
      ImcStatus.saudavel || ImcStatus.nan => '${baseUrl}1417046.svg',
      ImcStatus.sobrepeso => '${baseUrl}30252.svg',
      ImcStatus.sobrepesoGrau_1 => '${baseUrl}46922.svg',
      ImcStatus.obesidadeGrau_2 => '${baseUrl}311319.svg',
      ImcStatus.obesidadeGrau_3 => '${baseUrl}47599.svg'
    };
  }
}
