// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ais.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIS _$AISFromJson(Map<String, dynamic> json) {
  return AIS(
    MMSI: json['MMSI'] as int,
    TIMESTAMP: json['TIMESTAMP'] as String,
    LATITUDE: (json['LATITUDE'] as num)?.toDouble(),
    LONGITUDE: (json['LONGITUDE'] as num)?.toDouble(),
    COURSE: (json['COURSE'] as num)?.toDouble(),
    SPEED: (json['SPEED'] as num)?.toDouble(),
    HEADING: json['HEADING'] as int,
    NAVSTAT: json['NAVSTAT'] as int,
    IMO: json['IMO'] as int,
    NAME: json['NAME'] as String,
    CALLSIGN: json['CALLSIGN'] as String,
    TYPE: json['TYPE'] as int,
    A: json['A'] as int,
    B: json['B'] as int,
    C: json['C'] as int,
    D: json['D'] as int,
    DRAUGHT: (json['DRAUGHT'] as num)?.toDouble(),
    DESTINATION: json['DESTINATION'] as String,
    ETA_AIS: json['ETA_AIS'] as String,
    ETA: json['ETA'] as String,
    SRC: json['SRC'] as String,
    ZONE: json['ZONE'] as String,
    ECA: json['ECA'] as bool,
  );
}

Map<String, dynamic> _$AISToJson(AIS instance) => <String, dynamic>{
      'MMSI': instance.MMSI,
      'TIMESTAMP': instance.TIMESTAMP,
      'LATITUDE': instance.LATITUDE,
      'LONGITUDE': instance.LONGITUDE,
      'COURSE': instance.COURSE,
      'SPEED': instance.SPEED,
      'HEADING': instance.HEADING,
      'NAVSTAT': instance.NAVSTAT,
      'IMO': instance.IMO,
      'NAME': instance.NAME,
      'CALLSIGN': instance.CALLSIGN,
      'TYPE': instance.TYPE,
      'A': instance.A,
      'B': instance.B,
      'C': instance.C,
      'D': instance.D,
      'DRAUGHT': instance.DRAUGHT,
      'DESTINATION': instance.DESTINATION,
      'ETA_AIS': instance.ETA_AIS,
      'ETA': instance.ETA,
      'SRC': instance.SRC,
      'ZONE': instance.ZONE,
      'ECA': instance.ECA,
    };
