import 'package:json_annotation/json_annotation.dart';
part 'ais.g.dart';
@JsonSerializable()
class AIS {
  final int MMSI;
  final String TIMESTAMP;
  final double LATITUDE;
  final double LONGITUDE;
  final double COURSE;
  final double SPEED;
  final int HEADING;
  final int NAVSTAT;
  final int IMO;
  final String NAME;
  final String CALLSIGN;
  final int TYPE;
  final int A;
  final int B;
  final int C;
  final int D;
  final double DRAUGHT;
  final String DESTINATION;
  final String ETA_AIS;
  final String ETA;
  final String SRC;
  final String ZONE;
  final bool ECA;

  AIS({
    this.MMSI,
    this.TIMESTAMP,
    this.LATITUDE,
    this.LONGITUDE,
    this.COURSE,
    this.SPEED,
    this.HEADING,
    this.NAVSTAT,
    this.IMO,
    this.NAME,
    this.CALLSIGN,
    this.TYPE,
    this.A,
    this.B,
    this.C,
    this.D,
    this.DRAUGHT,
    this.DESTINATION,
    this.ETA_AIS,
    this.ETA,
    this.SRC,
    this.ZONE,
    this.ECA});

factory AIS.fromJson(Map<String,dynamic> data) => _$AISFromJson(data);

Map<String,dynamic> toJson() => _$AISToJson(this);


}