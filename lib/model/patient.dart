import 'package:json_annotation/json_annotation.dart';

import 'base_entity.dart';
import 'country.dart';
import 'education_level.dart';
import 'marital_status.dart';
import 'nationality.dart';
import 'occupation.dart';

part 'patient.g.dart';

@JsonSerializable(explicitToJson: true)
class Patient {
  int id;
  String firstName;

  String lastName;
  String personId;
  String nationalId;
  Country country;
  EducationLevel educationLevel;
  MaritalStatus maritalStatus;
  Nationality nationality;
  Occupation occupation;

  Patient();

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);

  Map<String, dynamic> toJson() => _$PatientToJson(this);

  static mapFromJson(List dynamicList) {
    List<Patient> patientList = [];
    if (dynamicList != null) {
      dynamicList.forEach((e) {
        Patient patient = Patient.fromJson(e);
        patientList.add(patient);
      });
    }
    return patientList;
  }

  @override
  String toString() {
    return super.toString() +
        'Patient{personId: $personId, nationalId: $nationalId}';
  }
}
