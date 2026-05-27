import 'package:cloud_firestore/cloud_firestore.dart';

class QR {
  String articuloId;
  Timestamp creadoEn;

  QR({
    required this.articuloId,
    Timestamp? creadoEn,
  }) : creadoEn = creadoEn ?? Timestamp.fromDate(DateTime.now());

  QR.fromJson(Map<String, Object?> json)
      : articuloId = json['articuloId']! as String,
        creadoEn = _parseTimestamp(json['creadoEn']);

  QR copyWith({
    String? articuloId,
    Timestamp? creadoEn,
  }) {
    return QR(
      articuloId: articuloId ?? this.articuloId,
      creadoEn: creadoEn ?? this.creadoEn,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'articuloId': articuloId,
      'creadoEn': creadoEn,
    };
  }

  static Timestamp _parseTimestamp(Object? value) {
    if (value is Timestamp) return value;
    if (value is DateTime) return Timestamp.fromDate(value);
    return Timestamp.fromDate(DateTime.now());
  }
}
