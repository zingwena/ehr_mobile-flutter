import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'discharge_patient.g.dart';

@JsonSerializable()
class DischargePatient {
  String visitId;
  DateTime dischargeDate;

  DischargePatient(String visitId, DateTime dischargeDate) {
    this.visitId = visitId;
    this.dischargeDate = dischargeDate;
  }

  factory DischargePatient.fromJson(Map<String, dynamic> json) =>
      _$DischargePatientFromJson(json);

  Map<String, dynamic> toJson() => _$DischargePatientToJson(this);

  static List<DischargePatient> mapFromJson(List dynamicList) {
    List<DischargePatient> list = [];
    if (dynamicList != null) {
      dynamicList.forEach((e) {
        DischargePatient dischargePatient = DischargePatient.fromJson(e);
        list.add(dischargePatient);
      });
    }
    return list;
  }

  static List<DischargePatient> fromJsonDecodedMap(List dynamicList) {
    List<DischargePatient> dischargePatientList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        DischargePatient dischargePatient = DischargePatient.fromJson(e);
        dischargePatientList.add(dischargePatient);
      });
    }
  }
}
