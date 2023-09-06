import 'dart:convert';

class ImcToday {
  DateTime dateTime;
  double imc;
  ImcToday(
    this.dateTime,
    this.imc,
  );

  ImcToday copyWith({
    DateTime? dateTime,
    double? imc,
  }) {
    return ImcToday(
      dateTime ?? this.dateTime,
      imc ?? this.imc,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime.millisecondsSinceEpoch,
      'imc': imc,
    };
  }

  factory ImcToday.fromMap(Map<String, dynamic> map) {
    return ImcToday(
      DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      map['imc']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImcToday.fromJson(String source) =>
      ImcToday.fromMap(json.decode(source));

  @override
  String toString() => 'ImcToday(dateTime: $dateTime, imc: $imc)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImcToday && other.dateTime == dateTime;
  }

  @override
  int get hashCode => dateTime.hashCode;
}
